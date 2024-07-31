package com.venta.curso.Controller;

import com.venta.curso.Config.Info;
import com.venta.curso.Interface.ComprobanteInterface;
import com.venta.curso.Interface.MatriculaInterface;
import jakarta.servlet.http.HttpServletResponse;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import org.json.simple.JSONObject;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
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
public class ComprobanteController {

    private final ComprobanteInterface comprointer;
    private final MatriculaInterface matriculainter;
    private final RestTemplate restTemplate;

    @GetMapping("/comprobante")
    public String Comprobante() {
        return "comprobante";
    }

    @GetMapping("comprobante/mcomprobante")
    @ResponseBody
    public List getComprobante() {
        return comprointer.getComprobante();
    }

    @PostMapping("comprobante/pdf")
    @ResponseBody
    public ResponseEntity<InputStreamResource> getPdf(@RequestParam(name = "com") String com) {
        return comprointer.getPdf(getBody(com));
    }

    @PostMapping("comprobante/xml")
    @ResponseBody
    public ResponseEntity<InputStreamResource> viewXml(@RequestParam(name = "com") String com) {
        HttpHeaders headers = new HttpHeaders();
        headers.setBearerAuth(Info.tokenapisunat);
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.setAccept(Collections.singletonList(MediaType.APPLICATION_XML));
        HttpEntity<String> entity = new HttpEntity<>(getBody(com), headers);
        ResponseEntity<String> apiResponse = restTemplate.exchange(Info.rutaxml, HttpMethod.POST, entity, String.class);
        if (apiResponse.getStatusCode() == HttpStatus.OK) {
            String xmlContent = apiResponse.getBody();
            InputStream xmlStream = new ByteArrayInputStream(xmlContent.getBytes(StandardCharsets.UTF_8));
            InputStreamResource resource = new InputStreamResource(xmlStream);
            HttpHeaders responseHeaders = new HttpHeaders();
            responseHeaders.setContentType(MediaType.APPLICATION_XML);
            responseHeaders.setContentDispositionFormData("attachment", "response.xml");
            return new ResponseEntity<>(resource, responseHeaders, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.BAD_REQUEST);
        }
    }

    public String getBody(String com) {
        List<Map<String, Object>> lisven = comprointer.getInfoComprobante(com);

        JSONObject objetoCabecera = new JSONObject();
        objetoCabecera.put("empresa_Ruc", Info.ruc);
        objetoCabecera.put("tipo_Doc", lisven.get(0).get("codtipcom").toString());
        objetoCabecera.put("serie", lisven.get(0).get("serie").toString());
        objetoCabecera.put("correlativo", lisven.get(0).get("num").toString());
        return objetoCabecera.toString();
    }

}
