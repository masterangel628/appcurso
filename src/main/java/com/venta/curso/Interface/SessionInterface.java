package com.venta.curso.Interface;

import java.util.List;
import java.util.Map;

/**
 *
 * @author Asus
 */
public interface SessionInterface {

    public void abrirsession(String usu);

    public void cerrarsession(String idses);

    public int getidsession(String usu);

    public int verificasession(String usu);

    public int verificasessionabi(String usu);

    public List<Map<String, Object>> getUsuario();
    
    public Map<String, Object> getSesionultimausu(String usu);
    
    public void actualizarestado(String idses,String esta);
}
