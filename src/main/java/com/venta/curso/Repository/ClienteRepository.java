
package com.venta.curso.Repository;

import com.venta.curso.Entity.ClienteEntity;
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
public interface ClienteRepository extends JpaRepository<ClienteEntity, Integer>{

    
    @Query(value = "select exists(select * from clientes where fkidpersona=:idper)",nativeQuery = true)
    public int existedocente(@Param("idper") String idper);
    
      @Modifying
    @Transactional
    @Query(value = "insert into clientes(fkidpersona)values(:idper)",nativeQuery = true)
    public void guardardcli(@Param("idper") String idper);
}
