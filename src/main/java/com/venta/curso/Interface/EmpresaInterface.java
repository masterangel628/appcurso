package com.venta.curso.Interface;

import com.venta.curso.Entity.EmpresaEntity;

/**
 *
 * @author Asus
 */
public interface EmpresaInterface {

    public EmpresaEntity getEmpresa(String ruc);

    public void guardarEmpresa(EmpresaEntity emp);

    public void editarEmpresa(EmpresaEntity emp);

    public int existeEmpresa(String ruc);

    public int existeEmpresaedit(String ruc, String idemp);

    public int existecorreo(String cor);

    public int existecorreoedit(String cor, int idper);

    public EmpresaEntity getempresacorreo(String correo);
}
