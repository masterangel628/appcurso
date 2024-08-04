package com.venta.curso.Repository;

import com.venta.curso.Entity.MatriculaEntity;
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
public interface MatriculaRepository extends JpaRepository<MatriculaEntity, Integer> {

    @Query(value = "select * from v_matricula where estadomat='PREMATRICULA' and estamat='ACTIVO'", nativeQuery = true)
    public List<Map<String, Object>> getPrematricula();

    @Query(value = "select * from v_matricula where estadomat='MATRICULA'", nativeQuery = true)
    public List<Map<String, Object>> getMatricula();

    @Modifying
    @Transactional
    @Query(value = "call p_vermatyecomp(:mat,:tip,:num,:ev)", nativeQuery = true)
    public List<Map<String, Object>> verificar(@Param("mat") String mat, @Param("tip") String tip, @Param("num") String num, @Param("ev") String ev);

    @Modifying
    @Transactional
    @Query(value = "update matriculas set estamat='INACTIVO',descmat=:des where idmatricula=:id", nativeQuery = true)
    public void cancelar(@Param("id") String idmat, @Param("des") String des);

    @Query(value = "select * from v_matriculareporte where estadomat='MATRICULA' and estamat='ACTIVO' and fecmat between :fecdes and :fechas", nativeQuery = true)
    public List<Map<String, Object>> getMatriculareport(@Param("fecdes") String fecdes, @Param("fechas") String fechas);

    @Query(value = "select * from v_detallematreport where idmatricula=:id and estadetmat=:esta", nativeQuery = true)
    public List<Map<String, Object>> getDetallematreport(@Param("id") String idmat, @Param("esta") String esta);

    @Query(value = "select estadetmat from v_detallematreport where idmatricula=:id group by estadetmat", nativeQuery = true)
    public List<Map<String, Object>> getPaqueteoCurso(@Param("id") String idmat);

    @Query(value = "select codcur from detallepaquetes,cursos where detallepaquetes.fkidcurso=cursos.idcurso and fkidpaquete=:id", nativeQuery = true)
    public List<Map<String, Object>> getCursoPaquete(@Param("id") String idpaq);

    @Query(value = "select sum(montomat) from v_reportdetventa where estadomat='MATRICULA' and fecmat between :fecdes and :fechas", nativeQuery = true)
    public String getMontofec(@Param("fecdes") String fecdes, @Param("fechas") String fechas);

    @Query(value = "select * from v_reportdetventa where estadomat='MATRICULA' and fecmat between :feci and :fecf order by fecmat", nativeQuery = true)
    public List<Map<String, Object>> getVentareport(@Param("feci") String fecdes, @Param("fecf") String fechas);

    @Query(value = "select * from v_reportdetventa where estadomat='MATRICULA' order by fecmat", nativeQuery = true)
    public List<Map<String, Object>> getVenta();

    @Query(value = "select * from tipocomprobantes", nativeQuery = true)
    public List<Map<String, Object>> getTipocomprobante();

    @Query(value = "select f_gencomprobante(:tip) as getnum", nativeQuery = true)
    public List<Map<String, Object>> getNumero(@Param("tip") String tip);

    @Query(value = "select * from v_venta where idmatricula=:mat", nativeQuery = true)
    public List<Map<String, Object>> getventa(@Param("mat") String mat);

    @Query(value = " select * from v_detventa where fkidmatricula=:mat", nativeQuery = true)
    public List<Map<String, Object>> getdetventa(@Param("mat") String mat);
    
    @Modifying
    @Transactional
    @Query(value = "update comprobantes set desccomp=:des , obscomp=:note where idcomprobante=:id", nativeQuery = true)
    public void actualizarcom(@Param("id") String id, @Param("des") String des, @Param("note") String note);
    
     

}
