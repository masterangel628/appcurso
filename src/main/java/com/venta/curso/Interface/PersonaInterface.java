package com.venta.curso.Interface;

import com.venta.curso.Entity.PersonaEntity;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Asus
 */
public interface PersonaInterface {

    public PersonaEntity getpersona(String dni);

    public int existepersona(String dni);

    public int existecorreo(String cor);

    public int existecorreoedit(String cor, int idper);

    public int existepersonaedit(String dni, int idper);

    public List<Map<String, Object>> getDepartamento();

    public List<Map<String, Object>> getProvincia(String coddep);

    public List<Map<String, Object>> getDistrito(String coddis);

    public void guardarpersona(PersonaEntity per);

    public void editarpersona(PersonaEntity per);

    public void editarceldir(String cel, String dir, String id);

    public Map<String, Object> getperson(String id);
}
