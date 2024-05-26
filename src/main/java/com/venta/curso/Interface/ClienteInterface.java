package com.venta.curso.Interface;

import com.venta.curso.Entity.ClienteEntity;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Asus
 */
public interface ClienteInterface {

    public List<ClienteEntity> getCliente();

    public int existecliente(String idper);

    public void guardarCliente(String idper);

    public List<Map<String, Object>> getclientebuscar(String bus);
}
