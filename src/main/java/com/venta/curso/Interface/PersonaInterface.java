
package com.venta.curso.Interface;

import com.venta.curso.Entity.PersonaEntity;

/**
 *
 * @author Asus
 */
public interface PersonaInterface {
    public PersonaEntity editPersona(PersonaEntity per);
    public PersonaEntity getidpersona(String dni);
    public int existepersona(String dni);
    public int existepersonaedit(String dni, int idper);
}
