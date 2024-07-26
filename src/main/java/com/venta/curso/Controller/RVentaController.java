package com.venta.curso.Controller;

import com.venta.curso.Interface.MatriculaInterface;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import lombok.RequiredArgsConstructor;
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
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author Asus
 */
@Controller
@RequiredArgsConstructor
public class RVentaController {

    private final MatriculaInterface matriculainter;

    @GetMapping("/reporteventa")
    public String Matricula() {
        return "reporteventa";
    }

    @GetMapping("reporteventa/mventa")
    @ResponseBody
    public List getMatricula() {
        return matriculainter.getVenta();
    }

    @GetMapping("reporteventa/excel")
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
        sheet.setColumnWidth(5, 4000);
        sheet.setColumnWidth(6, 12000);
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

        String[] columnHeaders = {"Fecha", "Asesor", "Monto", "Cliente", "Cursos", "Estado", "Descripción"};
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
            
            Cell estacurd = bodyRow.createCell(5);
            estacurd.setCellValue(lis.get("estado").toString());
            estacurd.setCellStyle(headerCellStylefull);
            
            Cell descurd = bodyRow.createCell(6);
            descurd.setCellValue(lis.get("descmat").toString());
            descurd.setCellStyle(headerCellStylefull);

        }
        int row = rowCount++;
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
}
