package com.venta.curso.Interface;

import com.venta.curso.Entity.ProspectoEntity;
import java.util.List;

/**
 *
 * @author Asus
 */
public interface ProspectoInterface {

    public void guardar(ProspectoEntity pros);

    public List<ProspectoEntity> getProspecto();
    
    public String fecactual();
    
    public int existenum(String num);

}
