package com.venta.curso.Service;

import com.venta.curso.Entity.PersonaEntity;
import com.venta.curso.Interface.PersonaInterface;
import com.venta.curso.Repository.PersonaRepository;
import java.util.List;
import java.util.Map;
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
    public PersonaEntity getpersona(String dni) {
        return personarepo.getidpersona(dni);
    }
    @Override
    public List<Map<String, Object>> getPersona(String bus) {
        return personarepo.getpersona(bus);
    }

    @Override
    public int existepersona(String dni) {
        return personarepo.existepersona(dni);
    }

    @Override
    public int existepersonaedit(String dni, int id) {
        return personarepo.existepersonaID(dni, id);
    }

    @Override
    public List<Map<String, Object>> getDepartamento() {
        return personarepo.getDepartamento();
    }

    @Override
    public List<Map<String, Object>> getProvincia(String coddep) {
        return personarepo.getProvincia(coddep);
    }

    @Override
    public List<Map<String, Object>> getDistrito(String coddis) {
        return personarepo.getDistrito(coddis);
    }

    @Override
    public void guardarpersona(PersonaEntity per) {
         personarepo.guardarpersona(per.getDniper(), per.getNomper(), per.getApeper(), per.getDirper()
                 , per.getCelper(), per.getCorreoper(), per.getDistrito().getIddistrito()); 
    }

    @Override
    public void editarpersona(PersonaEntity per) {
         personarepo.editarpersona(per.getDniper(), per.getNomper(), per.getApeper(), per.getDirper()
                 , per.getCelper(), per.getCorreoper(), per.getDistrito().getIddistrito(),String.valueOf(per.getIdpersona()));
    }

    @Override
    public int existecorreo(String cor) {
        return personarepo.existecorreo(cor);
    }

    @Override
    public int existecorreoedit(String cor, int idper) {
        return personarepo.existecorreoedit(cor,idper);
    }

    @Override
    public void editarceldir(String cel, String dir, String id) {
         personarepo.editarceldir(cel, dir, id); 
    }

    @Override
    public Map<String, Object> getperson(String id) {
        return personarepo.getperson(id);
    }

    @Override
    public PersonaEntity getpersonacorreo(String correo) {
        return personarepo.getpersonacor(correo);
    }

    

}
