package com.venta.curso.Service;

import com.venta.curso.Config.Info;
import com.venta.curso.Interface.MatriculaInterface;
import com.venta.curso.Repository.MatriculaRepository;
import java.util.List;
import java.util.Map;
import lombok.RequiredArgsConstructor;
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
@RequiredArgsConstructor
public class MatriculaService implements MatriculaInterface {

    private final RestTemplate restTemplate;
    private final MatriculaRepository matricularepo;

    @Override
    public List<Map<String, Object>> getMatricula() {
        return matricularepo.getMatricula();
    }

    @Override
    public List<Map<String, Object>> getPrematricula() {
        return matricularepo.getPrematricula();
    }

    @Override
    public List<Map<String, Object>> getMatriculareport(String fecdes, String fechas) {
        return matricularepo.getMatriculareport(fecdes, fechas);
    }

    @Override
    public List<Map<String, Object>> getDetallematreport(String idmat, String esta) {
        return matricularepo.getDetallematreport(idmat, esta);
    }

    @Override
    public List<Map<String, Object>> getPaqueteoCurso(String idmat) {
        return matricularepo.getPaqueteoCurso(idmat);
    }

    @Override
    public List<Map<String, Object>> getCursoPaquete(String idpaq) {
        return matricularepo.getCursoPaquete(idpaq);
    }

    @Override
    public String getMontofec(String fecdes, String fechas) {
        return matricularepo.getMontofec(fecdes, fechas);
    }

    @Override
    public List<Map<String, Object>> getVentareport(String fecdes, String fechas) {
        return matricularepo.getVentareport(fecdes, fechas);
    }

    @Override
    public void cancelar(String idmat, String des) {
        matricularepo.cancelar(idmat, des);
    }

    @Override
    public List<Map<String, Object>> getVenta() {
        return matricularepo.getVenta();
    }

    @Override
    public List<Map<String, Object>> getTipocomprobante() {
        return matricularepo.getTipocomprobante();
    }

    @Override
    public List<Map<String, Object>> getNumero(String tipcom) {
        return matricularepo.getNumero(tipcom);
    }

    @Override
    public List<Map<String, Object>> verificar(String mat, String tip, String num, String ev) {
        return matricularepo.verificar(mat, tip, num, ev);
    }

    @Override
    public String penvio(String requestbody) {
        HttpHeaders headers = new HttpHeaders();
        headers.setBearerAuth(Info.tokenapisunat);
        headers.setContentType(MediaType.APPLICATION_JSON);
        HttpEntity<String> request = new HttpEntity<>(requestbody, headers);
        return restTemplate.postForObject(Info.rutaenvio, request, String.class);
    }

    @Override
    public List<Map<String, Object>> getventa(String mat) {
        return matricularepo.getventa(mat);
    }

    @Override
    public List<Map<String, Object>> getdetventa(String mat) {
        return matricularepo.getdetventa(mat);
    }

    @Override
    public void actualizarcomprobante(String idcom, String desc, String notes) {
        matricularepo.actualizarcom(idcom, desc, notes); 
    }
}
