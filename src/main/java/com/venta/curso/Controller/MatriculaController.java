package com.venta.curso.Controller;

import com.venta.curso.Config.Info;
import com.venta.curso.Interface.MatriculaInterface;
import com.venta.curso.Interface.VaucherInterface;
import com.venta.curso.Validation.Numero_a_Letra;
import com.venta.curso.Validation.Validation;
import jakarta.servlet.ServletContext;
import java.io.File;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.io.IOException;
import java.net.MalformedURLException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;
import org.json.JSONException;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import org.springframework.web.multipart.MultipartFile;

/**
 *
 * @author Asus
 */
@Controller
@RequiredArgsConstructor
public class MatriculaController {

    private final MatriculaInterface matriculainter;
    private final ServletContext servletContext;
    Validation val = new Validation();
    Numero_a_Letra convertir = new Numero_a_Letra();

    private final VaucherInterface vaucherinter;

    @GetMapping("/matricula")
    public String ProcesoMatricula() {
        return "matricula";
    }

    @GetMapping("matricula/mmatricula")
    @ResponseBody
    public List getPrematricula() {
        return matriculainter.getPrematricula();
    }

    @GetMapping("matricula/mvaucher/{mat}")
    @ResponseBody
    public List getVaucher(@PathVariable String mat) {
        return vaucherinter.getVaucher(mat);
    }

    @PostMapping("matricula/verificar")
    @ResponseBody
    public Map Verificar(@RequestParam(name = "mat") String mat, @RequestParam(name = "tip") String tip, @RequestParam(name = "num") String num, @RequestParam(name = "ev") String ev) {
        Map validacion = new HashMap();
        String json="";
        String resp = "";
        
        if (ev.equalsIgnoreCase("1")) {
            matriculainter.verificar(mat, tip, num, ev, "0").get(0).get("resp");
            resp = "La matrícula se verificó correctamente";
            validacion.put("envio", "no");
            validacion.put("resp", resp);
        }
        if (ev.equalsIgnoreCase("2")) {
            try {
                resp = matriculainter.verificar(mat, tip, num, ev, "0").get(0).get("resp");
                 json = matriculainter.penvio(getBody(mat));
                 
                org.json.JSONObject jsonObject = new org.json.JSONObject(json);
                org.json.JSONObject data = jsonObject.getJSONObject("data");
                org.json.JSONObject sunatResponse = data.getJSONObject("sunatResponse");
                org.json.JSONObject cdrResponse = sunatResponse.getJSONObject("cdrResponse");
                String description = cdrResponse.getString("description");
                org.json.JSONArray notes = cdrResponse.getJSONArray("notes");
                String notas = "";
                if (notes.length() > 0) {
                    for (int i = 0; i < notes.length(); i++) {
                        if (notas.length() == 0) {
                            notas = notes.getString(i);
                        } else {
                            notas = notas + "-" + notes.getString(i);
                        }
                    }
                    matriculainter.actualizarcomprobante(resp, description, notas);
                } else {
                    matriculainter.actualizarcomprobante(resp, description, "");
                }
                validacion.put("envio", "si");
                validacion.put("resp", resp);
                validacion.put("respuesta pi",json);
            } catch (Exception e) {
                validacion.put("tujson", getBody(mat));
                matriculainter.verificar(mat, "0", "", "3", resp);
                validacion.put("envio", "no");
                validacion.put("resp", e.getMessage());
                //validacion.put("resp", "Este documento ya se encuentra declarado en la SUNAT");
            }
        }
        return validacion;
    }

    @PostMapping("matricula/cancelar")
    @ResponseBody
    public Map Cancelar(@RequestParam(name = "mat") String mat, @RequestParam(name = "des") String des) {
        Map validacion = new HashMap();
        if (!val.vacio(des)) {
            validacion.put("des", "El campo Descripción es obligatorio");
        }
        if (validacion.isEmpty()) {
            matriculainter.cancelar(mat, des);
            validacion.put("resp", "si");
        } else {
            validacion.put("resp", "no");
        }
        return validacion;
    }

