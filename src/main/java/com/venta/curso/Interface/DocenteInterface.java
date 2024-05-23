package com.venta.curso.Interface;

import com.venta.curso.Entity.DocenteEntity;
import java.util.List;

/**
 *
 * @author Asus
 */
public interface DocenteInterface {

    public List<DocenteEntity> getDocente();

    public DocenteEntity saveDocente(DocenteEntity doc);

    public DocenteEntity editDocente(DocenteEntity doc);

    public void CambiarEstado(String estado, String id);

    public int existedocente(String idper);
    
    public void guardardoc(String idper,String esta);
}
