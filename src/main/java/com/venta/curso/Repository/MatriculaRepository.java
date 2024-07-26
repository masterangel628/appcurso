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
    @Query(value = "update matriculas set estadomat='MATRICULA' where idmatricula=:id", nativeQuery = true)
    public void verificar(@Param("id") String idmat);
    
    @Modifying
    @Transactional
    @Query(value = "update matriculas set estamat='INACTIVO',descmat=:des where idmatricula=:id", nativeQuery = true)
    public void cancelar(@Param("id") String idmat,@Param("des") String des);

    @Query(value = "select * from v_matriculareporte where fecmat between :fecdes and :fechas", nativeQuery = true)
    public List<Map<String, Object>> getMatriculareport(@Param("fecdes") String fecdes, @Param("fechas") String fechas);

    @Query(value = "select * from v_detallematreport where idmatricula=:id and estadetmat=:esta", nativeQuery = true)
    public List<Map<String, Object>> getDetallematreport(@Param("id") String idmat, @Param("esta") String esta);

    @Query(value = "select estadetmat from v_detallematreport where idmatricula=:id group by estadetmat", nativeQuery = true)
    public List<Map<String, Object>> getPaqueteoCurso(@Param("id") String idmat);

    @Query(value = "select codcur from detallepaquetes,cursos where detallepaquetes.fkidcurso=cursos.idcurso and fkidpaquete=:id", nativeQuery = true)
    public List<Map<String, Object>> getCursoPaquete(@Param("id") String idpaq);

    
    
    
    @Query(value = "select sum(montomat) from v_reportdetventa where fecmat between :fecdes and :fechas", nativeQuery = true)
    public String getMontofec(@Param("fecdes") String fecdes, @Param("fechas") String fechas);

    @Query(value = "select * from v_reportdetventa where fecmat between :feci and :fecf order by fecmat", nativeQuery = true)
    public List<Map<String, Object>> getVentareport(@Param("feci") String fecdes, @Param("fecf") String fechas);
    
    @Query(value = "select * from v_reportdetventa order by fecmat", nativeQuery = true)
    public List<Map<String, Object>> getVenta();
    

}
