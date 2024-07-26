
package com.venta.curso.Repository;

import com.venta.curso.Entity.VaucherEntity;
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
public interface VaucherRepository extends JpaRepository<VaucherEntity, Integer>{
    @Modifying
    @Transactional
    @Query(value = "insert into vauchers(fkidmatricula, nomvau)values(:fkidmat,:nom)", nativeQuery = true)
    public void save(@Param("fkidmat") String fkidmat, @Param("nom") String nom);
    
    @Query(value = "select * from vauchers where fkidmatricula=:fkidmat", nativeQuery = true)
    public List<Map<String, Object>> getvaucher(@Param("fkidmat") String fkidmat);
    
}
