package com.venta.curso.Controller;

import com.venta.curso.Entity.EstadoEnum;
import com.venta.curso.Interface.CertificadoInterface;
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
public class CertificadoController {

    private final CertificadoInterface certificadointer;

    Validation val = new Validation();

    @GetMapping("/certificado")
    public String Certificado() {
        return "enviarcertificado";
    }

    @GetMapping("certificado/mmatricula")
    @ResponseBody
    public List getMatricula() {
        return certificadointer.getMatricula();
    }

    @GetMapping("certificado/detalle")
    @ResponseBody
    public Map getDetalle(@RequestParam("mat") String idmat) {
        return certificadointer.getCertificadoMat(idmat);
    }

    @PostMapping("certificado/enviarcert")
    @ResponseBody
    public Map Guardarenvio(@RequestParam("fec") String fec, @RequestParam("idmat") String idmat, @RequestParam("mon") String mon,
            @RequestParam("cod") String cod, @RequestParam("num") String num) {
        Map validacion = new HashMap();
        if (!val.vacio(fec)) {
            validacion.put("fec", "El campo Fecha es obligatorio");
        }
        if (!val.vacio(fec)) {
            validacion.put("fec", "El campo Fecha es obligatorio");
        }
        if (!val.vacio(mon)) {
            validacion.put("mon", "El campo Monto es obligatorio");
        } else {
            if (!val.solodecimalentero(mon)) {
                validacion.put("mon", "El campo Monto debe tener numérico");
            }
        }
        if (!val.vacio(cod)) {
            validacion.put("cod", "El campo Código es obligatorio");
        }
        if (!val.vacio(num)) {
            validacion.put("num", "El campo Número es obligatorio");
        }
        if (validacion.isEmpty()) {
            certificadointer.guardarenvio(fec, idmat, mon, cod, num);
            validacion.put("resp", "si");
        } else {
            validacion.put("resp", "no");
        }
        return validacion;
    }
}
