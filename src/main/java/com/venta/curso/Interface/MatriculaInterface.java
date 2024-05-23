package com.venta.curso.Interface;

import java.util.List;
import java.util.Map;

/**
 *
 * @author Asus
 */
public interface MatriculaInterface {

    public List<Map<String, Object>> getMatricula();

    public void guardarmatricula(String vau, String fec, String cli, String usu, String ban);

    public String fecactual();

    public void guardardetmat(String mat, String paq);

    public List<Map<String, Object>> getPaqueteActivo();

    public List<Map<String, Object>> getdetpaquete(String idpaq);

    public List<Map<String, Object>> getbanco();

}
