package com.venta.curso.Controller;

import com.venta.curso.Entity.EstadoEnum;
import com.venta.curso.Entity.PaqueteEntity;
import com.venta.curso.Interface.PaqueteInterface;
import com.venta.curso.Validation.Validation;
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
public class PaqueteController {

    private final PaqueteInterface paqueteinter;

    Validation val = new Validation();

    @GetMapping("/paquete")
    public String Paquete() {
        return "paquete";
    }

    @GetMapping("paquete/mpaquete")
    @ResponseBody
    public List getPaquete() {
        return paqueteinter.getPaquete();
    }

    @GetMapping("paquete/mcurso")
    @ResponseBody
    public List getCurso() {
        return paqueteinter.getCursoAc();
    }

    @PostMapping("paquete/guardar")
    @ResponseBody
    public Map Guardar(@RequestParam(name = "nom") String nom) {
        Map validacion = new HashMap();
        if (!val.vacio(nom)) {
            validacion.put("nom", "El campo Nombre es obligatorio");
        } else {
            if (paqueteinter.existepaquete(nom) == 1) {
                validacion.put("nom", "Ya existe un paquete con este nombre");
            }
        }
        if (validacion.isEmpty()) {
            PaqueteEntity PaqueteEntity = new PaqueteEntity();
            PaqueteEntity.setNompaq(nom);
            PaqueteEntity.setEstado(EstadoEnum.ACTIVO);
            paqueteinter.savePaquete(PaqueteEntity);
            validacion.put("resp", "si");
        } else {
            validacion.put("resp", "no");
        }
        return validacion;
    }

    @PostMapping("paquete/editar")
    @ResponseBody
    public Map Editar(@RequestParam(name = "nom") String nom, @RequestParam(name = "id") String id) {
        Map validacion = new HashMap();

        if (!val.vacio(nom)) {
            validacion.put("nom", "El campo Código es obligatorio");
        } else {
            if (paqueteinter.existepaqueteedit(nom, id) == 1) {
                validacion.put("nom", "Ya existe un paquete con este nombre");
            }
        }
        if (validacion.isEmpty()) {
            paqueteinter.editPaquete(nom, id);
            validacion.put("resp", "si");
        } else {
            validacion.put("resp", "no");
        }
        return validacion;

    }

    @PostMapping("paquete/cambiarestado")
    @ResponseBody
    public String CambiarEstado(@RequestParam(name = "idpaq") String idpaq, @RequestParam(name = "esta") String esta) {
        if (esta.equalsIgnoreCase("ACTIVO")) {
            paqueteinter.CambiarEstado("INACTIVO", idpaq);
        }
        if (esta.equalsIgnoreCase("INACTIVO")) {
            paqueteinter.CambiarEstado("ACTIVO", idpaq);
        }
        return "El Paquete cambia de estado";
    }

    @PostMapping("paquete/guardardetalle")
    @ResponseBody
    public Map Guardardetalle(@RequestParam(name = "cur") int cur, @RequestParam(name = "paq") String paq, @RequestParam(name = "prec") String prec) {
        Map validacion = new HashMap();
        if (!val.vacio(prec)) {
            validacion.put("prec", "El campo Precio es obligatorio");
        } else {
            if (!val.solodecimalentero(prec)) {
                validacion.put("prec", "El campo Precio debe tener numérico");
            }
        }
        if (cur == 0) {
            validacion.put("cur", "Seleccione un curso");
        } else {
            if (paqueteinter.existecursopaq(String.valueOf(cur), paq) == 1) {
                validacion.put("cur", "Ya existe este curso en el paquete");
            }
        }
        if (validacion.isEmpty()) {
            paqueteinter.guardarcursopaq(String.valueOf(cur), paq, prec);
            validacion.put("resp", "si");
        } else {
            validacion.put("resp", "no");
        }
        return validacion;
    }

    @GetMapping("paquete/mcursopaquete")
    @ResponseBody
    public List getCursopaquete(@RequestParam(name = "cur") String cur) {
        return paqueteinter.getcursopaq(cur);
    }

    @PostMapping("paquete/eliminarcursopaq")
    @ResponseBody
    public void Eliminarcursopaq(@RequestParam(name = "cur") String cur) {
        paqueteinter.eliminarcursopaq(cur);
    }
}
