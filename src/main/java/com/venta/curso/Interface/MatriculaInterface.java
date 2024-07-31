package com.venta.curso.Interface;

import java.util.List;
import java.util.Map;
import org.springframework.data.repository.query.Param;

/**
 *
 * @author Asus
 */
public interface MatriculaInterface {

    public List<Map<String, Object>> getPrematricula();

    public List<Map<String, Object>> getMatricula();

    public void cancelar(String idmat, String des);

    public List<Map<String, Object>> getMatriculareport(String fecdes, String fechas);

    public List<Map<String, Object>> getDetallematreport(String idmat, String esta);

    public List<Map<String, Object>> getPaqueteoCurso(String idmat);

    public List<Map<String, Object>> getCursoPaquete(String idpaq);

    public String getMontofec(String fecdes, String fechas);

    public List<Map<String, Object>> getVentareport(String fecdes, String fechas);

    public List<Map<String, Object>> getVenta();

    public List<Map<String, Object>> getTipocomprobante();

    public List<Map<String, Object>> getNumero(String tipcom);

    public List<Map<String, Object>> verificar(String mat, String tip, String num, String ev);

    public String penvio(String request);

    public List<Map<String, Object>> getventa(String mat);

    public List<Map<String, Object>> getdetventa(String mat);

      public void actualizarcomprobante(String idcom,String desc,String notes);
}
