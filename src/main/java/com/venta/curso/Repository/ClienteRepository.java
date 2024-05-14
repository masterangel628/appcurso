
package com.venta.curso.Repository;

import com.venta.curso.Entity.ClienteEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

/**
 *
 * @author Asus
 */
@Repository
public interface ClienteRepository extends JpaRepository<ClienteEntity, Integer>{

    
    @Query(value = "select exists(select * from clientes where fkidpersona=:idper)",nativeQuery = true)
    public int existedocente(@Param("idper") String idper);
}
