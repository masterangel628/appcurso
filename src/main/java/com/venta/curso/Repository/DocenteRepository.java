package com.venta.curso.Repository;

import com.venta.curso.Entity.DocenteEntity;
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
public interface DocenteRepository extends JpaRepository<DocenteEntity, Integer> {

    @Modifying
    @Transactional
    @Query(value = "update docentes set estadodoc=:esta where iddocente=:id", nativeQuery = true)
    public void CambiaEstado(@Param("esta") String esta, @Param("id") String id);

    @Query(value = "select exists(select * from docentes where fkidpersona=:idper)", nativeQuery = true)
    public int existedocente(@Param("idper") String idper);

    @Modifying
    @Transactional
    @Query(value = "insert into docentes(estadodoc,fkidpersona)values(:esta,:idper)", nativeQuery = true)
    public void guardardoc(@Param("esta") String esta, @Param("idper") String idper);

    @Query(value = "select * from docentes,personas where docentes.fkidpersona=personas.idpersona and estadodoc='ACTIVO'", nativeQuery = true)
    public List<Map<String, Object>> getDocenteActivo();

}
