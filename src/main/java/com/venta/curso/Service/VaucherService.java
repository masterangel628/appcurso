
package com.venta.curso.Service;

import com.venta.curso.Interface.VaucherInterface;
import com.venta.curso.Repository.VaucherRepository;
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
public class VaucherService implements VaucherInterface{

    private final VaucherRepository vaucherrepo;
    @Override
    public void save(String nom, String fkidmat) {
        vaucherrepo.save(fkidmat, nom);
    }

    @Override
    public List<Map<String, Object>> getVaucher(String fkidmat) {
        return vaucherrepo.getvaucher(fkidmat); 
    }
    
}
