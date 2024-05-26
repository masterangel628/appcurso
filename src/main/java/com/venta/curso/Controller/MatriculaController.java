package com.venta.curso.Controller;

import com.venta.curso.Interface.ClienteInterface;
import com.venta.curso.Interface.MatriculaInterface;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletResponse;
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
import org.springframework.web.multipart.MultipartFile;
import java.io.ByteArrayOutputStream;

import org.apache.poi.ss.usermodel.Cell;

import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleOutputStreamExporterOutput;
import net.sf.jasperreports.export.SimplePdfExporterConfiguration;
import org.springframework.core.io.ClassPathResource;
import org.springframework.http.HttpStatus;
import javax.sql.DataSource;
import org.springframework.beans.factory.annotation.Autowired;

/**
 *
 * @author Asus
 */
@Controller
@RequiredArgsConstructor
public class MatriculaController {

    private final MatriculaInterface matriculainter;
    private final ClienteInterface clienteinter;
    private final ServletContext servletContext;
    @Autowired
    private DataSource dataSource;

    @GetMapping("/matricula")
    public String ProcesoMatricula() {
        return "matricula";
    }

    @GetMapping("matricula/mmatricula")
    @ResponseBody
    public List getPrematricula() {
        return matriculainter.getPrematricula();
    }

    @GetMapping("matricula/mcliente")
    @ResponseBody
    public List getCliente() {
        return clienteinter.getCliente();
    }

    @GetMapping("matricula/mbanco")
    @ResponseBody
    public List getBanco() {
        return matriculainter.getbanco();
    }

    @PostMapping("matricula/verificar")
    @ResponseBody
    public void Verificar(@RequestParam(name = "mat") String mat) {
        matriculainter.verificar(mat);
    }

