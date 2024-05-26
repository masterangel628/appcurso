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

    public void actualizarpago(String idmat, String vau, String ban);

    public List<Map<String, Object>> getbanco();

    public void verificar(String idmat);

    public List<Map<String, Object>> getMatriculareport(String fecdes,String fechas);

    public List<Map<String, Object>> getDetallematreport(String idmat,String esta);

    public List<Map<String, Object>> getPaqueteoCurso(String idmat);

    public List<Map<String, Object>> getCursoPaquete(String idpaq);

}
