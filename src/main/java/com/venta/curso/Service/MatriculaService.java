
package com.venta.curso.Service;

import com.venta.curso.Interface.MatriculaInterface;
import com.venta.curso.Repository.MatriculaRepository;
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
public class MatriculaService implements MatriculaInterface{

    private final MatriculaRepository matricularepo;
    @Override
    public List<Map<String, Object>> getMatricula() {
        return matricularepo.getMatricula();
    }


    @Override
    public List<Map<String, Object>> getbanco() {
        return  matricularepo.getbanco();
    }

    @Override
    public List<Map<String, Object>> getPrematricula() {
        return  matricularepo.getPrematricula();
    }

    @Override
    public void actualizarpago(String idmat, String vau, String ban) {
        matricularepo.actualizarpago(vau, ban, idmat); 
    }

    @Override
    public void verificar(String idmat) {
        matricularepo.verificar(idmat); 
    }

    @Override
    public List<Map<String, Object>> getMatriculareport(String fecdes,String fechas) {
        return matricularepo.getMatriculareport(fecdes, fechas);
    }

    @Override
    public List<Map<String, Object>> getDetallematreport(String idmat,String esta) {
        return matricularepo.getDetallematreport(idmat,esta);
    }
    
    @Override
    public List<Map<String, Object>> getPaqueteoCurso(String idmat) {
        return matricularepo.getPaqueteoCurso(idmat);
    }
    
    @Override
    public List<Map<String, Object>> getCursoPaquete(String idpaq) {
        return matricularepo.getCursoPaquete(idpaq);
    }
    
   

    
    
}
