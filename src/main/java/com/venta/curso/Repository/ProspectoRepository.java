package com.venta.curso.Repository;

import com.venta.curso.Entity.ProspectoEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

/**
 *
 * @author Asus
 */
@Repository
public interface ProspectoRepository extends JpaRepository<ProspectoEntity, Integer> {

    @Query(value = "select exists(select * from prospectos where celpros=:num)" ,nativeQuery = true)
    public int existenum(@Param("num") String num);

    @Query(value = "select curdate()", nativeQuery = true)
    public String fecactual();

}