    @PostMapping("matricula/guardar")
    @ResponseBody
    public Map Guardar(@RequestParam(name = "vau") MultipartFile file, @RequestParam(name = "ban") String ban, @RequestParam(name = "mat") String mat) {
        Map validacion = new HashMap();

        String ext = file.getOriginalFilename().toLowerCase();
        if (!ext.endsWith("png") && !ext.endsWith(".png") && !ext.endsWith(".png")) {
            validacion.put("vau", "Solo esta permitido imagen con extensión .png, .jpg y jpeg");
        }

        if (ban.equalsIgnoreCase("0")) {
            validacion.put("ban", "Seleccione un banco");
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
                matriculainter.actualizarpago(mat, uniqueFilename, ban);
            } catch (IOException e) {
            }
            validacion.put("resp", "si");
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

    @GetMapping("/reportematricula")
    public String Matricula() {
        return "reportematricula";
    }

    @GetMapping("reportematricula/mmatricula")
    @ResponseBody
    public List getMatricula() {
        return matriculainter.getMatricula();
    }

    @GetMapping("reportematricula/excel")
    @ResponseBody
    public void exportToExcel(@RequestParam(name = "fecdes") String fecdes, @RequestParam(name = "fechas") String fechas, HttpServletResponse response) throws IOException {
        response.setContentType("application/octet-stream");
        String headerKey = "Content-Disposition";
        String headerValue = "attachment; filename=reportematricula.xlsx";
        response.setHeader(headerKey, headerValue);

        List<Map<String, Object>> lismat = matriculainter.getMatriculareport(fecdes, fechas);

        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Matriculados");

        sheet.setColumnWidth(0, 4000);
        sheet.setColumnWidth(1, 4000);
        sheet.setColumnWidth(2, 6000);
        sheet.setColumnWidth(3, 6000);
        sheet.setColumnWidth(4, 8000);

        Row headerRow = sheet.createRow(0);

        Cell cell = headerRow.createCell(0);
        cell.setCellValue("username");
        cell = headerRow.createCell(1);
        cell.setCellValue("password");
        cell = headerRow.createCell(2);
        cell.setCellValue("firstname");
        cell = headerRow.createCell(3);
        cell.setCellValue("lastname");
        cell = headerRow.createCell(4);
        cell.setCellValue("email");

        int rowCount = 1;

        for (Map<String, Object> mat : lismat) {
            Row row = sheet.createRow(rowCount++);
            int columnCount = 0;

            Cell cellusu = row.createCell(columnCount++);
            cellusu.setCellValue(mat.get("username").toString());

            Cell cellpass = row.createCell(columnCount++);
            cellpass.setCellValue(mat.get("password").toString());

            Cell cellnom = row.createCell(columnCount++);
            cellnom.setCellValue(mat.get("firstname").toString());
            Cell cellape = row.createCell(columnCount++);
            cellape.setCellValue(mat.get("lastname").toString());
            Cell cellemail = row.createCell(columnCount++);
            cellemail.setCellValue(mat.get("email").toString());

            List<Map<String, Object>> lispaqocur = matriculainter.getPaqueteoCurso(mat.get("idmatricula").toString());
            for (Map<String, Object> paqocur : lispaqocur) {
                if (paqocur.get("estadetmat").toString().equalsIgnoreCase("CURSO")) {
                    List<Map<String, Object>> lisdetmat = matriculainter.getDetallematreport(mat.get("idmatricula").toString(), "CURSO");
                    for (Map<String, Object> detmat : lisdetmat) {
                        row.createCell(columnCount++).setCellValue(detmat.get("estatipomat").toString());
                        row.createCell(columnCount++).setCellValue(detmat.get("curpaq").toString());
                    }
                }
                if (paqocur.get("estadetmat").toString().equalsIgnoreCase("PAQUETE")) {
                    List<Map<String, Object>> lisdetmat = matriculainter.getDetallematreport(mat.get("idmatricula").toString(), "PAQUETE");
                    for (Map<String, Object> detmat : lisdetmat) {
                        List<Map<String, Object>> liscurpaq = matriculainter.getCursoPaquete(detmat.get("idcurpaq").toString());
                        for (Map<String, Object> paqcur : liscurpaq) {
                            row.createCell(columnCount++).setCellValue(detmat.get("estatipomat").toString());
                            row.createCell(columnCount++).setCellValue(paqcur.get("nomcur").toString());
                        }
                    }
                }
            }

        }

        try (ServletOutputStream outputStream = response.getOutputStream()) {
            workbook.write(outputStream);
            workbook.close();
        }
    }

    @GetMapping("reportematricula/pdf")
    @ResponseBody
    public ResponseEntity<byte[]> generateReport(@RequestParam(name = "fecdes") String fecdes, @RequestParam(name = "fechas") String fechas) throws JRException, IOException, SQLException {
        // Cargar y compilar el archivo .jrxml
        ClassPathResource reportResource = new ClassPathResource("reports/reportmatricula.jrxml");
        JasperReport jasperReport = JasperCompileManager.compileReport(reportResource.getInputStream());

        Connection connection = dataSource.getConnection();
        // Parámetros del reporte
        Map<String, Object> parameters = new HashMap<>();
        parameters.put("fecdes", fecdes);
        parameters.put("fechas", fechas);

        // Llenar el reporte
        JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, parameters, connection);

        // Exportar a PDF
        ByteArrayOutputStream pdfOutputStream = new ByteArrayOutputStream();
        JRPdfExporter exporter = new JRPdfExporter();
        exporter.setExporterInput(new SimpleExporterInput(jasperPrint));
        exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(pdfOutputStream));
        exporter.setConfiguration(new SimplePdfExporterConfiguration());
        exporter.exportReport();

        // Configurar la respuesta HTTP
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(org.springframework.http.MediaType.APPLICATION_PDF);
        headers.setContentDispositionFormData("attachment", "reportematricula.pdf");

        return new ResponseEntity<>(pdfOutputStream.toByteArray(), headers, HttpStatus.OK);
    }

    @GetMapping("reportematricula/images/{filename:.+}")
    public ResponseEntity<Resource> getImagereportmatricula(@PathVariable String filename) {
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

}
