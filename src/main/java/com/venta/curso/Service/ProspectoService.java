
package com.venta.curso.Service;

import com.venta.curso.Entity.ProspectoEntity;
import com.venta.curso.Interface.ProspectoInterface;
import com.venta.curso.Repository.ProspectoRepository;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

/**
 *
 * @author Asus
 */
@Service
@RequiredArgsConstructor
public class ProspectoService implements ProspectoInterface{
    private final ProspectoRepository prospectorepo;

    @Override
    public void guardar(ProspectoEntity pros) {
        prospectorepo.save(pros);
    }

    @Override
    public List<ProspectoEntity> getProspecto() {
        return prospectorepo.findAll();
    }

    @Override
    public String fecactual() {
        return prospectorepo.fecactual();
    }

    @Override
    public int existenum(String num) {
        return prospectorepo.existenum(num);
    }
}
