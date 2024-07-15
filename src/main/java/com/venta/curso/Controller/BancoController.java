package com.venta.curso.Controller;

import com.venta.curso.Entity.BancoEntity;
import com.venta.curso.Entity.EstadoEnum;
import com.venta.curso.Interface.BancoInterface;
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
public class BancoController {
    private final BancoInterface bancointer;

    Validation val = new Validation();

    @GetMapping("/banco")
    public String Docente() {
        return "banco";
    }

    @GetMapping("banco/mbanco")
    @ResponseBody
    public List getDocente() {
        return bancointer.getBanco();
    }

    @PostMapping("banco/guardar")
    @ResponseBody
    public Map Guardar(@RequestParam(name = "nom") String nom, @RequestParam(name = "num") String num) {
        Map validacion = new HashMap();
        if (!val.vacio(nom)) {
            validacion.put("nom", "El campo Nombre es obligatorio");
        } else {
            if (!val.sololetras(nom)) {
                validacion.put("nom", "El campo Nombre no debe ser numérico");
            } else {
                if (bancointer.existeBanco(nom) == 1) {
                    validacion.put("nom", "Ya existe este banco");
                }
            }
        }
        if (!val.vacio(num)) {
            validacion.put("num", "El campo Número es obligatorio");
        }
        if (validacion.isEmpty()) {

            BancoEntity BancoEntity = new BancoEntity();
            BancoEntity.setNomban(nom);
            BancoEntity.setNmroban(num);
            BancoEntity.setEstado(EstadoEnum.ACTIVO);
            bancointer.saveBanco(BancoEntity); 
            validacion.put("resp", "si");
        } else {
            validacion.put("resp", "no");
        }
        return validacion;
    }

    @PostMapping("banco/editar")
    @ResponseBody
    public Map Editar(@RequestParam(name = "idban") String idban, @RequestParam(name = "nom") String nom, @RequestParam(name = "num") String num) {

        Map validacion = new HashMap();
        if (!val.vacio(nom)) {
            validacion.put("nom", "El campo Nombre es obligatorio");
        } else {
            if (!val.sololetras(nom)) {
                validacion.put("nom", "El campo Nombre no debe ser numérico");
            } else {
                if (bancointer.existeBancoedit(nom, idban) == 1) {
                    validacion.put("nom", "Ya existe este banco");
                }
            }
        }
        if (!val.vacio(num)) {
            validacion.put("num", "El campo Número es obligatorio");
        }
        if (validacion.isEmpty()) {
            bancointer.Editar(nom, num, idban);
            validacion.put("resp", "si");
        } else {
            validacion.put("resp", "no");
        }
        return validacion;
    }
    @PostMapping("banco/cambiarestado")
    @ResponseBody
    public String CambiarEstado(@RequestParam(name = "idban") String idban, @RequestParam(name = "esta") String esta) {
        if (esta.equalsIgnoreCase("ACTIVO")) {
            bancointer.CambiarEstado("INACTIVO", idban);
        }
        if (esta.equalsIgnoreCase("INACTIVO")) {
            bancointer.CambiarEstado("ACTIVO", idban);
        }
        return "El Banco cambia de estado";
    }
}
