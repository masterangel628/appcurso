package com.venta.curso.Service;

import com.venta.curso.Config.Info;
import com.venta.curso.Interface.ComprobanteInterface;
import com.venta.curso.Repository.ComprobanteRepository;
import java.util.List;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpMethod;

/**
 *
 * @author Asus
 */
@Service
@RequiredArgsConstructor
public class ConprobanteService implements ComprobanteInterface {

    private final ComprobanteRepository comprepo;
    private final RestTemplate restTemplate;

    @Override
    public List<Map<String, Object>> getComprobante() {
        return comprepo.getComprobante();
    }

    @Override
    public List<Map<String, Object>> getInfoComprobante(String idcom) {
        return comprepo.getInfoComprobante(idcom);
    }

    @Override
    public ResponseEntity<InputStreamResource> getPdf(String requestbody) {
        HttpHeaders headers = new HttpHeaders();
        headers.setBearerAuth(Info.tokenapisunat);
        headers.setContentType(MediaType.APPLICATION_JSON);
        HttpEntity<String> request = new HttpEntity<>(requestbody, headers);

        ResponseEntity<byte[]> response = restTemplate.exchange(Info.rutapdf, HttpMethod.POST, request, byte[].class);
        byte[] pdfBytes = response.getBody();

        InputStream inputStream = new ByteArrayInputStream(pdfBytes);
        InputStreamResource resource = new InputStreamResource(inputStream);

        // Definir los encabezados de la respuesta
        HttpHeaders responseHeaders = new HttpHeaders();
        responseHeaders.add(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=myfile.pdf");
        responseHeaders.add(HttpHeaders.CONTENT_TYPE, MediaType.APPLICATION_PDF_VALUE);

        return ResponseEntity.ok()
                .headers(responseHeaders)
                .contentLength(pdfBytes.length)
                .contentType(MediaType.APPLICATION_PDF)
                .body(resource);

    }

}
