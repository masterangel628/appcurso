package com.venta.curso.Interface;

import com.venta.curso.Entity.PaqueteEntity;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Asus
 */
public interface PaqueteInterface {

    public List<Map<String, Object>> getPaquete();

    public PaqueteEntity savePaquete(PaqueteEntity paq);

    public void editPaquete(String nom, String idpaq);

    public void CambiarEstado(String estado, String id);

    public int existepaquete(String nom);

    public int existepaqueteedit(String nom, String idpaq);

    public List<Map<String, Object>> getCursoAc();

    public int existecursopaq(String idcur, String idpaq);

    public void guardarcursopaq(String idcur, String idpaq, String prec);

    public void eliminarcursopaq(String idcurpaq);

    public List<Map<String, Object>> getcursopaq(String idpaq);
}
