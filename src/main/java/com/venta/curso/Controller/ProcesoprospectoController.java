package com.venta.curso.Controller;

import com.venta.curso.Entity.UserEntity;
import com.venta.curso.Interface.ProspectoInterface;
import com.venta.curso.Interface.SessionInterface;
import com.venta.curso.Interface.UserInterface;
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
public class ProcesoprospectoController {

    private final ProspectoInterface prospectointer;
    private final UserInterface userInterface;
    private final SessionInterface sesInterface;

    Validation val = new Validation();

    @GetMapping("/procesoprospecto")
    public String Prospecto() {
        return "procesoprospecto";
    }

    @GetMapping("procesoprospecto/verificasesion")
    @ResponseBody
    public Map Verificasesion() {
        Map validacion = new HashMap();
        UserEntity usu = userInterface.getinfouser();
        if (sesInterface.verificasessionabi(String.valueOf(usu.getId())) == 1) {
            validacion.put("resp", "si");
        } else {
            validacion.put("resp", "no");
        }
        return validacion;
    }

    @GetMapping("procesoprospecto/mostrar")
    @ResponseBody
    public List Prospectomostrar() {
        UserEntity user = userInterface.getinfouser();
        return prospectointer.getProspectoasesorverificado(String.valueOf(user.getId()));
    }

    @PostMapping("procesoprospecto/actualizarestado")
    @ResponseBody
    public void Prospectomostrar(@RequestParam("esta") String esta, @RequestParam("idpro") String idpro, @RequestParam("iddetpro") String iddetpro) {
        prospectointer.Actualizarpveri(iddetpro); 
        prospectointer.cambiarestatiempo(idpro, esta);
    }

    @GetMapping("procesoprospecto/mcurso")
    @ResponseBody
    public List getCurso() {
        return prospectointer.getCurso();
    }

    @GetMapping("procesoprospecto/mpaquete")
    @ResponseBody
    public List getPaquete() {
        return prospectointer.getPaquete();
    }

    @PostMapping("procesoprospecto/guardar")
    @ResponseBody
    public Map guardar(@RequestParam("curpaq") String curpaq, @RequestParam("tipo") String tipo, @RequestParam("detpro") String detpro) {
        Map validacion = new HashMap();
        if (curpaq.equalsIgnoreCase("0")) {
            if (tipo.equalsIgnoreCase("CURSO")) {
                validacion.put("curpaq", "Seleccione un curso");
            }
            if (tipo.equalsIgnoreCase("PAQUETE")) {
                validacion.put("curpaq", "Seleccione un paquete");
            }
        }
        if (validacion.isEmpty()) {
            UserEntity usu = userInterface.getinfouser();
            int idses = sesInterface.getidsession(String.valueOf(usu.getId()));
            String resp = prospectointer.procesoprematricula(curpaq, tipo, String.valueOf(idses), detpro).get(0).get("resp").toString();
            validacion.put("resp", "si");
            validacion.put("proc", resp);
        } else {
            validacion.put("resp", "no");
        }
        return validacion;
    }

    @PostMapping("procesoprospecto/finalizar")
    @ResponseBody
    public Map prematricula(@RequestParam("cli") String cli, @RequestParam("tip") String tip, @RequestParam("detpro") String detpro) {
        Map validacion = new HashMap();
        if (!val.vacio(cli)) {
            validacion.put("cli", "El campo Cliente es obligatorio");
        }
        if (tip.equalsIgnoreCase("0")) {
            validacion.put("tip", "Seleccione un tipo de matrícula");
        }
        if (validacion.isEmpty()) {
            UserEntity usu = userInterface.getinfouser();
            int idses = sesInterface.getidsession(String.valueOf(usu.getId()));
            prospectointer.prematricula(cli, String.valueOf(idses), tip, detpro);
            validacion.put("resp", "si");
        } else {
            validacion.put("resp", "no");
        }
        return validacion;
    }

    @GetMapping("procesoprospecto/comanda")
    @ResponseBody
    public List guardar(@RequestParam("iddetpro") String iddetpro) {
        UserEntity usu = userInterface.getinfouser();
        int idses = sesInterface.getidsession(String.valueOf(usu.getId()));
        return prospectointer.getComanda(String.valueOf(idses), iddetpro);
    }

    @PostMapping("procesoprospecto/eliminacomanda")
    @ResponseBody
    public void elimina(@RequestParam("idco") String idco) {
        prospectointer.eliminarcomanda(idco);
    }

    @GetMapping("procesoprospecto/paquetecurso")
    @ResponseBody
    public List getPaquetecurso(@RequestParam("idpaq") String idpaq) {
        return prospectointer.getPaquetecurso(idpaq);
    }
}
