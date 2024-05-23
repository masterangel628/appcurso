
package com.venta.curso.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

/**
 *
 * @author Asus
 */
@Controller
public class InicioController {
    @GetMapping("/inicio")
    public String Inicio() {
        return "inicio";
    }
}
