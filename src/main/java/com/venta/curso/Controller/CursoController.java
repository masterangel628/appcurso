package com.venta.curso.Controller;

import com.venta.curso.Entity.EstadoEnum;
import com.venta.curso.Interface.CursoInterface;
import com.venta.curso.Interface.DocenteInterface;
import com.venta.curso.Validation.Validation;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author Asus
 */
@Controller
@RequiredArgsConstructor
public class CursoController {

    private final DocenteInterface docenteinter;
    private final CursoInterface cursointer;

    Validation val = new Validation();

    @GetMapping("/curso")
    public String Docente() {
        return "curso";
    }

    @GetMapping("curso/mdocente")
    @ResponseBody
    public List getDocente() {
        return docenteinter.getDocenteActivo();
    }

    @GetMapping("curso/mcurso")
    @ResponseBody
    public List getCurso() {
        return cursointer.getCurso();
    }

    @PostMapping("curso/guardar")
    @ResponseBody
    public Map Guardar(@RequestParam(name = "cod") String cod, @RequestParam(name = "nom") String nom,
            @RequestParam(name = "dura") String dura,
            @RequestParam(name = "hora") String hora, @RequestParam(name = "prec") String prec,
            @RequestParam(name = "iddoc") int iddoc) {
        Map validacion = new HashMap();

        if (!val.vacio(cod)) {
            validacion.put("cod", "El campo Código es obligatorio");
        } else {
            if (cursointer.existecurso(cod) == 1) {
                validacion.put("cod", "Ya existe un curso con este Código");
            }
        }
        if (!val.vacio(nom)) {
            validacion.put("nom", "El campo Nombre es obligatorio");
        }
        if (!val.vacio(dura)) {
            validacion.put("dura", "El campo Duración es obligatorio");
        }

        if (!val.vacio(prec)) {
            validacion.put("prec", "El campo Precio es obligatorio");
        } else {
            if (!val.solodecimalentero(prec)) {
                validacion.put("prec", "El campo Precio debe tener numérico");
            }
        }
        if (iddoc == 0) {
            validacion.put("iddoc", "Seleccione un docente");
        }
        if (validacion.isEmpty()) {
            cursointer.saveCurso(cod, nom, dura, hora, new BigDecimal(prec), EstadoEnum.ACTIVO.toString(), iddoc);
            validacion.put("resp", "si");
        } else {
            validacion.put("resp", "no");
        }
        return validacion;
    }

    @PostMapping("curso/editar")
    @ResponseBody
    public Map Editar(@RequestParam(name = "cod") String cod, @RequestParam(name = "nom") String nom,
            @RequestParam(name = "dura") String dura,
            @RequestParam(name = "hora") String hora, @RequestParam(name = "prec") String prec,
            @RequestParam(name = "iddoc") int iddoc, @RequestParam(name = "idcur") int idcur) {
        Map validacion = new HashMap();

        if (!val.vacio(cod)) {
            validacion.put("cod", "El campo Código es obligatorio");
        } else {
            if (cursointer.existecursoedit(cod, idcur) == 1) {
                validacion.put("cod", "Ya existe un curso con este Código");
            }
        }
        if (!val.vacio(nom)) {
            validacion.put("nom", "El campo Nombre es obligatorio");
        }

        if (!val.vacio(prec)) {
            validacion.put("prec", "El campo Precio es obligatorio");
        } else {
            if (!val.solodecimalentero(prec)) {
                validacion.put("prec", "El campo Precio debe tener numérico");
            }
        }
        if (!val.vacio(dura)) {
            validacion.put("dura", "El campo Duración es obligatorio");
        }
        if (iddoc == 0) {
            validacion.put("iddoc", "Seleccione un docente");
        }
        if (validacion.isEmpty()) {
            cursointer.editCurso(cod, nom, dura, hora, new BigDecimal(prec), iddoc, idcur);
            validacion.put("resp", "si");
        } else {
            validacion.put("resp", "no");
        }
        return validacion;

    }

    @PostMapping("curso/cambiarestado")
    @ResponseBody
    public String CambiarEstado(@RequestParam(name = "idcur") String idcur, @RequestParam(name = "esta") String esta) {
        if (esta.equalsIgnoreCase("ACTIVO")) {
            cursointer.CambiarEstado("INACTIVO", idcur);
        }
        if (esta.equalsIgnoreCase("INACTIVO")) {
            cursointer.CambiarEstado("ACTIVO", idcur);
        }
        return "El Curso cambia de estado";
    }
}
