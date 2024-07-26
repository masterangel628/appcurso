package com.venta.curso.Controller;

import com.opencsv.CSVWriter;
import com.venta.curso.Interface.MatriculaInterface;
import com.venta.curso.Interface.VaucherInterface;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletOutputStream;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.Writer;
import java.net.MalformedURLException;
import java.nio.file.Path;
import java.nio.file.Paths;
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
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author Asus
 */
@Controller
@RequiredArgsConstructor
public class RMatriculaController {

    private final MatriculaInterface matriculainter;
    private final ServletContext servletContext;
    private final VaucherInterface vaucherinter;

    @GetMapping("/reportematricula")
    public String Matricula() {
        return "reportematricula";
    }

    @GetMapping("reportematricula/mvaucher/{mat}")
    @ResponseBody
    public List getVaucher(@PathVariable String mat) {
        return vaucherinter.getVaucher(mat);
    }

    @GetMapping("reportematricula/mmatricula")
    @ResponseBody
    public List getMatricula() {
        return matriculainter.getMatricula();
    }

    @GetMapping("reportematricula/csv")
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
