
package com.venta.curso.Service;

import com.venta.curso.Entity.ProspectoEntity;
import com.venta.curso.Interface.ProspectoInterface;
import com.venta.curso.Repository.ProspectoRepository;
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

    @Override
    public List<Map<String, Object>> getusers() {
        return prospectorepo.getusers();
    }

    @Override
    public void guardarasesorpros(String esta, String cant, String usu) {
         prospectorepo.guardarasesorpros(esta, cant, usu); 
    }

    @Override
    public List<Map<String, Object>> getProspectoasesor(String usu) {
        return prospectorepo.getProspectoasesor(usu);
    }

    @Override
    public int contcliescalnoas() {
        return prospectorepo.contcliescalnoas();
    }

    @Override
    public int contcliestinoas() {
        return prospectorepo.contcliestinoas();
    }

    @Override
    public int contcliesfrionoas() {
        return prospectorepo.contcliesfrionoas();
    }

    @Override
    public List<Map<String, Object>> getEstado() {
        return prospectorepo.getEstado();
    }

    @Override
    public void cambiarestatiempo(String id, String esta) {
        prospectorepo.cambiarestadotiempo(esta, id); 
    }
}
