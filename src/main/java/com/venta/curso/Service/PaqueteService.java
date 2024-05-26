package com.venta.curso.Service;

import com.venta.curso.Entity.PaqueteEntity;
import com.venta.curso.Interface.PaqueteInterface;
import com.venta.curso.Repository.PaqueteRepository;
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
public class PaqueteService implements PaqueteInterface {

    private final PaqueteRepository paqueterepo;

    @Override
    public List<Map<String, Object>> getPaquete() {
        return paqueterepo.getPaquete();
    }

    @Override
    public PaqueteEntity savePaquete(PaqueteEntity paq) {
        return paqueterepo.save(paq);
    }
    @Override
    public void CambiarEstado(String estado, String id) {
        paqueterepo.CambiaEstado(estado, id);
    }

    @Override
    public int existepaquete(String nom) {
        return paqueterepo.existepaquete(nom);
    }

    @Override
    public int existepaqueteedit(String nom, String idpaq) {
        return paqueterepo.existepaquetedit(nom, idpaq);
    }

    @Override
    public void editPaquete(String nom, String idpaq) {
        paqueterepo.editpaquete(nom, idpaq);
    }

    @Override
    public List<Map<String, Object>> getCursoAc() {
        return paqueterepo.getCursoAc();
    }

    @Override
    public int existecursopaq(String idcur, String idpaq) {
        return paqueterepo.existecursopaq(idcur, idpaq);
    }

    @Override
    public void guardarcursopaq(String idcur, String idpaq, String prec) {
        paqueterepo.guardarcursopaq(idcur, idpaq, prec);
    }

    @Override
    public void eliminarcursopaq(String idcurpaq) {
        paqueterepo.eliminarcursopaq(idcurpaq);
    }

    @Override
    public List<Map<String, Object>> getcursopaq(String idpaq) {
        return paqueterepo.getcursopaq(idpaq);
    }

}
