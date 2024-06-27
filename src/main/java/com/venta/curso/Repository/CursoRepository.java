package com.venta.curso.Repository;

import com.venta.curso.Entity.CursoEntity;
import java.math.BigDecimal;
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
public interface CursoRepository extends JpaRepository<CursoEntity, Integer> {

    @Modifying
    @Transactional
    @Query(value = "update cursos set estacur=:esta where idcurso=:id", nativeQuery = true)
    public void CambiaEstado(@Param("esta") String esta, @Param("id") String id);

    @Modifying
    @Transactional
    @Query(value = "insert into cursos(codcur,nomcur,duracur,horacur,precrcur,estacur,fkiddocente)"
            + "values(:cod,:nom,:dura,:hora,:prec,:esta,:iddoc)", nativeQuery = true)
    public void Registrar(@Param("cod") String cod, @Param("nom") String nom,
             @Param("dura") String dura,
            @Param("hora") String hora, @Param("prec") BigDecimal prec,
            @Param("esta") String esta, @Param("iddoc") int iddoc);

    @Modifying
    @Transactional
    @Query(value = "update cursos set codcur=:cod,nomcur=:nom,duracur=:dura,horacur=:hora,precrcur=:prec,fkiddocente=:iddoc where idcurso=:idcur", nativeQuery = true)
    public void Editar(@Param("cod") String cod, @Param("nom") String nom,
             @Param("dura") String dura,
            @Param("hora") String hora, @Param("prec") BigDecimal prec
            , @Param("iddoc") int iddoc, @Param("idcur") int idcur);
    
    @Query(value = "select exists(select * from cursos where codcur=:cod)",nativeQuery = true)
    public int existecurso(@Param("cod") String cod);
    
    @Query(value = "select exists(select * from cursos where codcur=:cod and idcurso<>:id)", nativeQuery = true)
    int existecursoID(@Param("cod") String dni, @Param("id") int id);
}