    @PostMapping("matricula/cancelarall")
    @ResponseBody
    public Map Cancelarall(@RequestParam(name = "mat") String mat, @RequestParam(name = "files") MultipartFile[] files, @RequestParam(name = "des") String des) {
        Map validacion = new HashMap();
        if (files != null) {
            for (MultipartFile file : files) {
                String ext = file.getOriginalFilename().toLowerCase();
                if (!ext.endsWith("png") && !ext.endsWith(".jpg") && !ext.endsWith(".jpeg")) {
                    validacion.put("vau", "Solo esta permitido imagen con extensión .png, .jpg y jpeg");
                }
            }
        }
        if (!val.vacio(des)) {
            validacion.put("des", "El campo Descripción es obligatorio");
        }
        if (validacion.isEmpty()) {
            try {
                matriculainter.cancelar(mat, des);
                for (MultipartFile file : files) {
                    if (!file.isEmpty()) {
                        String rootDirectory = servletContext.getRealPath("/");
                        File uploadDir = new File(rootDirectory + "uploads");
                        if (!uploadDir.exists()) {
                            uploadDir.mkdirs();
                        }
                        String uniqueFilename = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
                        String filePath = uploadDir.getAbsolutePath() + File.separator + uniqueFilename;
                        file.transferTo(new File(filePath));
                        vaucherinter.save(uniqueFilename, mat);
                    }
                }
                validacion.put("resp", "si");
            } catch (IOException e) {
            }
        } else {
            validacion.put("resp", "no");
        }

        return validacion;
    }

