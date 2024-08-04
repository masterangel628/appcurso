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

    @Query(value = "select * from v_cliente", nativeQuery = true)
    public List<Map<String, Object>> getCliente();

    @Query(value = "select exists(select * from clientes where fkidpersona=:idper)", nativeQuery = true)
    public int existeclientedni(@Param("idper") String idper);

    @Query(value = "select exists(select * from clientes where fkidempresa=:idemp)", nativeQuery = true)
    public int existeclienteruc(@Param("idemp") String idemp);

    @Modifying
    @Transactional
    @Query(value = "insert into clientes(fkidpersona,tipocli)values(:idper,'DNI')", nativeQuery = true)
    public void guardardclidni(@Param("idper") String idper);

    @Modifying
    @Transactional
    @Query(value = "insert into clientes(fkidempresa,tipocli)values(:idemp,'RUC')", nativeQuery = true)
    public void guardardcliruc(@Param("idemp") String idemp);

    @Query(value = "select idcliente, tipocli,documento,idpem, concat(documento,' - ',nombre) cliente from v_cliente where tipocli=:tipo and (upper(nombre) like concat('%',upper(:bus),'%') or documento like concat('%',:bus,'%')) limit 5", nativeQuery = true)
    public List<Map<String, Object>> getclientebuscar(@Param("tipo") String tipo, @Param("bus") String bus);
}
