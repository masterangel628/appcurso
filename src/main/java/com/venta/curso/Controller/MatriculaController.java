package com.venta.curso.Controller;

import com.venta.curso.Interface.ClienteInterface;
import com.venta.curso.Interface.MatriculaInterface;
import jakarta.servlet.ServletContext;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.net.MalformedURLException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

/**
 *
 * @author Asus
 */
@Controller
@RequiredArgsConstructor
public class MatriculaController {

    private final MatriculaInterface matriculainter;
    private final ClienteInterface clienteinter;
    private final ServletContext servletContext;

    @GetMapping("/matricula")
    public String Docente() {
        return "matricula";
    }

    @GetMapping("matricula/mmatricula")
    @ResponseBody
    public List getMatricula() {
        return matriculainter.getMatricula();
    }

    @GetMapping("matricula/mcliente")
    @ResponseBody
    public List getCliente() {
        return clienteinter.getCliente();
    }

    @GetMapping("matricula/mbanco")
    @ResponseBody
    public List getBanco() {
        return matriculainter.getbanco();
    }

    @PostMapping("matricula/guardar")
    @ResponseBody
    public void Guardar(@RequestParam(name = "vau") MultipartFile file, @RequestParam(name = "cli") String cli, @RequestParam(name = "ban") String ban) {
        try {
            // Obtener la ruta del directorio raíz del servidor
            String rootDirectory = servletContext.getRealPath("/");
            // Crear la carpeta de uploads en la raíz si no existe
            File uploadDir = new File(rootDirectory + "uploads");
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            // Generar un nombre único para el archivo
            String uniqueFilename = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
            // Guardar el archivo en la carpeta de uploads en la raíz
            String filePath = uploadDir.getAbsolutePath() + File.separator + uniqueFilename;
            file.transferTo(new File(filePath));
            matriculainter.guardarmatricula(uniqueFilename, matriculainter.fecactual(), cli, "1", ban);
        } catch (IOException e) {
        }
    }

    @GetMapping("matricula/mpaquete")
    @ResponseBody
    public List getPaquete() {
        return matriculainter.getPaqueteActivo();
    }

    @GetMapping("matricula/mdetpaquete")
    @ResponseBody
    public List getdetpaquete(@RequestParam(name = "paq") String paq) {
        return matriculainter.getdetpaquete(paq);
    }

    @PostMapping("matricula/guardardetmat")
    @ResponseBody
    public void Guardardetmat(@RequestParam(name = "mat") String mat, @RequestParam(name = "paq") String paq) {
        matriculainter.guardardetmat(mat, paq);
    }
     @GetMapping("/images/{filename:.+}")
    public ResponseEntity<Resource> getImage(@PathVariable String filename) {
        try {
            // Obtener la ruta del directorio raíz del servidor
            String rootDirectory = servletContext.getRealPath("/");
            Path filePath = Paths.get(rootDirectory + "uploads").resolve(filename).normalize();
            Resource resource = new UrlResource(filePath.toUri());

            if (resource.exists() && resource.isReadable()) {
                return ResponseEntity.ok()
                        .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + resource.getFilename() + "\"")
                        .body(resource);
            } else {
                return ResponseEntity.status(404).body(null);
            }
        } catch (MalformedURLException e) {
            e.printStackTrace();
            return ResponseEntity.status(500).body(null);
        }
    }
}
