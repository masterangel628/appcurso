
package com.venta.curso.Service;

import com.venta.curso.Entity.ProspectoEntity;
import com.venta.curso.Interface.ProspectoInterface;
import com.venta.curso.Repository.ProspectoRepository;
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
public class ProspectoService implements ProspectoInterface{
    private final ProspectoRepository prospectorepo;

    @Override
    public void guardar(ProspectoEntity pros) {
        prospectorepo.save(pros);
    }

    @Override
    public List<ProspectoEntity> getProspecto() {
        return prospectorepo.findAll();
    }

    @Override
    public String fecactual() {
        return prospectorepo.fecactual();
    }

    @Override
    public int existenum(String num) {
        return prospectorepo.existenum(num);
    }

    @Override
    public List<Map<String, Object>> getusers() {
        return prospectorepo.getusers();
    }

    @Override
    public void guardarasesorpros(String esta, String cant, String usu) {
         prospectorepo.guardarasesorpros(esta, cant, usu); 
    }

    @Override
    public List<Map<String, Object>> getProspectoasesor(String usu) {
        return prospectorepo.getProspectoasesor(usu);
    }

    @Override
    public int contcliescalnoas() {
        return prospectorepo.contcliescalnoas();
    }

    @Override
    public int contcliestinoas() {
        return prospectorepo.contcliestinoas();
    }

    @Override
    public int contcliesfrionoas() {
        return prospectorepo.contcliesfrionoas();
    }

    @Override
    public List<Map<String, Object>> getEstado() {
        return prospectorepo.getEstado();
    }

    @Override
    public void cambiarestatiempo(String id, String esta) {
        prospectorepo.cambiarestadotiempo(esta, id); 
    }

    @Override
    public List<Map<String, Object>> getCurso() {
        return prospectorepo.getCurso();
    }

    @Override
    public List<Map<String, Object>> getPaquete() {
        return prospectorepo.getPaquete();
    }

    @Override
    public List<Map<String, Object>> procesoprematricula(String curpaq, String tipo, String usu,String detpro) {
        return prospectorepo.procesoprematricula(curpaq, tipo, usu,detpro); 
    }

    @Override
    public List<Map<String, Object>> getComanda(String idses, String detpro) {
        return prospectorepo.getComanda(idses, detpro);
    }

    @Override
    public void eliminarcomanda(String ico) {
         prospectorepo.eliminarcomanda(ico);
    }

    @Override
    public void prematricula(String cli, String ses, String tip, String detpro) {
        prospectorepo.prematricula(cli, ses, tip, detpro);
    }

    @Override
    public List<Map<String, Object>> getPaquetecurso(String idpaq) {
        return prospectorepo.getPaquetecurso(idpaq);
    }

    @Override
    public List<Map<String, Object>> getProspectoasesorverificado(String usu) {
        return prospectorepo.getProspectoasesorverificado(usu);
    }

    @Override
    public void Actualizarpveri(String iddetpros) {
        prospectorepo.Actualizarpveri(iddetpros);
    }

    @Override
    public void Actualizarestadotiempo() {
        prospectorepo.Actualizarestadotiempo();
    }

    @Override
    public void Actualizarnoasignado() {
        prospectorepo.Actualizarnoasignado();
    }

    @Override
    public int cantclienteasignado(String usu) {
        return prospectorepo.cantclienteasignado(usu);
    }

    @Override
    public int cantclienteverificado(String usu) {
        return prospectorepo.cantclienteverificado(usu);
    }

    @Override
    public int cantclientenoverificado(String usu) {
        return prospectorepo.cantclientenoverificado(usu);
    }

    @Override
    public int cantclientematriculado(String usu) {
        return prospectorepo.cantclientematriculado(usu);
    }
}
