package com.venta.curso.Controller;

import com.venta.curso.Entity.UserEntity;
import com.venta.curso.Interface.SessionInterface;
import com.venta.curso.Interface.UserInterface;
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
public class SessionController {

    private final SessionInterface sessioninter;
    private final UserInterface userInterface;

    @GetMapping("/session")
    public String session() {
        return "session";
    }

    @PostMapping("session/cerrar")
    @ResponseBody
    public Map cerrar() {
        Map msj = new HashMap();
        UserEntity user = userInterface.getinfouser();
        String usu = String.valueOf(user.getId());
        if (sessioninter.verificasessionabi(usu) == 1) {
            int idses = sessioninter.getidsession(usu);
            sessioninter.cerrarsession(String.valueOf(idses));
            msj.put("resp", "si");
        } else {
            msj.put("resp", "no");
        }
        return msj;
    }

    @PostMapping("session/abrir")
    @ResponseBody
    public Map abrir() {
        Map msj = new HashMap();
        UserEntity user = userInterface.getinfouser();
        String usu = String.valueOf(user.getId());
        if (sessioninter.verificasessionabi(usu) == 1) {
            msj.put("resp", "existe");
        } else {
            if (sessioninter.verificasession(usu) == 1) {
                msj.put("resp", "yaexiste");
            } else {
                sessioninter.abrirsession(usu);
                msj.put("resp", "si");
            }
        }
        return msj;
    }

    @GetMapping("/sessionadmin")
    public String sessionadmin() {
        return "sessionadmin";
    }

    @GetMapping("sessionadmin/muser")
    @ResponseBody
    public List getUsuario() {
        return sessioninter.getUsuario();
    }

    @GetMapping("sessionadmin/infosesion")
    @ResponseBody
    public Map getUsuario(@RequestParam("usu") String usu) {
        return sessioninter.getSesionultimausu(usu);
    }

    @PostMapping("sessionadmin/actualizarestado")
    @ResponseBody
    public Map actualizarestado(@RequestParam("idses") String idses, @RequestParam("esta") String esta) {
        Map msj = new HashMap();
        if (esta.equalsIgnoreCase("ABIERTO")) {
            sessioninter.actualizarestado(idses, "CERRADO");
            msj.put("resp", "si");
        }
        if (esta.equalsIgnoreCase("CERRADO")) {
            sessioninter.actualizarestado(idses, "ABIERTO");
            msj.put("resp", "si");
        }
        return msj;
    }

    @PostMapping("sessionadmin/cerrar")
    @ResponseBody
    public Map cerraradmin(@RequestParam("usu") String usu) {
        Map msj = new HashMap();
        if (sessioninter.verificasessionabi(usu) == 1) {
            int idses = sessioninter.getidsession(usu);
            sessioninter.cerrarsession(String.valueOf(idses));
            msj.put("resp", "si");
        } else {
            msj.put("resp", "no");
        }
        return msj;
    }

    @PostMapping("sessionadmin/abrir")
    @ResponseBody
    public Map abriradmin(@RequestParam("usu") String usu) {
        Map msj = new HashMap();
        if (sessioninter.verificasessionabi(usu) == 1) {
            msj.put("resp", "existe");
        } else {
            if (sessioninter.verificasession(usu) == 1) {
                msj.put("resp", "yaexiste");
            } else {
                sessioninter.abrirsession(usu);
                msj.put("resp", "si");
            }
        }
        return msj;
    }
}
