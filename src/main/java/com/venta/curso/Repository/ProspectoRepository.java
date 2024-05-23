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

    @Query(value = "select u.id,p.dniper,concat(p.apeper,' ',p.nomper) usuario,r.role_name,f_conclienteactual(u.id) cliente from user_roles ur,roles r,users u,personas p where ur.role_id=r.id and ur.user_id=u.id and u.fkidpersona=p.idpersona", nativeQuery = true)
    public List<Map<String, Object>> getusers();

    @Modifying
    @Transactional
    @Query(value = "call p_prospecto(:esta,:cant,:usu)", nativeQuery = true)
    public void guardarasesorpros(@Param("esta") String esta, @Param("cant") String cant, @Param("usu") String usu);

    @Query(value = "select fecdetpros, fkidprospecto, iddetalleprospecto, fechorpros, celpros, nompros, estatimpros from detalleprospectos,prospectos where detalleprospectos.fkidprospecto=prospectos.idprospecto and fecdetpros=curdate() and fkidusuario=:usu", nativeQuery = true)
    public List<Map<String, Object>> getProspectoasesor(@Param("usu") String usu);

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

}