    @GetMapping("matricula/images/{filename:.+}")
    public ResponseEntity<Resource> getImagematricula(@PathVariable String filename) {
        try {
            // Obtener la ruta del directorio raíz del servidor
            String rootDirectory = servletContext.getRealPath("/");
            Path filePath = Paths.get(rootDirectory + "uploads").resolve(filename).normalize();
            Resource resource = new UrlResource(filePath.toUri());

            if (resource.exists() && resource.isReadable()) {
                return ResponseEntity.ok()
                        .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + resource.getFilename() + "\"")
                        .body(resource);
            } else {
                return ResponseEntity.status(404).body(null);
            }
        } catch (MalformedURLException e) {
            e.printStackTrace();
            return ResponseEntity.status(500).body(null);
        }
    }

    @GetMapping("matricula/mtipocomprobante")
    @ResponseBody
    public List gettipocomprobante() {
        return matriculainter.getTipocomprobante();
    }

    @GetMapping("matricula/mnumero")
    @ResponseBody
    public List getnumero(@RequestParam(name = "tipo") String tipcom) {
        return matriculainter.getNumero(tipcom);
    }

    public String getBody(String mat) {
        List<Map<String, Object>> lisven = matriculainter.getventa(mat);
        List<Map<String, Object>> lisdetven = matriculainter.getdetventa(mat);

        String fectim = lisven.get(0).get("fecmat").toString() + " " + lisven.get(0).get("horamat").toString();

        JSONObject objetoCabecera = new JSONObject();
        objetoCabecera.put("tipo_Operacion", "0101");
        objetoCabecera.put("tipo_Doc", lisven.get(0).get("codtipcom").toString());
        objetoCabecera.put("serie", lisven.get(0).get("serie").toString());
        objetoCabecera.put("correlativo", val.factnumero(lisven.get(0).get("num").toString(), 8));
        objetoCabecera.put("tipo_Moneda", "PEN");
        objetoCabecera.put("fecha_Emision", val.getfec(fectim));

        objetoCabecera.put("empresa_Ruc", Info.ruc);

        String tipdoc ;
        String numdoc ;
        if (lisven.get(0).get("tipocli").toString().equalsIgnoreCase("DNI")) {
            tipdoc = "1";
            numdoc = lisven.get(0).get("documento").toString();
        } else {
            tipdoc = "6";
            numdoc = lisven.get(0).get("documento").toString();
        }

        objetoCabecera.put("cliente_Tipo_Doc", tipdoc);
        objetoCabecera.put("cliente_Num_Doc", numdoc);
        objetoCabecera.put("cliente_Razon_Social", lisven.get(0).get("nombre").toString());
        objetoCabecera.put("cliente_Direccion", lisven.get(0).get("dir").toString());
        
        if (lisven.get(0).get("bandesc").toString().equalsIgnoreCase("SI")) {
            
            JSONArray listades = new JSONArray();
            JSONObject desc = new JSONObject();
            desc.put("cod_Tipo", "02");
            desc.put("factor", lisven.get(0).get("fac").toString());
            desc.put("monto", lisven.get(0).get("desenv").toString());
            desc.put("monto_Base", lisven.get(0).get("mbase").toString());
            listades.add(desc);
            objetoCabecera.put("descuento", listades);
        }
        objetoCabecera.put("monto_Oper_Gravadas", lisven.get(0).get("msigv_ven").toString());
        
        objetoCabecera.put("monto_Igv", lisven.get(0).get("igv").toString());
        objetoCabecera.put("total_Impuestos", lisven.get(0).get("igv").toString());
        objetoCabecera.put("valor_Venta", lisven.get(0).get("msigv_ven").toString());
        objetoCabecera.put("sub_Total", lisven.get(0).get("mcigv_ven").toString());
        objetoCabecera.put("monto_Imp_Venta", lisven.get(0).get("mcigv_ven").toString());
        objetoCabecera.put("monto_Oper_Exoneradas", "0");

        objetoCabecera.put("estado_Documento", "0");
        objetoCabecera.put("manual", false);
        objetoCabecera.put("id_Base_Dato", lisven.get(0).get("idmatricula").toString());

        JSONArray lista = new JSONArray();
        for (Map<String, Object> ldven : lisdetven) {
            JSONObject detalle_linea_1 = new JSONObject();
            detalle_linea_1.put("unidad", "NIU");
            detalle_linea_1.put("cantidad", "1");
            detalle_linea_1.put("cod_Producto", "-");
            detalle_linea_1.put("descripcion", ldven.get("curpaq").toString());
            detalle_linea_1.put("monto_Valor_Unitario", ldven.get("valorven").toString());
            detalle_linea_1.put("monto_Base_Igv", ldven.get("valorven").toString());
            detalle_linea_1.put("porcentaje_Igv", "18");
            detalle_linea_1.put("igv", ldven.get("igv").toString());
            detalle_linea_1.put("tip_Afe_Igv", "10");
            detalle_linea_1.put("total_Impuestos", ldven.get("igv").toString());
            detalle_linea_1.put("monto_Precio_Unitario", ldven.get("precio").toString());
            detalle_linea_1.put("monto_Valor_Venta", ldven.get("valorven").toString());
            detalle_linea_1.put("factor_Icbper", "0");
            lista.add(detalle_linea_1);
        }

        objetoCabecera.put("detalle", lista);

        JSONArray listafor = new JSONArray();
        JSONObject formpag = new JSONObject();
        formpag.put("tipo", "Contado");
        formpag.put("monto", lisven.get(0).get("mcigv_ven").toString());
        formpag.put("cuota", 0);
        formpag.put("fecha_Pago", val.getfec(fectim));

        listafor.add(formpag);
        objetoCabecera.put("forma_pago", listafor);

        JSONArray listaleg = new JSONArray();
        JSONObject leg = new JSONObject();
        leg.put("legend_Code", "1000");
        leg.put("legend_Value", convertir.Convertir(lisven.get(0).get("mcigv_ven").toString(), true));
        listaleg.add(leg);
        objetoCabecera.put("legend", listaleg);

        return objetoCabecera.toString();

    }
}
