package com.venta.curso.Interface;

import java.util.List;
import java.util.Map;

/**
 *
 * @author Asus
 */
public interface ClienteInterface {

    public List<Map<String, Object>> getCliente();

    public int existeclienteDNI(String idper);

    public int existeclienteRUC(String idemp);

    public void guardarClientedni(String idper);

    public void guardarClienteruc(String idemp);

    public List<Map<String, Object>> getclientebuscar(String tipo, String bus);
}
