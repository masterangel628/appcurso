package com.venta.curso.Repository;

import com.venta.curso.Entity.EmpresaEntity;
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
public interface EmpresaRepository extends JpaRepository<EmpresaEntity, Integer> {

    @Query(value = "select exists(select * from empresas where rucemp=:ruc)", nativeQuery = true)
    public int existeEmpresa(@Param("ruc") String ruc);

    @Query(value = "select exists(select * from empresas where rucemp=:ruc and idempresa<>:id)", nativeQuery = true)
    public int existEmpresaID(@Param("ruc") String ruc, @Param("id") String id);

    @Query(value = "select * from empresas where rucemp=:ruc", nativeQuery = true)
    public EmpresaEntity getidempresa(@Param("ruc") String ruc);

    @Query(value = "select exists(select * from empresas where correoemp=:cor limit 1)", nativeQuery = true)
    public int existecorreo(@Param("cor") String cor);

    @Query(value = "select exists(select * from empresas where correoemp=:cor and idempresa<>:id)", nativeQuery = true)
    public int existecorreoedit(@Param("cor") String cor, @Param("id") int id);

    @Query(value = "select * from empresas where correoemp=:correo", nativeQuery = true)
    public EmpresaEntity getempresacor(@Param("correo") String correo);

    @Modifying
    @Transactional
    @Query(value = "insert into empresas(rucemp, celemp, fkiddistrito, razsoemp, diremp, correoemp)values(:ruc,:cel,:dist,:raz,:dir,:cor)", nativeQuery = true)
    public void guardarempresa(@Param("ruc") String ruc, @Param("raz") String raz, @Param("dir") String dir, @Param("cel") String cel, @Param("cor") String cor, @Param("dist") String dist);

    @Modifying
    @Transactional
    @Query(value = "update empresas set rucemp=:ruc, celemp=:cel, fkiddistrito=:dist, razsoemp=:raz, correoemp=:cor, diremp=:dir where idempresa=:id", nativeQuery = true)
    public void editarempresa(@Param("ruc") String ruc, @Param("raz") String raz, @Param("dir") String dir, @Param("cel") String cel, @Param("cor") String cor, @Param("dist") String dist, @Param("id") String id);
}
