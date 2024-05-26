package com.venta.curso.Interface;

import com.venta.curso.Entity.DocenteEntity;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Asus
 */
public interface DocenteInterface {

    public List<DocenteEntity> getDocente();

    public void CambiarEstado(String estado, String id);

    public int existedocente(String idper);

    public void guardardoc(String idper, String esta);

    public List<Map<String, Object>> getDocenteActivo();
}
