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
//            String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI0MjEiLCJuYW1lIjoiTWlndWVsIMOBbmdlbCBUb2xlZG8gQ29yZG92YSAiLCJlbWFpbCI6Imdyb25lX21hc19hQGhvdG1haWwuY29tIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiY29uc3VsdG9yIn0.JNwVMeRftn0KZsPCFa703t4PNOavvK9xyAYkLiRfFBY"; // Reemplaza con tu token real
            String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI0NjIiLCJuYW1lIjoibWFzdGVyYW5nZWwiLCJlbWFpbCI6Im1hMTl0Yzk3QGdtYWlsLmNvbSIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvcm9sZSI6ImNvbnN1bHRvciJ9.vSnyP-PcStIwBNjRwLXiqxYJpNFyYiGCvrkvnd9eDao";
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
