package com.venta.curso.Controller;

import com.venta.curso.Entity.PersonaEntity;
import com.venta.curso.Entity.UserEntity;
import com.venta.curso.Event.RegistrationCompleteEventListener;
import com.venta.curso.Interface.PasswordResetTokenInterface;
import com.venta.curso.Interface.UserInterface;
import com.venta.curso.Util.UrlUtil;
import com.venta.curso.Validation.Validation;
import jakarta.mail.MessagingException;
import jakarta.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
public class PasswordResetTokenController {

    private final UserInterface userService;
    private final PasswordResetTokenInterface passwordResetTokenService;
    private final RegistrationCompleteEventListener eventListener;


    Validation val = new Validation();

    @GetMapping("/forgot-password")
    public String forgotPasswordForm() {
        return "forgot-password";
    }

    @PostMapping("forgot-password/send-token")
    @ResponseBody
    public Map resetPasswordRequest(@RequestParam("email") String cor, HttpServletRequest request) {
        Map validacion = new HashMap();
        if (!val.vacio(cor)) {
            validacion.put("cor", "El campo Correo es obligatorio");
        } else {
            if (!val.correo(cor)) {
                validacion.put("cor", "El campo Correo no es correcto");
            } else {
                if (userService.existemail(cor) != 1) {
                    validacion.put("cor", "Ningún usuario encontrado con este correo electrónico");
                }
            }
        }
        if (validacion.isEmpty()) {
            String passwordResetToken = UUID.randomUUID().toString();
            String username=userService.getUsername(cor);
            UserEntity user=userService.getUsuario(username);
            String nombre=userService.getNombre(cor);
            passwordResetTokenService.deletetoken(String.valueOf(user.getId()));  
            passwordResetTokenService.createPasswordResetTokenForUser(user, passwordResetToken);
            
            String url = UrlUtil.getApplicationUrl(request) + "/reset-password?token=" + passwordResetToken;
            try {
                eventListener.sendPasswordResetVerificationEmail(url,nombre,cor);
            } catch (MessagingException | UnsupportedEncodingException e) {
            }
            validacion.put("msj", "Acabamos de enviar un enlace de verificación a su correo electrónico; verifíquelo para completar su solicitud.");
            validacion.put("resp", "si");
        } else {
            validacion.put("resp", "no");
        }
        return validacion;
    }

    @GetMapping("/reset-password")
    public String passwordResetForm(@RequestParam("token") String token, Model model) {
        model.addAttribute("token", token);
        return "reset-password";
    }

    @PostMapping("reset-password/change-password")
    @ResponseBody
    public Map resetPassword(@RequestParam("token") String theToken,@RequestParam("pass") String pass,@RequestParam("passc") String passc) {
        Map validacion = new HashMap();
        if (!val.vacio(pass)) {
            validacion.put("pass", "El campo Contraseña es obligatorio");
        }
        if (!val.vacio(passc)) {
            validacion.put("passc", "El campo Confirmar Contraseña es obligatorio");
        }
        if (validacion.isEmpty()) {
            if (!pass.equalsIgnoreCase(passc)) {
                validacion.put("msj", "Las contraseñas no coinciden");
                validacion.put("band", "no");
                 validacion.put("resp", "si");
            } else {
                String tokenVerificationResult = passwordResetTokenService.validatePasswordResetToken(theToken);
                if (!tokenVerificationResult.equalsIgnoreCase("valid")) {
                    validacion.put("band", "no");
                    validacion.put("msj", "Token inválido");
                     validacion.put("resp", "si");
                } else {
                    Optional<UserEntity> theUser = passwordResetTokenService.findUserByPasswordResetToken(theToken);
                    if (theUser.isPresent()) {
                        passwordResetTokenService.resetPassword(theUser.get(), pass);
                        validacion.put("band", "si");
                        validacion.put("msj", "Ha restablecido exitosamente su contraseña");
                         validacion.put("resp", "si");
                    }
                }
            }
        } else {
            validacion.put("resp", "no");
        }

        return validacion;
    }
}
