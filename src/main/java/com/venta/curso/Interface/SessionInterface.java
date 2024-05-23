package com.venta.curso.Interface;

import com.venta.curso.Entity.SessionEntity;
import java.util.List;

/**
 *
 * @author Asus
 */
public interface SessionInterface {

    public void abrirsession(String usu);

    public void cerrarsession(String idses);
    
    public int getidsession(String usu);

    public List<SessionEntity> getSession();
    
    public int verificasession(String usu);
    public int verificasessionabi(String usu);
}
