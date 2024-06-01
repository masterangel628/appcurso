package com.venta.curso.Interface;

import java.util.List;
import java.util.Map;

/**
 *
 * @author Asus
 */
public interface CertificadoInterface {

    public List<Map<String, Object>> getMatricula();

    public void guardarenvio(String fec,String idmat,String mon,String cod,String num);
    
    public Map<String, Object> getCertificadoMat(String idmat);
    
}
