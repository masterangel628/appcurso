
package com.venta.curso.Service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

/**
 *
 * @author Asus
 */
@Service
public class ApiService {
    @Autowired
    private RestTemplate restTemplate;
   
    public String sendJson(Object requestBody) {
        HttpHeaders headers = new HttpHeaders();
        String url = "https://apife-qa.factiliza.com/api/v1/invoice/send";
        String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIyNTUiLCJuYW1lIjoiQUQzNjAiLCJlbWFpbCI6ImxpY2VuY2lhc0BhdXRvZGVhbDM2MC5jb20iLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJjb25zdWx0b3IifQ.exaRMFDSIm-MIrUTQVlRQ6VgrcLbWPnPGCIhdVLHSrs";
        headers.setBearerAuth(token);
        headers.setContentType(MediaType.APPLICATION_JSON);
        HttpEntity<Object> request = new HttpEntity<>(requestBody, headers);
        return restTemplate.postForObject(url, request, String.class);
    }
}
