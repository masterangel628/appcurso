
package com.venta.curso.Service;

import com.venta.curso.Entity.ClienteEntity;
import com.venta.curso.Interface.ClienteInterface;
import com.venta.curso.Repository.ClienteRepository;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

/**
 *
 * @author Asus
 */
@Service
@RequiredArgsConstructor
public class ClienteService  implements ClienteInterface{
private final ClienteRepository clienterepo;
    @Override
    public List<ClienteEntity> getCliente() {
        return clienterepo.findAll();
    }

    @Override
    public int existecliente(String idper) {
        return clienterepo.existedocente(idper);
    }

    @Override
    public void guardarCliente(String idper) {
        clienterepo.guardardcli(idper); 
    }
    
}
