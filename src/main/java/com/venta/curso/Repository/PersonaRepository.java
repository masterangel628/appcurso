package com.venta.curso.Repository;

import com.venta.curso.Entity.PersonaEntity;
import java.util.List;
import java.util.Map;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author Asus
 */
public interface PersonaRepository extends JpaRepository<PersonaEntity, Integer> {

    @Query(value = "select * from personas where dniper=:dni", nativeQuery = true)
    public PersonaEntity getidpersona(@Param("dni") String dni);

    @Query(value = "select exists(select * from personas where dniper=:dni)", nativeQuery = true)
    public int existepersona(@Param("dni") String dni);

    @Query(value = "select exists(select * from personas where dniper=:dni and idpersona<>:id)", nativeQuery = true)
    int existepersonaID(@Param("dni") String dni, @Param("id") int id);

    @Query(value = "select * from departamentos", nativeQuery = true)
    public List<Map<String, Object>> getDepartamento();

    @Query(value = "select * from provincias where fk_iddepartamento=:cod", nativeQuery = true)
    public List<Map<String, Object>> getProvincia(@Param("cod") String coddep);

    @Query(value = "select * from distritos where fk_ididprovincia=:cod", nativeQuery = true)
    public List<Map<String, Object>> getDistrito(@Param("cod") String coddis);

    @Modifying
    @Transactional
    @Query(value = "insert into personas(dniper, celper, fkiddistrito, apeper, nomper, correoper, dirper)values(:dni,:cel,:dist,:ape,:nom,:cor,:dir)", nativeQuery = true)
    public void guardarpersona(@Param("dni") String dni, @Param("nom") String nom, @Param("ape") String ape, @Param("dir") String dir, @Param("cel") String cel, @Param("cor") String cor, @Param("dist") String dist);

    @Modifying
    @Transactional
    @Query(value = "update personas set dniper=:dni, celper=:cel, fkiddistrito=:dist, apeper=:ape, nomper=:nom, correoper=:cor, dirper=:dir where idpersona=:id", nativeQuery = true)
    public void editarpersona(@Param("dni") String dni, @Param("nom") String nom, @Param("ape") String ape, @Param("dir") String dir, @Param("cel") String cel, @Param("cor") String cor, @Param("dist") String dist,@Param("id") String id);

}
