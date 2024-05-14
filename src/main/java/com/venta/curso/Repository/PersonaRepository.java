
package com.venta.curso.Repository;

import com.venta.curso.Entity.PersonaEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

/**
 *
 * @author Asus
 */
public interface PersonaRepository extends JpaRepository<PersonaEntity, Integer> {

    @Query(value = "select * from personas where dniper=:dni",nativeQuery = true)
    public PersonaEntity getidpersona(@Param("dni") String dni);
    
    @Query(value = "select exists(select * from personas where dniper=:dni)",nativeQuery = true)
    public int existepersona(@Param("dni") String dni);
    
    @Query(value = "select exists(select * from personas where dniper=:dni and idpersona<>:id)", nativeQuery = true)
    int existepersonaID(@Param("dni") String dni, @Param("id") int id);
}
