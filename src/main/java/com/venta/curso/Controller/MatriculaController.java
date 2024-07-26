package com.venta.curso.Controller;

import com.venta.curso.Interface.MatriculaInterface;
import com.venta.curso.Interface.VaucherInterface;
import com.venta.curso.Validation.Validation;
import jakarta.servlet.ServletContext;
import java.io.File;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.io.IOException;
import java.net.MalformedURLException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import org.springframework.web.multipart.MultipartFile;

/**
 *
 * @author Asus
 */
@Controller
@RequiredArgsConstructor
public class MatriculaController {

    private final MatriculaInterface matriculainter;
    private final ServletContext servletContext;
    Validation val = new Validation();

    private final VaucherInterface vaucherinter;

    @GetMapping("/matricula")
    public String ProcesoMatricula() {
        return "matricula";
    }

    @GetMapping("matricula/mmatricula")
    @ResponseBody
    public List getPrematricula() {
        return matriculainter.getPrematricula();
    }

    @GetMapping("matricula/mvaucher/{mat}")
    @ResponseBody
    public List getVaucher(@PathVariable String mat) {
        return vaucherinter.getVaucher(mat);
    }

    @PostMapping("matricula/verificar")
    @ResponseBody
    public void Verificar(@RequestParam(name = "mat") String mat) {
        matriculainter.verificar(mat);
    }

    @PostMapping("matricula/cancelar")
    @ResponseBody
    public Map Cancelar(@RequestParam(name = "mat") String mat, @RequestParam(name = "des") String des) {
        Map validacion = new HashMap();
        if (!val.vacio(des)) {
            validacion.put("des", "El campo Descripción es obligatorio");
        }
        if (validacion.isEmpty()) {
            matriculainter.cancelar(mat, des);
            validacion.put("resp", "si");
        } else {
            validacion.put("resp", "no");
        }
        return validacion;
    }

    @PostMapping("matricula/cancelarall")
    @ResponseBody
    public Map Cancelarall(@RequestParam(name = "mat") String mat, @RequestParam(name = "files") MultipartFile[] files, @RequestParam(name = "des") String des) {
        Map validacion = new HashMap();
        if (files != null) {
            for (MultipartFile file : files) {
                String ext = file.getOriginalFilename().toLowerCase();
                if (!ext.endsWith("png") && !ext.endsWith(".jpg") && !ext.endsWith(".jpeg")) {
                    validacion.put("vau", "Solo esta permitido imagen con extensión .png, .jpg y jpeg");
                }
            }
        }
        if (!val.vacio(des)) {
            validacion.put("des", "El campo Descripción es obligatorio");
        }
        if (validacion.isEmpty()) {
            try {
                matriculainter.cancelar(mat, des);
                for (MultipartFile file : files) {
                    if (!file.isEmpty()) {
                        String rootDirectory = servletContext.getRealPath("/");
                        File uploadDir = new File(rootDirectory + "uploads");
                        if (!uploadDir.exists()) {
                            uploadDir.mkdirs();
                        }
                        String uniqueFilename = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
                        String filePath = uploadDir.getAbsolutePath() + File.separator + uniqueFilename;
                        file.transferTo(new File(filePath));
                        vaucherinter.save(uniqueFilename, mat);
                    }
                }
                validacion.put("resp", "si");
            } catch (IOException e) {
            }
        } else {
            validacion.put("resp", "no");
        }

        return validacion;
    }

    @GetMapping("matricula/images/{filename:.+}")
    public ResponseEntity<Resource> getImagematricula(@PathVariable String filename) {
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
