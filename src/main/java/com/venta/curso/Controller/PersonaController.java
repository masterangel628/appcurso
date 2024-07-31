package com.venta.curso.Controller;

import com.venta.curso.Config.Info;
import com.venta.curso.Entity.PersonaEntity;
import com.venta.curso.Interface.PersonaInterface;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
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
}
