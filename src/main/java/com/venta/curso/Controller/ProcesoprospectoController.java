package com.venta.curso.Controller;

import com.venta.curso.Entity.UserEntity;
import com.venta.curso.Interface.ProspectoInterface;
import com.venta.curso.Interface.SessionInterface;
import com.venta.curso.Interface.UserInterface;
import com.venta.curso.Interface.VaucherInterface;
import com.venta.curso.Validation.Validation;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletOutputStream;
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

import net.sf.jasperreports.engine.JRException;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

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

    @PostMapping("procesoprospecto/guardarclicom")
    @ResponseBody
    public void GuardarClicom(@RequestParam("detpro") String detpro, @RequestParam("per") String per,
            @RequestParam("cli") String cli) {
        UserEntity usu = userInterface.getinfouser();
        int idses = sesInterface.getidsession(String.valueOf(usu.getId()));
        prospectointer.guardarClicom("" + idses, detpro, per, cli);

    }

    @GetMapping("procesoprospecto/mclicom")
    @ResponseBody
    public List getClicom(@RequestParam("detpro") String detpro) {
        UserEntity usu = userInterface.getinfouser();
        int idses = sesInterface.getidsession(String.valueOf(usu.getId()));
        return prospectointer.getClicom("" + idses, detpro);
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
    public Map prematricula(@RequestParam("descu") String descu, @RequestParam("band") String band, @RequestParam("tip") String tip, @RequestParam("detpro") String detpro,
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
        if (tip.equalsIgnoreCase("0")) {
            validacion.put("tip", "Seleccione un tipo de matrícula");
        }
        if (validacion.isEmpty()) {
            try {
                UserEntity usu = userInterface.getinfouser();
                int idses = sesInterface.getidsession(String.valueOf(usu.getId()));
                String val = prospectointer.prematricula(String.valueOf(idses), tip, detpro, ban, descu, band).get(0).get("resp");

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

    @GetMapping("procesoprospecto/montopre")
    @ResponseBody
    public String getMonto(@RequestParam("iddetpro") String iddetpro) {
        UserEntity usu = userInterface.getinfouser();
        int idses = sesInterface.getidsession(String.valueOf(usu.getId()));
        return prospectointer.getmontoprem(String.valueOf(idses), iddetpro);
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

    @GetMapping("procesoprospecto/excel")
    @ResponseBody
    public void generateReport(HttpServletResponse response) throws JRException, IOException, SQLException {
        response.setContentType("application/octet-stream");
        String headerKey = "Content-Disposition";
        String headerValue = "attachment; filename=clienteasignados.xlsx";
        response.setHeader(headerKey, headerValue);
        Row bodyRow;
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Clientes Asignados");
        sheet.setColumnWidth(0, 12000);
        sheet.setColumnWidth(1, 5000);
        sheet.setColumnWidth(2, 12000);
        // Crear el estilo de la celda de encabezado
        CellStyle headerCellStyle = workbook.createCellStyle();
        Font headerFont = workbook.createFont();
        headerFont.setBold(true);
        headerCellStyle.setFont(headerFont);
        headerCellStyle.setAlignment(HorizontalAlignment.CENTER);

        // Crear el estilo de la celda de encabezado
        CellStyle headerCellStylefull = workbook.createCellStyle();
        Font headerFontfull = workbook.createFont();
        headerFontfull.setBold(true);
        headerCellStylefull.setFont(headerFont);
        headerCellStylefull.setBorderBottom(BorderStyle.THIN);
        headerCellStylefull.setBorderTop(BorderStyle.THIN);
        headerCellStylefull.setBorderRight(BorderStyle.THIN);
        headerCellStylefull.setBorderLeft(BorderStyle.THIN);
        headerCellStylefull.setAlignment(HorizontalAlignment.CENTER);

        bodyRow = sheet.createRow(0);
        Cell celltitulo = bodyRow.createCell(0);
        celltitulo.setCellStyle(headerCellStyle);
        celltitulo.setCellValue("Reporte de Clientes asignados");
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 4));
        UserEntity usu = userInterface.getinfouser();
        bodyRow = sheet.createRow(1);
        Cell cellfec = bodyRow.createCell(0);
        cellfec.setCellStyle(headerCellStyle);
        cellfec.setCellValue("Asesor: " + userInterface.getNombreusu("" + usu.getId())+"                    Fecha: "+prospectointer.fecactual());
        sheet.addMergedRegion(new CellRangeAddress(1, 1, 0, 4));

        List<Map<String, Object>> lisvent = prospectointer.getClienteAsig(""+usu.getId()); 
        int rowCount = 3;

        String[] columnHeaders = {"Nombre", "Celular", "Descripción"};
        bodyRow = sheet.createRow(2);
        for (int i = 0; i < columnHeaders.length; i++) {
            Cell cell = bodyRow.createCell(i);
            cell.setCellValue(columnHeaders[i]);
            cell.setCellStyle(headerCellStylefull);
        }

        for (Map<String, Object> lis : lisvent) {
            bodyRow = sheet.createRow(rowCount++);
            Cell celfecd = bodyRow.createCell(0);
            celfecd.setCellValue(lis.get("nompros").toString());
            celfecd.setCellStyle(headerCellStylefull);

            Cell celasd = bodyRow.createCell(1);
            celasd.setCellValue(lis.get("celpros").toString());
            celasd.setCellStyle(headerCellStylefull);

            Cell celmond = bodyRow.createCell(2);
            celmond.setCellValue(lis.get("descpros").toString());
            celmond.setCellStyle(headerCellStylefull);
        }
        try (ServletOutputStream outputStream = response.getOutputStream()) {
            workbook.write(outputStream);
            workbook.close();
        }

    }
}
