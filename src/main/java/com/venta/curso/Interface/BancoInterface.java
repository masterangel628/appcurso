package com.venta.curso.Interface;

import com.venta.curso.Entity.BancoEntity;
import java.util.List;

/**
 *
 * @author Asus
 */
public interface BancoInterface {

    public List<BancoEntity> getBanco();

    public void saveBanco(BancoEntity Ban);

    public void Editar(String nom, String num, String id);

    public int existeBanco(String nom);

    public int existeBancoedit(String nom, String idban);
    
    public void CambiarEstado(String estado,String id);
}
