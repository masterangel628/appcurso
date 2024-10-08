package com.venta.curso.Repository;

import com.venta.curso.Entity.ProspectoEntity;
import java.util.List;
import java.util.Map;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author Asus
 */
@Repository
public interface ProspectoRepository extends JpaRepository<ProspectoEntity, Integer> {

    @Query(value = "select exists(select * from prospectos where celpros=:num)", nativeQuery = true)
    public int existenum(@Param("num") String num);

    @Query(value = "select curdate()", nativeQuery = true)
    public String fecactual();

    @Query(value = "select u.id,p.dniper,concat(p.apeper,' ',p.nomper) usuario,r.role_name,f_conclienteactual(u.id) cliente from user_roles ur,roles r,users u,personas p where ur.role_id=r.id and ur.user_id=u.id and u.fkidpersona=p.idpersona  and estado='ACTIVO'", nativeQuery = true)
    public List<Map<String, Object>> getusers();

    @Modifying
    @Transactional
    @Query(value = "call p_prospecto(:esta,:cant,:usu)", nativeQuery = true)
    public List<Map<String, Object>> guardarasesorpros(@Param("esta") String esta, @Param("cant") String cant, @Param("usu") String usu);

    @Modifying
    @Transactional
    @Query(value = "update prospectos set descpros=:desc where idprospecto=:idpro", nativeQuery = true)
    public void actualizardesc(@Param("desc") String desc, @Param("idpro") String idpro);

    @Query(value = "select fecdetpros, fkidprospecto, iddetalleprospecto, fechorpros, celpros, nompros, estatimpros from detalleprospectos,prospectos where detalleprospectos.fkidprospecto=prospectos.idprospecto and fecdetpros=curdate() and fkidusuario=:usu and estaaspros='ASIGNADO'", nativeQuery = true)
    public List<Map<String, Object>> getProspectoasesor(@Param("usu") String usu);

    @Query(value = "select fecdetpros, fkidprospecto, iddetalleprospecto, fechorpros, celpros, nompros, estatimpros from detalleprospectos,prospectos where detalleprospectos.fkidprospecto=prospectos.idprospecto and fecdetpros=curdate() and fkidusuario=:usu and estaaspros='ASIGNADO'  and estaverdetpros='NOVERIFICADO'", nativeQuery = true)
    public List<Map<String, Object>> getProspectoasesornoverificado(@Param("usu") String usu);

    @Query(value = "select fecdetpros, fkidprospecto, iddetalleprospecto, fechorpros, celpros, nompros, estatimpros from detalleprospectos,prospectos where detalleprospectos.fkidprospecto=prospectos.idprospecto and fecdetpros=curdate() and fkidusuario=:usu and estaaspros='ASIGNADO'  and estaverdetpros='VERIFICADO'", nativeQuery = true)
    public List<Map<String, Object>> getProspectoasesorverificado(@Param("usu") String usu);

    @Query(value = "select fecdetpros, fkidprospecto, iddetalleprospecto, fechorpros, celpros, nompros, estatimpros,estaverdetpros,descpros from detalleprospectos,prospectos where detalleprospectos.fkidprospecto=prospectos.idprospecto and fecdetpros=curdate() and fkidusuario=:usu and estaaspros='ASIGNADO'", nativeQuery = true)
    public List<Map<String, Object>> getProspectoasesorall(@Param("usu") String usu);

    @Query(value = "select count(*) from prospectos where estatimpros='CALIENTE' and estaaspros='NOASIGNADO'", nativeQuery = true)
    public int contcliescalnoas();

    @Query(value = "select count(*) from prospectos where estatimpros='TIBIO' and estaaspros='NOASIGNADO'", nativeQuery = true)
    public int contcliestinoas();

    @Query(value = "select count(*) from prospectos where estatimpros='FRIO' and estaaspros='NOASIGNADO'", nativeQuery = true)
    public int contcliesfrionoas();

    @Query(value = "select  distinct estatimpros from prospectos where estaaspros='NOASIGNADO'", nativeQuery = true)
    public List<Map<String, Object>> getEstado();

    @Modifying
    @Transactional
    @Query(value = "update prospectos set estatimpros=:esta,fechorpros=date_add(curdate(), interval :dias day) where idprospecto=:id", nativeQuery = true)
    public void cambiarestadotiempo(@Param("esta") String esta, @Param("id") String id, @Param("dias") String dias);

