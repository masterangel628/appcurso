package com.venta.curso.Interface;

import com.venta.curso.Entity.ProspectoEntity;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Asus
 */
public interface ProspectoInterface {
    
    public List<Map<String, Object>> getbanco();

    public void guardar(ProspectoEntity pros);

    public List<ProspectoEntity> getProspecto();

    public String fecactual();
    
    public void actualizardesc(String desc,String idpro);

    public int existenum(String num);

    public List<Map<String, Object>> getusers();

    public  List<Map<String, Object>> guardarasesorpros(String esta, String cant, String usu);

    public List<Map<String, Object>> getProspectoasesor(String usu);

    public List<Map<String, Object>> getProspectoasesorverificado(String usu);
    
    public List<Map<String, Object>> getProspectoasesornoverificado(String usu);
    
     public List<Map<String, Object>> getProspectoasesorall(String usu);

    public int contcliescalnoas();

    public int contcliestinoas();

    public int contcliesfrionoas();

    public List<Map<String, Object>> getEstado();

    public void cambiarestatiempo(String id, String esta,int dias);

    public List<Map<String, Object>> getCurso();

    public List<Map<String, Object>> getPaquete();

    public List<Map<String, Object>> procesoprematricula(String curpaq, String tipo, String usu, String detpro);

    public List<Map<String, Object>> getComanda(String idses, String detpro);

    public void eliminarcomanda(String ico);

    public List<Map<String, Object>> prematricula(String cli, String ses, String tip, String detpro,String ban);

    public List<Map<String, Object>> getPaquetecurso(String idpaq);

    public void Actualizarpveri(String iddetpros);
    
    public void Actualizarpnoveri(String iddetpros);

    public void Actualizarestadotiempo();

    public void Actualizarnoasignado();

    public int cantclienteasignado(String usu);

    public int cantclienteverificado(String usu);

    public int cantclientenoverificado(String usu);

    public int cantclientematriculado(String usu);

}
