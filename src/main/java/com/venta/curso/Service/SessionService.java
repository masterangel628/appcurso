
package com.venta.curso.Service;

import com.venta.curso.Entity.SessionEntity;
import com.venta.curso.Interface.SessionInterface;
import com.venta.curso.Repository.SessionRepository;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

/**
 *
 * @author Asus
 */
@Service
@RequiredArgsConstructor
public class SessionService implements SessionInterface{

    private final SessionRepository sessionrepo;
    @Override
    public void abrirsession(String usu) {
        sessionrepo.abrirsession(usu); 
    }

    @Override
    public void cerrarsession(String idses) {
        sessionrepo.cerrarsession(idses); 
    }

    @Override
    public int getidsession(String usu) {
        return sessionrepo.getidsession(usu);
    }

    @Override
    public List<SessionEntity> getSession() {
        return sessionrepo.findAll();
    }

    @Override
    public int verificasession(String usu) {
        return sessionrepo.verificasession(usu);
    }

    @Override
    public int verificasessionabi(String usu) {
         return sessionrepo.verificasessionabi(usu);
    }
    
}
