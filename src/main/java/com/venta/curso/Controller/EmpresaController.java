package com.venta.curso.Controller;

import com.venta.curso.Config.Info;
import com.venta.curso.Interface.EmpresaInterface;
import java.util.HashMap;
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
public class EmpresaController {

    private final EmpresaInterface empresainter;

    @GetMapping("/empresa/consulta/{ruc}")
    @ResponseBody
    public Map getEmpresa(@PathVariable String ruc) {
        Map resp = new HashMap();
        if (empresainter.existeEmpresa(ruc) == 1) {
            resp.put("empresa", empresainter.getEmpresa(ruc));
            resp.put("msj", "bd");
        } else {
            String url = Info.rutaruc + "/" + ruc;
            HttpHeaders headers = new HttpHeaders();
            headers.setBearerAuth(Info.tokenapiconsulta);
            HttpEntity<String> entity = new HttpEntity<>(headers);
            RestTemplate restTemplate = new RestTemplate();
            ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);
            if (response.getStatusCode() == HttpStatus.OK) {
                resp.put("empresa", response.getBody());
                resp.put("msj", "api");
            }
        }
        return resp;
    }
}
