package com.venta.curso.Controller;

import com.venta.curso.Entity.UserEntity;
import com.venta.curso.Interface.ProspectoInterface;
import com.venta.curso.Interface.UserInterface;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
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

    @GetMapping("/procesoprospecto")
    public String Prospecto() {
        return "procesoprospecto";
    }

    @GetMapping("procesoprospecto/mostrar")
    @ResponseBody
    public List Prospectomostrar() {
        UserEntity user = userInterface.getinfouser();
        return prospectointer.getProspectoasesor(String.valueOf(user.getId())); 
    }
    
    @PostMapping("procesoprospecto/actualizarestado")
    @ResponseBody
    public void Prospectomostrar(@RequestParam("esta") String esta,@RequestParam("idpro") String idpro) {
        prospectointer.cambiarestatiempo(idpro, esta); 
    }
}
