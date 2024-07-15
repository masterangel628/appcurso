package com.venta.curso.Controller;

import com.opencsv.CSVWriter;
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
import java.io.IOException;
import java.io.Writer;
import java.net.MalformedURLException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.util.Map;

import net.sf.jasperreports.engine.JRException;
import javax.sql.DataSource;
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

    @PostMapping("matricula/verificar")
    @ResponseBody
    public void Verificar(@RequestParam(name = "mat") String mat) {
        matriculainter.verificar(mat);
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
        response.setContentType("text/csv");
        String headerKey = "Content-Disposition";
        String headerValue = "attachment; filename=reportematricula.csv";
        response.setHeader(headerKey, headerValue);
        exportCsv(response.getWriter(), fecdes, fechas);
    }

    public void exportCsv(Writer writer, String fecdes, String fechas) throws IOException {
        List<Map<String, Object>> lismat = matriculainter.getMatriculareport(fecdes, fechas);
        try (CSVWriter csvWriter = new CSVWriter(writer)) {
            String cab = "username;password;firstname;lastname;email;course1;group1;course2;group2;course3;group3;course4;group4;course5;group5;course6;group6;course7;group7;course8;group8";
            String[] header = {cab};
            csvWriter.writeNext(header);
            for (Map<String, Object> mat : lismat) {
                String bod = mat.get("username").toString() + ";" + mat.get("password").toString() + ";" + mat.get("firstname").toString() + ";" + mat.get("lastname").toString() + ";" + mat.get("email").toString();
                List<Map<String, Object>> lispaqocur = matriculainter.getPaqueteoCurso(mat.get("idmatricula").toString());
                for (Map<String, Object> paqocur : lispaqocur) {
                    if (paqocur.get("estadetmat").toString().equalsIgnoreCase("CURSO")) {
                        List<Map<String, Object>> lisdetmat = matriculainter.getDetallematreport(mat.get("idmatricula").toString(), "CURSO");
                        for (Map<String, Object> detmat : lisdetmat) {
                            bod = bod + ";" + detmat.get("curpaq").toString() + ";" + detmat.get("estatipomat").toString();
                        }
                    }
                    if (paqocur.get("estadetmat").toString().equalsIgnoreCase("PAQUETE")) {
                        List<Map<String, Object>> lisdetmat = matriculainter.getDetallematreport(mat.get("idmatricula").toString(), "PAQUETE");
                        for (Map<String, Object> detmat : lisdetmat) {
                            List<Map<String, Object>> liscurpaq = matriculainter.getCursoPaquete(detmat.get("idcurpaq").toString());
                            for (Map<String, Object> paqcur : liscurpaq) {
                                bod = bod + ";" + detmat.get("codcur").toString() + ";" + paqcur.get("estatipomat").toString();
                            }
                        }
                    }
                }
                String[] data = {bod};
                csvWriter.writeNext(data);
            }
        }
    }

    @GetMapping("reportematricula/pdf")
    @ResponseBody
    public void generateReport(@RequestParam(name = "fecdes") String fecdes, @RequestParam(name = "fechas") String fechas, HttpServletResponse response) throws JRException, IOException, SQLException {
        response.setContentType("application/octet-stream");
        String headerKey = "Content-Disposition";
        String headerValue = "attachment; filename=reporteventa.xlsx";
        response.setHeader(headerKey, headerValue);
        Row bodyRow;
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Ventas");
        sheet.setColumnWidth(0, 4000);
        sheet.setColumnWidth(1, 12000);
        sheet.setColumnWidth(2, 4000);
        sheet.setColumnWidth(3, 12000);
        sheet.setColumnWidth(4, 12000);
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
        celltitulo.setCellValue("Reporte de ventas");
        sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 4));

        bodyRow = sheet.createRow(1);
        Cell cellfec = bodyRow.createCell(0);
        cellfec.setCellStyle(headerCellStyle);
        cellfec.setCellValue(fecdes + " - " + fechas);
        sheet.addMergedRegion(new CellRangeAddress(1, 1, 0, 4));

        List<Map<String, Object>> lisvent = matriculainter.getVentareport(fecdes, fechas);
        int rowCount = 3;

        String[] columnHeaders = {"Fecha", "Asesor", "Monto", "Cliente", "Cursos"};
        bodyRow = sheet.createRow(2);
        for (int i = 0; i < columnHeaders.length; i++) {
            Cell cell = bodyRow.createCell(i);
            cell.setCellValue(columnHeaders[i]);
            cell.setCellStyle(headerCellStylefull);
        }

        for (Map<String, Object> lis : lisvent) {
            bodyRow = sheet.createRow(rowCount++);
            Cell celfecd = bodyRow.createCell(0);
            celfecd.setCellValue(lis.get("fecmat").toString());
            celfecd.setCellStyle(headerCellStylefull);
            
            Cell celasd = bodyRow.createCell(1);
            celasd.setCellValue(lis.get("nomusu").toString());
            celasd.setCellStyle(headerCellStylefull);
            
            Cell celmond = bodyRow.createCell(2);
            celmond.setCellValue(lis.get("montomat").toString());
            celmond.setCellStyle(headerCellStylefull);
            
            Cell celclid = bodyRow.createCell(3);
            celclid.setCellValue(lis.get("nomcli").toString());
            celclid.setCellStyle(headerCellStylefull);
            
            Cell celcurd = bodyRow.createCell(4);
            celcurd.setCellValue(lis.get("curpa").toString());
            celcurd.setCellStyle(headerCellStylefull);

        }
        int row=rowCount++;
        bodyRow = sheet.createRow(row);
        Cell cell0 = bodyRow.createCell(0);
        cell0.setCellStyle(headerCellStyle);
        cell0.setCellValue("Monto Total ");
        Cell cell1 = bodyRow.createCell(2);
        cell1.setCellStyle(headerCellStylefull);
        cell1.setCellValue(matriculainter.getMontofec(fecdes, fechas));
        sheet.addMergedRegion(new CellRangeAddress(row, row, 0, 1));

        try (ServletOutputStream outputStream = response.getOutputStream()) {
            workbook.write(outputStream);
            workbook.close();
        }

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
