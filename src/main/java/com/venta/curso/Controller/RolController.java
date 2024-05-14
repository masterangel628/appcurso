
package com.venta.curso.Controller;

import com.venta.curso.Interface.RolInterface;
import java.util.List;
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

public class RolController {

    private final RolInterface rolinterface;

    @GetMapping("/rol")
    public String producto() {
        return "rol";
    }

    @GetMapping("rol/mrol")
    @ResponseBody
    public List getrol() {
        return rolinterface.getRoles();
    }

    @GetMapping("rol/mpermiso")
    @ResponseBody
    public List getpermiso(@RequestParam("rol") String rol) {
        return rolinterface.getPermiso(rol);
    }
    
    @GetMapping("rol/mpermisorol")
    @ResponseBody
    public List getpermisorol(@RequestParam("rol") String rol) {
        return rolinterface.getPermisoRol(rol);
    }
    
    @PostMapping("rol/asignarpermiso")
    @ResponseBody
    public void asignarpermiso(@RequestParam("rol") String rol,@RequestParam("per") String per) {
         rolinterface.AsignarPermiso(rol, per);
    }
    @PostMapping("rol/quitarpermiso")
    @ResponseBody
    public String quitarpermiso(@RequestParam("rol") String rol,@RequestParam("per") String per) {
         rolinterface.QuitarPermiso(rol, per);
         return "rol: " +rol+" per: "+per;
    }

}
