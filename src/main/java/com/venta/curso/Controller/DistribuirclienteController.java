package com.venta.curso.Controller;

import com.venta.curso.Interface.ProspectoInterface;
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
public class DistribuirclienteController {

    private final ProspectoInterface prospectointer;
    Validation val = new Validation();

    @GetMapping("/distribuircliente")
    public String getProspectodis() {
        return "prodistribuir";
    }

    @PostMapping("distribuircliente/distribuir")
    @ResponseBody
    public Map getDistribuir(@RequestParam(name = "esta") String esta, @RequestParam(name = "usu") String usu, @RequestParam(name = "cant") String cant) {
        Map validacion = new HashMap();
        if (!val.vacio(cant)) {
            validacion.put("cant", "El campo Cantidad es obligatorio");
        } else {
            if (!val.soloenteros(cant)) {
                validacion.put("cant", "El campo Cantidad debe ser numérico");
            }
        }
        if (esta.equalsIgnoreCase("0")) {
            validacion.put("esta", "Seleccione un estado");
        }
        if (validacion.isEmpty()) {

            String val = prospectointer.guardarasesorpros(esta, cant, usu).get(0).get("resp").toString();
            if (val.equalsIgnoreCase("si")) {
                validacion.put("resp", "si");
                validacion.put("msj", "si");
            } else {
                validacion.put("resp", "si");
                 validacion.put("msj", val);
            }

        } else {
            validacion.put("resp", "no");
        }
        return validacion;

    }

    @GetMapping("distribuircliente/musuario")
    @ResponseBody
    public List getusuario() {
        return prospectointer.getusers();
    }

    @GetMapping("distribuircliente/infocliente")
    @ResponseBody
    public Map getinfocliente() {
        Map data = new HashMap();
        data.put("caliente", prospectointer.contcliescalnoas());
        data.put("tibio", prospectointer.contcliestinoas());
        data.put("frio", prospectointer.contcliesfrionoas());
        return data;
    }

    @GetMapping("distribuircliente/mestado")
    @ResponseBody
    public List getestado() {
        return prospectointer.getEstado();
    }

    @GetMapping("distribuircliente/mcliente")
    @ResponseBody
    public List getclienteas(@RequestParam(name = "usu") String usu) {
        return prospectointer.getProspectoasesor(usu);
    }
}
