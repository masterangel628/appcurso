package com.venta.curso.Service;

import com.venta.curso.Entity.EmpresaEntity;
import com.venta.curso.Interface.EmpresaInterface;
import com.venta.curso.Repository.EmpresaRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

/**
 *
 * @author Asus
 */
@Service
@RequiredArgsConstructor
public class EmpresaService implements EmpresaInterface {

    private final EmpresaRepository empresarepo;

    @Override
    public int existeEmpresa(String ruc) {
        return empresarepo.existeEmpresa(ruc);
    }

    @Override
    public int existeEmpresaedit(String ruc, String idemp) {
        return empresarepo.existEmpresaID(ruc, idemp);
    }

    @Override
    public EmpresaEntity getEmpresa(String ruc) {
        return empresarepo.getidempresa(ruc);
    }

    @Override
    public int existecorreo(String cor) {
        return empresarepo.existecorreo(cor);
    }

    @Override
    public int existecorreoedit(String cor, int idemp) {
        return empresarepo.existecorreoedit(cor, idemp);
    }

    @Override
    public EmpresaEntity getempresacorreo(String correo) {
        return empresarepo.getempresacor(correo);
    }

    @Override
    public void guardarEmpresa(EmpresaEntity emp) {
        empresarepo.guardarempresa(emp.getRucemp(), emp.getRazsoemp(), emp.getDiremp(), emp.getCelemp(), emp.getCorreoemp(), emp.getDistrito().getIddistrito());
    }

    @Override
    public void editarEmpresa(EmpresaEntity emp) {
        empresarepo.editarempresa(emp.getRucemp(), emp.getRazsoemp(), emp.getDiremp(), emp.getCelemp(), emp.getCorreoemp(), emp.getDistrito().getIddistrito(), "" + emp.getIdempresa());
    }

}
