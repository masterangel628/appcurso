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
public class ProspectoService implements ProspectoInterface {

    private final ProspectoRepository prospectorepo;

    @Override
    public void guardar(ProspectoEntity pros) {
        prospectorepo.save(pros);
    }

    @Override
    public List<Map<String, Object>> getbanco() {
        return prospectorepo.getbanco();
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
    public List<Map<String, Object>> guardarasesorpros(String esta, String cant, String usu) {
        return prospectorepo.guardarasesorpros(esta, cant, usu);
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
    public void cambiarestatiempo(String id, String esta, int dias) {
        prospectorepo.cambiarestadotiempo(esta, id, String.valueOf(dias));
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
    public List<Map<String, Object>> procesoprematricula(String curpaq, String tipo, String usu, String detpro) {
        return prospectorepo.procesoprematricula(curpaq, tipo, usu, detpro);
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

    @Override
    public List<Map<String, String>> prematricula(String ses, String tip, String detpro, String ban,String descu,
            String band) {
        return prospectorepo.prematricula(ses, tip, detpro, ban,descu,band);
    }

    @Override
    public List<Map<String, Object>> getProspectoasesornoverificado(String usu) {
        return prospectorepo.getProspectoasesornoverificado(usu);
    }

    @Override
    public void Actualizarpnoveri(String iddetpros) {
        prospectorepo.Actualizarpnoveri(iddetpros);
    }

    @Override
    public List<Map<String, Object>> getProspectoasesorall(String usu) {
        return prospectorepo.getProspectoasesorall(usu);
    }

    @Override
    public void actualizardesc(String desc, String idpro) {
        prospectorepo.actualizardesc(desc, idpro);
    }

    @Override
    public List<Map<String, Object>> getClicom(String idses, String detpro) {
        return prospectorepo.getClicom(idses, detpro);
    }

    @Override
    public void guardarClicom(String idses, String detpro, String per, String cli) {
        prospectorepo.guardarClicom(idses, per, cli, detpro);
    }

    @Override
    public String getmontoprem(String idses, String detpro) {
        return prospectorepo.getmontoprem(idses, detpro);
    }
}
