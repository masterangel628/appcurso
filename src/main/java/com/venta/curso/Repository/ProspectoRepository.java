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
    public void guardarasesorpros(@Param("esta") String esta, @Param("cant") String cant, @Param("usu") String usu);

    @Query(value = "select fecdetpros, fkidprospecto, iddetalleprospecto, fechorpros, celpros, nompros, estatimpros from detalleprospectos,prospectos where detalleprospectos.fkidprospecto=prospectos.idprospecto and fecdetpros=curdate() and fkidusuario=:usu and estaaspros='ASIGNADO'", nativeQuery = true)
    public List<Map<String, Object>> getProspectoasesor(@Param("usu") String usu);

    @Query(value = "select fecdetpros, fkidprospecto, iddetalleprospecto, fechorpros, celpros, nompros, estatimpros from detalleprospectos,prospectos where detalleprospectos.fkidprospecto=prospectos.idprospecto and fecdetpros=curdate() and fkidusuario=:usu and estaaspros='ASIGNADO'  and estaverdetpros='NOVERIFICADO'", nativeQuery = true)
    public List<Map<String, Object>> getProspectoasesorverificado(@Param("usu") String usu);

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
    @Query(value = "update prospectos set estatimpros=:esta where idprospecto=:id", nativeQuery = true)
    public void cambiarestadotiempo(@Param("esta") String esta, @Param("id") String id);

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

    @Modifying
    @Transactional
    @Query(value = "call p_prematricula(:cli,:ses,:tip,:detpro)", nativeQuery = true)
    public void prematricula(@Param("cli") String cli, @Param("ses") String ses, @Param("tip") String tip, @Param("detpro") String detpro);

    @Query(value = "select  precpaq, nomcur from detallepaquetes,cursos where detallepaquetes.fkidcurso=cursos.idcurso and fkidpaquete=:id", nativeQuery = true)
    public List<Map<String, Object>> getPaquetecurso(@Param("id") String idpaq);

    @Modifying
    @Transactional
    @Query(value = "update detalleprospectos set estaverdetpros='VERIFICADO' where iddetalleprospecto=:id", nativeQuery = true)
    public void Actualizarpveri(@Param("id") String iddetpro);

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

}
