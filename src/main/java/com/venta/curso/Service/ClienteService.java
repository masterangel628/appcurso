package com.venta.curso.Service;

import com.venta.curso.Entity.ClienteEntity;
import com.venta.curso.Interface.ClienteInterface;
import com.venta.curso.Repository.ClienteRepository;
import java.util.List;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

/**
 *
 * @author Asus
 */
@Service
@RequiredArgsConstructor
public class ClienteService implements ClienteInterface {

    private final ClienteRepository clienterepo;

    @Override
    public List<Map<String, Object>> getCliente() {
        return clienterepo.getCliente();
    }

    @Override
    public List<Map<String, Object>> getclientebuscar(String tipo, String bus) {
        return clienterepo.getclientebuscar(tipo, bus);
    }

    @Override
    public void guardarClientedni(String idper) {
        clienterepo.guardardclidni(idper);
    }

    @Override
    public void guardarClienteruc(String idemp) {
        clienterepo.guardardcliruc(idemp);
    }

    @Override
    public int existeclienteDNI(String idper) {
        return clienterepo.existeclientedni(idper);
    }

    @Override
    public int existeclienteRUC(String idemp) {
        return clienterepo.existeclienteruc(idemp);
    }
}
