
package com.venta.curso.Interface;

import com.venta.curso.Entity.PaqueteEntity;
import java.util.List;

/**
 *
 * @author Asus
 */
public interface PaqueteInterface {

    public List<PaqueteEntity> getPaquete();

    public PaqueteEntity savePaquete(PaqueteEntity paq);

    public void editPaquete(String nom, String idpaq);

    public void CambiarEstado(String estado, String id);

    public int existepaquete(String nom);

    public int existepaqueteedit(String nom, String idpaq);

    public List getCursoAc();

    public int existecursopaq(String idcur, String idpaq);

    public void guardarcursopaq(String idcur, String idpaq, String prec);

    public void eliminarcursopaq(String idcurpaq);

    public List getcursopaq(String idpaq);
}
