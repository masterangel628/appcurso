

package com.venta.curso.Interface;

import com.venta.curso.Entity.ClienteEntity;
import java.util.List;

/**
 *
 * @author Asus
 */
public interface ClienteInterface {
    public List<ClienteEntity> getCliente();
    public int existecliente(String idper);
    
    public void guardarCliente(String idper);
}