    @Query(value = "select * from cursos where estacur='ACTIVO'", nativeQuery = true)
    public List<Map<String, Object>> getCurso();

    @Query(value = "select * from paquetes where estadopaq='ACTIVO'", nativeQuery = true)
    public List<Map<String, Object>> getPaquete();

    @Modifying
    @Transactional
    @Query(value = "call p_procesoprematricula(:tipo,:usu,:cp,:detpro)", nativeQuery = true)
    public List<Map<String, Object>> procesoprematricula(@Param("cp") String cp, @Param("tipo") String tipo, @Param("usu") String usu, @Param("detpro") String detpro);

    @Query(value = "select * from v_comanda where fkidsession=:idses and detpros=:iddetpros", nativeQuery = true)
    public List<Map<String, Object>> getComanda(@Param("idses") String idses, @Param("iddetpros") String iddetpros);

    @Modifying
    @Transactional
    @Query(value = "delete from comandas where idcomanda=:id", nativeQuery = true)
    public void eliminarcomanda(@Param("id") String id);

    @Query(value = "select * from bancos where estadoban='ACTIVO'", nativeQuery = true)
    public List<Map<String, Object>> getbanco();

    @Modifying
    @Transactional
    @Query(value = "call p_prematricula(:ses,:tip,:detpro,:ban,:descu,:band)", nativeQuery = true)
    public List<Map<String, String>> prematricula(@Param("ses") String ses, @Param("tip") String tip, @Param("detpro") String detpro, @Param("ban") String ban,
            @Param("descu") String descu, @Param("band") String band);

    @Query(value = "select  precpaq, nomcur from detallepaquetes,cursos where detallepaquetes.fkidcurso=cursos.idcurso and fkidpaquete=:id", nativeQuery = true)
    public List<Map<String, Object>> getPaquetecurso(@Param("id") String idpaq);

    @Modifying
    @Transactional
    @Query(value = "update detalleprospectos set estaverdetpros='VERIFICADO' where iddetalleprospecto=:id", nativeQuery = true)
    public void Actualizarpveri(@Param("id") String iddetpro);

    @Modifying
    @Transactional
    @Query(value = "update detalleprospectos set estaverdetpros='NOVERIFICADO' where iddetalleprospecto=:id", nativeQuery = true)
    public void Actualizarpnoveri(@Param("id") String iddetpro);

    @Modifying
    @Transactional
    @Query(value = "call p_cambiarestado()", nativeQuery = true)
    public void Actualizarestadotiempo();

    @Modifying
    @Transactional
    @Query(value = "call p_prospectolimpiar()", nativeQuery = true)
    public void Actualizarnoasignado();

    @Query(value = "call p_data(:id,1)", nativeQuery = true)
    public int cantclienteverificado(@Param("id") String idusu);

    @Query(value = "call p_data(:id,2)", nativeQuery = true)
    public int cantclientenoverificado(@Param("id") String idusu);

    @Query(value = "call p_data(:id,4)", nativeQuery = true)
    public int cantclientematriculado(@Param("id") String idusu);

    @Query(value = "call p_data(:id,3)", nativeQuery = true)
    public int cantclienteasignado(@Param("id") String idusu);

    @Query(value = "select fkidsession, detpros,getpersona(idper) persona,getcliente(idcli) cliente,gettipo(idcli) tipo from comandaclis where fkidsession=:idses and detpros=:detpro", nativeQuery = true)
    public List<Map<String, Object>> getClicom(@Param("idses") String idses, @Param("detpro") String detpro);

    @Modifying
    @Transactional
    @Query(value = "call p_pmcliente(:usu,:per,:cli,:detpro)", nativeQuery = true)
    public void guardarClicom(@Param("usu") String usu, @Param("per") String per, @Param("cli") String cli, @Param("detpro") String detpro);

    @Query(value = "select sum(montocom) from v_comanda where fkidsession=:idses and detpros=:detpro", nativeQuery = true)
    public String getmontoprem(@Param("idses") String idses, @Param("detpro") String detpro);

    @Query(value = "select fecdetpros, fkidprospecto, iddetalleprospecto, fechorpros, celpros, nompros, estatimpros,estaverdetpros,descpros from detalleprospectos,prospectos where detalleprospectos.fkidprospecto=prospectos.idprospecto and fecdetpros=curdate() and fkidusuario=:usu and estaaspros='ASIGNADO'", nativeQuery = true)
    public List<Map<String, Object>> getClienteAsig(@Param("usu") String idus);
}
