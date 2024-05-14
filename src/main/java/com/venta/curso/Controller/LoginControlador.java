
package com.venta.curso.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

/**
 *
 * @author Asus
 */
@Controller
public class LoginControlador {

    @GetMapping("/login")
    public String login() {
        return "login";
    }
}
