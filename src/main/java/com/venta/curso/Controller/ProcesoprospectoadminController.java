package com.venta.curso.Controller;

import com.venta.curso.Interface.ProspectoInterface;
import com.venta.curso.Interface.SessionInterface;
import com.venta.curso.Validation.Validation;
import jakarta.servlet.ServletContext;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

/**
 *
 * @author Asus
 */
@Controller
@RequiredArgsConstructor
public class ProcesoprospectoadminController {

    private final ProspectoInterface prospectointer;
    private final SessionInterface sesInterface;
    private final ServletContext servletContext;

    Validation val = new Validation();

    @GetMapping("/procesoprospectoadmin")
    public String Prospecto() {
        return "procesoprospectoadmin";
    }

    @GetMapping("procesoprospectoadmin/musuario")
    @ResponseBody
    public List getusuario() {
        return prospectointer.getusers();
    }

    @GetMapping("procesoprospectoadmin/verificasesion")
    @ResponseBody
    public Map Verificasesion(@RequestParam("usu") String usu) {
        Map validacion = new HashMap();
        if (sesInterface.verificasessionabi(usu) == 1) {
            validacion.put("resp", "si");
        } else {
            validacion.put("resp", "no");
        }
        return validacion;
    }

    @GetMapping("procesoprospectoadmin/mostrar")
    @ResponseBody
    public List Prospectomostrar(@RequestParam("usu") String usu) {
        return prospectointer.getProspectoasesornoverificado(usu);
    }

    @GetMapping("procesoprospectoadmin/mostrarver")
    @ResponseBody
    public List Prospectovermostrar(@RequestParam("usu") String usu) {
        return prospectointer.getProspectoasesorverificado(usu);
    }

    @PostMapping("procesoprospectoadmin/actualizarestado")
    @ResponseBody
    public void Prospectomostrar(@RequestParam("esta") String esta, @RequestParam("idpro") String idpro, @RequestParam("iddetpro") String iddetpro) {
        prospectointer.Actualizarpveri(iddetpro);
        int dias = 0;
        if (esta.equalsIgnoreCase("CALIENTE")) {
            dias = 0;
        }
        if (esta.equalsIgnoreCase("TIBIO")) {
            dias = -4;
        }
        if (esta.equalsIgnoreCase("FRIO")) {
            dias = -9;
        }
        prospectointer.cambiarestatiempo(idpro, esta, dias);
    }

    @PostMapping("procesoprospectoadmin/actualizar")
    @ResponseBody
    public void Prospectoactualizar(@RequestParam("iddetpro") String iddetpro) {
        prospectointer.Actualizarpnoveri(iddetpro);
    }

    @GetMapping("procesoprospectoadmin/mcurso")
    @ResponseBody
    public List getCurso() {
        return prospectointer.getCurso();
    }

    @GetMapping("procesoprospectoadmin/mpaquete")
    @ResponseBody
    public List getPaquete() {
        return prospectointer.getPaquete();
    }

    @PostMapping("procesoprospectoadmin/guardar")
    @ResponseBody
    public Map guardar(@RequestParam("usu") String usu, @RequestParam("curpaq") String curpaq, @RequestParam("tipo") String tipo, @RequestParam("detpro") String detpro) {
        Map validacion = new HashMap();
        if (curpaq.equalsIgnoreCase("0")) {
            if (tipo.equalsIgnoreCase("CURSO")) {
                validacion.put("curpaq", "Seleccione un curso");
            }
            if (tipo.equalsIgnoreCase("PAQUETE")) {
                validacion.put("curpaq", "Seleccione un paquete");
            }
        }
        if (validacion.isEmpty()) {
            int idses = sesInterface.getidsession(usu);
            String resp = prospectointer.procesoprematricula(curpaq, tipo, String.valueOf(idses), detpro).get(0).get("resp").toString();
            validacion.put("resp", "si");
            validacion.put("proc", resp);
        } else {
            validacion.put("resp", "no");
        }
        return validacion;
    }

    @GetMapping("procesoprospectoadmin/mbanco")
    @ResponseBody
    public List getBanco() {
        return prospectointer.getbanco();
    }

    @PostMapping("procesoprospectoadmin/finalizar")
    @ResponseBody
    public Map prematricula(@RequestParam("usu") String usu, @RequestParam("cli") String cli, @RequestParam("tip") String tip, @RequestParam("detpro") String detpro,
            @RequestParam(name = "vau") MultipartFile file, @RequestParam(name = "ban") String ban) {
        Map validacion = new HashMap();

        String ext = file.getOriginalFilename().toLowerCase();
        if (!ext.endsWith("png") && !ext.endsWith(".jpg") && !ext.endsWith(".jpeg")) {
            validacion.put("vau", "Solo esta permitido imagen con extensión .png, .jpg y jpeg");
        }

        if (ban.equalsIgnoreCase("0")) {
            validacion.put("ban", "Seleccione un banco");
        }
        if (!val.vacio(cli)) {
            validacion.put("cli", "El campo Cliente es obligatorio");
        }
        if (tip.equalsIgnoreCase("0")) {
            validacion.put("tip", "Seleccione un tipo de matrícula");
        }
        if (validacion.isEmpty()) {
            try {
                String rootDirectory = servletContext.getRealPath("/");
                File uploadDir = new File(rootDirectory + "uploads");
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }
                String uniqueFilename = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
                String filePath = uploadDir.getAbsolutePath() + File.separator + uniqueFilename;
                file.transferTo(new File(filePath));
                int idses = sesInterface.getidsession(usu);
                prospectointer.prematricula(cli, String.valueOf(idses), tip, detpro, ban, uniqueFilename);
                validacion.put("resp", "si");
            } catch (IOException e) {
            }
        } else {
            validacion.put("resp", "no");
        }
        return validacion;
    }

    @GetMapping("procesoprospectoadmin/comanda")
    @ResponseBody
    public List guardar(@RequestParam("usu") String usu, @RequestParam("iddetpro") String iddetpro) {
        int idses = sesInterface.getidsession(usu);
        return prospectointer.getComanda(String.valueOf(idses), iddetpro);
    }

    @PostMapping("procesoprospectoadmin/eliminacomanda")
    @ResponseBody
    public void elimina(@RequestParam("idco") String idco) {
        prospectointer.eliminarcomanda(idco);
    }

    @GetMapping("procesoprospectoadmin/paquetecurso")
    @ResponseBody
    public List getPaquetecurso(@RequestParam("idpaq") String idpaq) {
        return prospectointer.getPaquetecurso(idpaq);
    }
}
