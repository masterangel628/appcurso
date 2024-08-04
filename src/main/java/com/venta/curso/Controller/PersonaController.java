package com.venta.curso.Controller;

import com.venta.curso.Config.Info;
import com.venta.curso.Entity.DistritoEntity;
import com.venta.curso.Entity.PersonaEntity;
import com.venta.curso.Interface.PersonaInterface;
import com.venta.curso.Validation.Validation;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

/**
 *
 * @author Asus
 */
@Controller
@RequiredArgsConstructor
public class PersonaController {

    private final PersonaInterface personainter;
    Validation val = new Validation();

    @GetMapping("/persona/consulta/{dni}")
    @ResponseBody
    public Map getPersona(@PathVariable String dni) {
        Map resp = new HashMap();
        if (personainter.existepersona(dni) == 1) {
            resp.put("persona", personainter.getpersona(dni));
            resp.put("msj", "bd");
        } else {
            String url = Info.rutadni + "/" + dni;
            HttpHeaders headers = new HttpHeaders();
            headers.setBearerAuth(Info.tokenapiconsulta);
            HttpEntity<String> entity = new HttpEntity<>(headers);
            RestTemplate restTemplate = new RestTemplate();
            ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);
            if (response.getStatusCode() == HttpStatus.OK) {
                resp.put("persona", response.getBody());
                resp.put("msj", "api");
            }
        }
        return resp;
    }

    @GetMapping("/persona/departamento")
    @ResponseBody
    public List getDepartamento() {
        return personainter.getDepartamento();
    }

    @GetMapping("/persona/provincia/{cod}")
    @ResponseBody
    public List getProvincia(@PathVariable String cod) {
        return personainter.getProvincia(cod);
    }

    @GetMapping("/persona/distrito/{cod}")
    @ResponseBody
    public List getDistrito(@PathVariable String cod) {
        return personainter.getDistrito(cod);
    }

    @GetMapping("/persona/buscar")
    @ResponseBody
    public List Buscarcliente(@RequestParam(name = "bus") String bus) {
        return personainter.getPersona(bus);
    }

    @PostMapping("persona/guardar")
    @ResponseBody
    public Map Guardar(@RequestParam(name = "ape") String ape, @RequestParam(name = "nom") String nom,
            @RequestParam(name = "dni") String dni, @RequestParam(name = "dir") String dir,
            @RequestParam(name = "cel") String cel, @RequestParam(name = "cor") String cor,
            @RequestParam(name = "dep") String dep, @RequestParam(name = "prov") String prov,
            @RequestParam(name = "dist") String dist) {

        Map validacion = new HashMap();

        if (!val.vacio(dni)) {
            validacion.put("dni", "El campo DNI es obligatorio");
        } else {
            if (!val.soloenteros(dni)) {
                validacion.put("dni", "El campo DNI debe tener numérico");
            } else {
                if (!val.logitud(dni, 8)) {
                    validacion.put("dni", "El campo DNI debe tener 8 caractéres");
                } else {
                    if (personainter.existepersona(dni) == 1) {
                        validacion.put("dni", "Ya existe un cliente con este DNI");
                    }
                }
            }
        }

        if (!val.vacio(ape)) {
            validacion.put("ape", "El campo Apellido es obligatorio");
        } else {
            if (!val.sololetras(ape)) {
                validacion.put("ape", "El campo Apellido no debe ser numérico");
            }
        }

        if (!val.vacio(nom)) {
            validacion.put("nom", "El campo Nombre es obligatorio");
        } else {
            if (!val.sololetras(nom)) {
                validacion.put("nom", "El campo Nombre no debe ser numérico");
            }
        }

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
        if (dep.equalsIgnoreCase("0")) {
            validacion.put("dep", "Seleccione un departamento");
        }
        if (prov.equalsIgnoreCase("0")) {
            validacion.put("prov", "Seleccione una provincia");
        }
        if (dist.equalsIgnoreCase("0")) {
            validacion.put("dist", "Seleccione un distrito");
        }
        if (!val.vacio(cor)) {
            validacion.put("cor", "El campo Correo es obligatorio");
        } else {
            if (!val.correo(cor)) {
                validacion.put("cor", "El campo Correo no es correcto");
            } else {
                if (personainter.existecorreo(cor) == 1) {
                    validacion.put("cor", "Ya existe un Cliente con este Correo");
                }
            }
        }
        if (validacion.isEmpty()) {
            DistritoEntity DistritoEntity = new DistritoEntity();
            DistritoEntity.setIddistrito(dist);
            PersonaEntity PersonaEntity = new PersonaEntity();
            PersonaEntity.setApeper(ape);
            PersonaEntity.setNomper(nom);
            PersonaEntity.setDniper(dni);
            PersonaEntity.setCelper(cel);
            PersonaEntity.setDirper(dir);
            PersonaEntity.setCorreoper(cor);
            PersonaEntity.setDistrito(DistritoEntity);
            personainter.guardarpersona(PersonaEntity);
            validacion.put("resp", "si");
        } else {
            validacion.put("resp", "no");
        }
        return validacion;
    }
}
