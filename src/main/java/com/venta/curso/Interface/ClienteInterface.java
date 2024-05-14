

package com.venta.curso.Interface;

import com.venta.curso.Entity.ClienteEntity;
import java.util.List;

/**
 *
 * @author Asus
 */
public interface ClienteInterface {
    public List<ClienteEntity> getCliente();
    public ClienteEntity saveCliente(ClienteEntity cli);
    public ClienteEntity editCliente(ClienteEntity cli);
    public int existecliente(String idper);
}
