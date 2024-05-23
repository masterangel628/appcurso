package com.venta.curso.Service;

import com.venta.curso.Entity.DocenteEntity;
import com.venta.curso.Interface.DocenteInterface;
import com.venta.curso.Repository.DocenteRepository;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

/**
 *
 * @author Asus
 */
@Service
@RequiredArgsConstructor
public class DocenteService implements DocenteInterface {

    private final DocenteRepository docenterepo;

    @Override
    public List<DocenteEntity> getDocente() {
        return docenterepo.findAll();
    }

    @Override
    public DocenteEntity saveDocente(DocenteEntity alum) {
        return docenterepo.save(alum);
    }

    @Override
    public DocenteEntity editDocente(DocenteEntity alum) {
        return docenterepo.save(alum);
    }

    @Override
    public void CambiarEstado(String esta,String id) {
        docenterepo.CambiaEstado(esta,id);
    }

    @Override
    public int existedocente(String idper) {
         return docenterepo.existedocente(idper);
    }

    @Override
    public void guardardoc(String idper, String esta) {
        docenterepo.guardardoc(esta, idper);
    }

}
