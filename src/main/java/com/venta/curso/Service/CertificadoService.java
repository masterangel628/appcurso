package com.venta.curso.Service;

import com.venta.curso.Interface.CertificadoInterface;
import com.venta.curso.Repository.CertificadoRepository;
import java.util.List;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

/**
 *
 * @author Asus
 */
@Service
@RequiredArgsConstructor
public class CertificadoService implements CertificadoInterface {

    private final CertificadoRepository certificadorepo;

    @Override
    public List<Map<String, Object>> getMatricula() {
        return certificadorepo.getMatricula();
    }

    @Override
    public void guardarenvio(String fec, String idmat, String mon, String cod, String num) {
        certificadorepo.guardarenvio(fec, idmat, mon, cod, num); 
    }

    @Override
    public Map<String, Object> getCertificadoMat(String idmat) {
        return certificadorepo.getCertificadoMat(idmat);
    }

}
