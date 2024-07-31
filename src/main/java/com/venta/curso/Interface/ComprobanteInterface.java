package com.venta.curso.Interface;

import java.util.List;
import java.util.Map;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.ResponseEntity;

/**
 *
 * @author Asus
 */
public interface ComprobanteInterface {

    public List<Map<String, Object>> getComprobante();
    
    public List<Map<String, Object>> getInfoComprobante(String idcom);
    
    public ResponseEntity<InputStreamResource> getPdf(String requestbody);

}
