package com.venta.curso.Controller;

import com.venta.curso.Entity.UserEntity;
import com.venta.curso.Interface.PersonaInterface;
import com.venta.curso.Interface.UserInterface;
import com.venta.curso.Validation.Validation;
import java.util.HashMap;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
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
public class PerfilController {

    Validation val = new Validation();
    private final PersonaInterface personainter;
    private final UserInterface userinter;
    private final PasswordEncoder passwordEncoder;

    @GetMapping("/perfil")
    public String Perfil() {
        return "perfil";
    }

    @GetMapping("perfil/mostrar")
    @ResponseBody
    public Map Mostrar() {
        return personainter.getperson(userinter.getidpersona());
    }

    @PostMapping("perfil/editar")
    @ResponseBody
    public Map editar(@RequestParam("cel") String cel, @RequestParam("dir") String dir) {
        Map validacion = new HashMap();
        if (!val.vacio(dir)) {
            validacion.put("dir", "El campo Dirección es obligatorio");
        }

        if (!val.vacio(cel)) {
            validacion.put("cel", "El campo Celular es obligatorio");
        } else {
            if (!val.soloenteros(cel)) {
                validacion.put("cel", "El campo Celular debe tener numérico");
            } else {
                if (!val.logitud(cel, 9)) {
                    validacion.put("cel", "El campo Celular debe tener 9 caractéres");
                }
            }
        }
        if (validacion.isEmpty()) {
            personainter.editarceldir(cel, dir, userinter.getidpersona());
            validacion.put("resp", "si");
        } else {
            validacion.put("resp", "no");
        }
        return validacion;
    }

    @PostMapping("perfil/change-password")
    @ResponseBody
    public Map cambiar(Authentication aut, @RequestParam("passa") String passa, @RequestParam("passn") String passn, @RequestParam("passc") String passc) {
        String username = aut.getName();
        UserEntity user = userinter.findByUsername(username);
        Map validacion = new HashMap();
        if (!val.vacio(passa) && !val.vacio(passn) && !val.vacio(passc)) {
            validacion.put("msj", "Todos los campos son obligatorios");
        } else {
            if (!passwordEncoder.matches(passa, user.getPassword())) {
                validacion.put("msj", "La contraseña actual es incorrecta");
            } else {
                if (!passn.equalsIgnoreCase(passc)) {
                    validacion.put("msj", "La contraseña no coiciden");
                }
            }
        }
        if (validacion.isEmpty()) {
            userinter.Cambiarpassword(username, passn);
            validacion.put("resp", "si");
        } else {
            validacion.put("resp", "no");
        }
        return validacion;
    }

}
