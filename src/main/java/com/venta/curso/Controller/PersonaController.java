package com.venta.curso.Controller;

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
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
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
    public Map getPaquete(@PathVariable String dni) {
        Map resp = new HashMap();
        if (personainter.existepersona(dni) == 1) {
            resp.put("persona", personainter.getpersona(dni));
            resp.put("msj", "bd");
        } else {
            String url = "https://api.factiliza.com/pe/v1/dni/info/" + dni;
            String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2NTAiLCJuYW1lIjoiSk9TRSBKQU1BTkNBIiwiZW1haWwiOiJjYXBhY2l0YXBlcnUyMDIyQGdtYWlsLmNvbSIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcm9sZSI6ImNvbnN1bHRvciJ9.0eYyUNdVknzp8JS7ibt7eiF738F00jz3TUYdbkErVwg";
            HttpHeaders headers = new HttpHeaders();
            headers.setBearerAuth(token);
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
