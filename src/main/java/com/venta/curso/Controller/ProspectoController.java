package com.venta.curso.Controller;

import com.venta.curso.Entity.EstadoAsEnum;
import com.venta.curso.Entity.EstadoTimEnum;
import com.venta.curso.Entity.ProspectoEntity;
import com.venta.curso.Entity.UserEntity;
import com.venta.curso.Interface.ProspectoInterface;
import com.venta.curso.Interface.UserInterface;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import java.io.IOException;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
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
    private final UserInterface userinter;

    @GetMapping("/prospecto")
    public String Prospecto() {
        return "prospecto";
    }

    @PostMapping("prospecto/upload")
    @ResponseBody
    public Map uploadExcelFile(@RequestParam("file") MultipartFile file, HttpServletRequest request) throws IOException {
        String nom = "", num = "", fec = "";
        Map validacion = new HashMap();
        SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
        if (file.getOriginalFilename().endsWith(".xlsx")) {
            Workbook workbook = new XSSFWorkbook(file.getInputStream());
            Sheet sheet = workbook.getSheetAt(0);
            for (int rowIndex = 1; rowIndex <= sheet.getLastRowNum(); rowIndex++) {
                Row row = sheet.getRow(rowIndex);
                DecimalFormat decimalFormat = new DecimalFormat("#");
                decimalFormat.setParseBigDecimal(true);
                nom = row.getCell(0).getStringCellValue();
                num = decimalFormat.format(row.getCell(1).getNumericCellValue());
                Cell datecell = row.getCell(2);
                if (DateUtil.isCellDateFormatted(datecell)) {
                    Date date = datecell.getDateCellValue();
                    fec = dateformat.format(date);
                }
                if (prospectointer.existenum(num) != 1) {
                    ProspectoEntity pros = new ProspectoEntity();
                    pros.setCelpros(num);
                    pros.setNompros(nom);
                    pros.setDescpros("");
                    pros.setEstaaspros(EstadoAsEnum.NOASIGNADO);
                    pros.setEstatimpros(EstadoTimEnum.CALIENTE);
                    pros.setFechorpros(LocalDate.parse(fec));
                    prospectointer.guardar(pros);
                }
                workbook.close();
                validacion.put("resp", "si");
            }
        } else {
            validacion.put("file", "No es un archivo excel");
            validacion.put("resp", "no");
        }

        return validacion;
    }

    @GetMapping("prospecto/mprospecto")
    @ResponseBody
    public List getProspecto() {
        return prospectointer.getProspecto();
    }

    @PostMapping("prospecto/estadotiempo")
    @ResponseBody
    public String actualizarestadotiempo() {
        prospectointer.Actualizarestadotiempo();
        return "si";
    }

    @PostMapping("prospecto/limpiar")
    @ResponseBody
    public String actualizarnoasignado() {
        prospectointer.Actualizarnoasignado();
        return "si";
    }

    @GetMapping("inicio/info")
    @ResponseBody
    public Map info() {
        Map data = new HashMap();
        UserEntity usu = userinter.getinfouser();
        String idusu = String.valueOf(usu.getId());
        data.put("cantcliveri", prospectointer.cantclienteverificado(idusu));
        data.put("cantclinoveri", prospectointer.cantclientenoverificado(idusu));
        data.put("cantcliasig", prospectointer.cantclienteasignado(idusu));
        data.put("cantclimat", prospectointer.cantclientematriculado(idusu));
        return data;
    }

}
