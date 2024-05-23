package com.venta.curso.Interface;

import com.venta.curso.Entity.ProspectoEntity;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Asus
 */
public interface ProspectoInterface {

    public void guardar(ProspectoEntity pros);

    public List<ProspectoEntity> getProspecto();

    public String fecactual();

    public int existenum(String num);

    public List<Map<String, Object>> getusers();

    public void guardarasesorpros(String esta, String cant, String usu);

    public List<Map<String, Object>> getProspectoasesor(String usu);

    public int contcliescalnoas();

    public int contcliestinoas();

    public int contcliesfrionoas();
    
    public List<Map<String, Object>> getEstado();
    
    public void cambiarestatiempo(String id,String esta);
}
