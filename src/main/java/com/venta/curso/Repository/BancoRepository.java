package com.venta.curso.Repository;

import com.venta.curso.Entity.BancoEntity;
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
public interface BancoRepository extends JpaRepository<BancoEntity, Integer> {

    @Modifying
    @Transactional
    @Query(value = "update bancos set estadoban=:esta where idbanco=:id", nativeQuery = true)
    public void CambiaEstado(@Param("esta") String esta, @Param("id") String id);

    @Query(value = "select exists(select * from bancos where nomban=:nom)", nativeQuery = true)
    public int existebanco(@Param("nom") String nom);

    @Query(value = "select exists(select * from bancos where nomban=:nom and idbanco<>:id)", nativeQuery = true)
    int existebancoID(@Param("nom") String nom, @Param("id") int id);
    
    @Modifying
    @Transactional
    @Query(value = "update bancos set nomban=:nom,nmroban=:num where idbanco=:id", nativeQuery = true)
    public void Editar(@Param("nom") String nom,@Param("num") String num, @Param("id") String id);
}
