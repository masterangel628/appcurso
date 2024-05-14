/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.venta.curso.Controller;

import com.venta.curso.Entity.EstadoAsEnum;
import com.venta.curso.Entity.EstadoTimEnum;
import com.venta.curso.Entity.ProspectoEntity;
import com.venta.curso.Interface.ProspectoInterface;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import java.io.IOException;
import java.text.DecimalFormat;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import org.apache.poi.ss.usermodel.Cell;
import static org.apache.poi.ss.usermodel.CellType.BLANK;
import static org.apache.poi.ss.usermodel.CellType.BOOLEAN;
import static org.apache.poi.ss.usermodel.CellType.NUMERIC;
import static org.apache.poi.ss.usermodel.CellType.STRING;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author Asus
 */
@Controller
@RequiredArgsConstructor
public class ProspectoController {

    private final ProspectoInterface prospectointer;

    @GetMapping("/prospecto")
    public String Prospecto() {
        return "prospecto";
    }

    @PostMapping("prospecto/upload")
    @ResponseBody
    public Map uploadExcelFile(@RequestParam("file") MultipartFile file, HttpServletRequest request) throws IOException {
        String nom = "", num = "";
        Map validacion = new HashMap();
        if (file.getOriginalFilename().endsWith(".xlsx")) {
            Workbook workbook = new XSSFWorkbook(file.getInputStream());
            Sheet sheet = workbook.getSheetAt(0);
            for (int rowIndex = 1; rowIndex <= sheet.getLastRowNum(); rowIndex++) {
                Row row = sheet.getRow(rowIndex);
                DecimalFormat decimalFormat = new DecimalFormat("#");
                decimalFormat.setParseBigDecimal(true);
                for (Cell cell : row) {
                    switch (cell.getCellType()) {
                        case NUMERIC:
                            num = decimalFormat.format(cell.getNumericCellValue());
                            break;
                        case STRING:
                            nom = cell.getStringCellValue();
                            break;
                        case BOOLEAN:
                            break;
                        case BLANK:
                            break;
                        default:
                            break;
                    }
                }
                if (prospectointer.existenum(num) != 1) {
                    ProspectoEntity pros = new ProspectoEntity();
                    pros.setCelpros(num);
                    pros.setNompros(nom);
                    pros.setEstaaspros(EstadoAsEnum.NOASIGNADO);
                    pros.setEstatimpros(EstadoTimEnum.CALIENTE);
                    pros.setFechorpros(LocalDate.parse(prospectointer.fecactual()));
                    prospectointer.guardar(pros);
                }
                workbook.close();
                validacion.put("resp", "si");
            }
        } else {
            validacion.put("file","No es un archivo excel");
            validacion.put("resp", "no");
        }

        return validacion;
    }

    @GetMapping("/prospecto/mprospecto")
    @ResponseBody
    public List getProspecto() {
        return prospectointer.getProspecto();
    }

}
