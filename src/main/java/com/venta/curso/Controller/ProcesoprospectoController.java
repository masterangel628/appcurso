package com.venta.curso.Controller;

import com.venta.curso.Entity.UserEntity;
import com.venta.curso.Interface.ProspectoInterface;
import com.venta.curso.Interface.SessionInterface;
import com.venta.curso.Interface.UserInterface;
import com.venta.curso.Interface.VaucherInterface;
import com.venta.curso.Validation.Validation;
import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import javax.sql.DataSource;
import lombok.RequiredArgsConstructor;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
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
public class ProcesoprospectoController {

    private final ProspectoInterface prospectointer;
    private final UserInterface userInterface;
    private final SessionInterface sesInterface;
    private final ServletContext servletContext;

    private final VaucherInterface vauInterface;

    @Autowired
    private DataSource dataSource;

    Validation val = new Validation();

    @GetMapping("/procesoprospecto")
    public String Prospecto() {
        return "procesoprospecto";
    }

    @GetMapping("procesoprospecto/verificasesion")
    @ResponseBody
    public Map Verificasesion() {
        Map validacion = new HashMap();
        UserEntity usu = userInterface.getinfouser();
        if (sesInterface.verificasessionabi(String.valueOf(usu.getId())) == 1) {
            validacion.put("resp", "si");
        } else {
            validacion.put("resp", "no");
        }
        return validacion;
    }

    @GetMapping("procesoprospecto/mostrar")
    @ResponseBody
    public List Prospectonovmostrar() {
        UserEntity user = userInterface.getinfouser();
        return prospectointer.getProspectoasesorall(String.valueOf(user.getId()));
    }

    @GetMapping("procesoprospecto/mostrarver")
    @ResponseBody
    public List Prospectovermostrar() {
        UserEntity user = userInterface.getinfouser();
        return prospectointer.getProspectoasesorverificado(String.valueOf(user.getId()));
    }

    @PostMapping("procesoprospecto/actualizarestado")
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

    @PostMapping("procesoprospecto/actualizar")
    @ResponseBody
    public void Prospectoactualizar(@RequestParam("iddetpro") String iddetpro) {
        prospectointer.Actualizarpnoveri(iddetpro);
    }

    @GetMapping("procesoprospecto/mcurso")
    @ResponseBody
    public List getCurso() {
        return prospectointer.getCurso();
    }

    @PostMapping("procesoprospecto/actualizardesc")
    @ResponseBody
    public void actualizardesc(@RequestParam("des") String des, @RequestParam("idpro") String idpro) {
        if (des.trim().length() == 0) {
            prospectointer.actualizardesc("", idpro);
        } else {
            prospectointer.actualizardesc(des, idpro);
        }
    }

    @GetMapping("procesoprospecto/mpaquete")
    @ResponseBody
    public List getPaquete() {
        return prospectointer.getPaquete();
    }

    @GetMapping("procesoprospecto/pdf")
    @ResponseBody
    public void generateReport(HttpServletResponse response) throws JRException, IOException, SQLException {
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "inline; filename=reportmov.pdf");
        UserEntity usu = userInterface.getinfouser();
        ClassPathResource reportResource = new ClassPathResource("reports/reportmov.jrxml");
        JasperReport jasperReport = JasperCompileManager.compileReport(reportResource.getInputStream());
        String sub = reportResource.getFile().getParentFile().getAbsolutePath() + "/";
        Connection connection = dataSource.getConnection();
        Map<String, Object> parameters = new HashMap<>();
        parameters.put("usu", usu.getId());
        parameters.put("asesor", "Asesor: "+userInterface.getNombreusu(""+usu.getId())); 
        JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, parameters, connection);

        try (OutputStream out = response.getOutputStream()) {
            JasperExportManager.exportReportToPdfStream(jasperPrint, out);
        }
    }

    @PostMapping("procesoprospecto/guardar")
    @ResponseBody
    public Map guardar(@RequestParam("curpaq") String curpaq, @RequestParam("tipo") String tipo, @RequestParam("detpro") String detpro) {
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
            UserEntity usu = userInterface.getinfouser();
            int idses = sesInterface.getidsession(String.valueOf(usu.getId()));
            String resp = prospectointer.procesoprematricula(curpaq, tipo, String.valueOf(idses), detpro).get(0).get("resp").toString();
            validacion.put("resp", "si");
            validacion.put("proc", resp);
        } else {
            validacion.put("resp", "no");
        }
        return validacion;
    }

    @GetMapping("procesoprospecto/mbanco")
    @ResponseBody
    public List getBanco() {
        return prospectointer.getbanco();
    }

    @PostMapping("procesoprospecto/finalizar")
    @ResponseBody
    public Map prematricula(@RequestParam("cli") String cli, @RequestParam("tip") String tip, @RequestParam("detpro") String detpro,
            @RequestParam(name = "vau") MultipartFile[] files, @RequestParam(name = "ban") String ban) {
        Map validacion = new HashMap();

        if (files.length > 0) {
            for (MultipartFile file : files) {
                String ext = file.getOriginalFilename().toLowerCase();
                if (!ext.endsWith("png") && !ext.endsWith(".jpg") && !ext.endsWith(".jpeg")) {
                    validacion.put("vau", "Solo esta permitido imagen con extensión .png, .jpg y jpeg");
                }
            }
        } else {
            validacion.put("vau", "Seleccione una imagen");
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
                UserEntity usu = userInterface.getinfouser();
                int idses = sesInterface.getidsession(String.valueOf(usu.getId()));
                String val = prospectointer.prematricula(cli, String.valueOf(idses), tip, detpro, ban).get(0).get("resp").toString();

                for (MultipartFile file : files) {
                    String rootDirectory = servletContext.getRealPath("/");
                    File uploadDir = new File(rootDirectory + "uploads");
                    if (!uploadDir.exists()) {
                        uploadDir.mkdirs();
                    }
                    String uniqueFilename = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
                    String filePath = uploadDir.getAbsolutePath() + File.separator + uniqueFilename;
                    file.transferTo(new File(filePath));
                    vauInterface.save(uniqueFilename, val);
                }

                validacion.put("resp", "si");
            } catch (IOException e) {
            }
        } else {
            validacion.put("resp", "no");
        }
        return validacion;
    }

    @GetMapping("procesoprospecto/comanda")
    @ResponseBody
    public List guardar(@RequestParam("iddetpro") String iddetpro) {
        UserEntity usu = userInterface.getinfouser();
        int idses = sesInterface.getidsession(String.valueOf(usu.getId()));
        return prospectointer.getComanda(String.valueOf(idses), iddetpro);
    }

    @PostMapping("procesoprospecto/eliminacomanda")
    @ResponseBody
    public void elimina(@RequestParam("idco") String idco) {
        prospectointer.eliminarcomanda(idco);
    }

    @GetMapping("procesoprospecto/paquetecurso")
    @ResponseBody
    public List getPaquetecurso(@RequestParam("idpaq") String idpaq) {
        return prospectointer.getPaquetecurso(idpaq);
    }
}
