package com.venta.curso.Repository;

import com.venta.curso.Entity.PaqueteEntity;
import java.util.List;
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
public interface PaqueteRepository extends JpaRepository<PaqueteEntity, Integer> {

    @Modifying
    @Transactional
    @Query(value = "update paquetes set estadopaq=:esta where idpaquete=:id", nativeQuery = true)
    public void CambiaEstado(@Param("esta") String esta, @Param("id") String id);

    @Query(value = "select exists(select * from paquetes where nompaq=:nom)", nativeQuery = true)
    public int existepaquete(@Param("nom") String nom);

    @Query(value = "select exists(select * from paquetes where nompaq=:nom and idpaquete<>:id)", nativeQuery = true)
    public int existepaquetedit(@Param("nom") String nom, @Param("id") String id);

    @Modifying
    @Transactional
    @Query(value = "update paquetes set nompaq=:nom where idpaquete=:id", nativeQuery = true)
    public void editpaquete(@Param("nom") String nom, @Param("id") String id);

    @Query(value = "select * from cursos where estacur='Activo'", nativeQuery = true)
    public List getCursoAc();

    @Query(value = "select exists(select * from detallepaquetes where fkidcurso=:idcur and fkidpaquete=:idpaq)", nativeQuery = true)
    public int existecursopaq(@Param("idcur") String idcur, @Param("idpaq") String idpaq);

    @Modifying
    @Transactional
    @Query(value = "insert into detallepaquetes(precpaq,fkidcurso,fkidpaquete)values(:prec,:idcur,:idpaq)", nativeQuery = true)
    public void guardarcursopaq(@Param("idcur") String idcur, @Param("idpaq") String idpaq, @Param("prec") String prec);

    @Modifying
    @Transactional
    @Query(value = "delete from  detallepaquetes where iddetallepaquete=:id", nativeQuery = true)
    public void eliminarcursopaq(@Param("id") String idcurpaq);

     @Query(value = "select * from detallepaquetes,cursos where detallepaquetes.fkidcurso=cursos.idcurso and fkidpaquete=:id ", nativeQuery = true)
    public List getcursopaq(@Param("id") String idpaq);
}
