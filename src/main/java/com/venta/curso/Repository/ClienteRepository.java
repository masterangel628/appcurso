package com.venta.curso.Repository;

import com.venta.curso.Entity.ClienteEntity;
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
public interface ClienteRepository extends JpaRepository<ClienteEntity, Integer> {

    @Query(value = "select exists(select * from clientes where fkidpersona=:idper)", nativeQuery = true)
    public int existedocente(@Param("idper") String idper);

    @Modifying
    @Transactional
    @Query(value = "insert into clientes(fkidpersona)values(:idper)", nativeQuery = true)
    public void guardardcli(@Param("idper") String idper);

    @Query(value = "select idcliente,concat(dniper,' - ',apeper,' ',nomper) cliente from clientes,personas where clientes.fkidpersona=personas.idpersona and (upper(concat(apeper,' ',nomper)) like concat('%',upper(:bus),'%') or dniper like concat('%',:bus,'%'))", nativeQuery = true)
    public List<Map<String, Object>> getclientebuscar(@Param("bus") String bus);
}
