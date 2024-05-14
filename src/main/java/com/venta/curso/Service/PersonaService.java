package com.venta.curso.Service;

import com.venta.curso.Entity.PersonaEntity;
import com.venta.curso.Interface.PersonaInterface;
import com.venta.curso.Repository.PersonaRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

/**
 *
 * @author Asus
 */
@Service
@RequiredArgsConstructor
public class PersonaService implements PersonaInterface {

    private final PersonaRepository personarepo;

    @Override
    public PersonaEntity editPersona(PersonaEntity per) {
        return personarepo.save(per);
    }

    @Override
    public PersonaEntity getidpersona(String dni) {
        return personarepo.getidpersona(dni);
    }

    @Override
    public int existepersona(String dni) {
        return personarepo.existepersona(dni);
    }

    @Override
    public int existepersonaedit(String dni, int id) {
        return personarepo.existepersonaID(dni, id);
    }

}
