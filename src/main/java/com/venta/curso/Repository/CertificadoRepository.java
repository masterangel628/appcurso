package com.venta.curso.Repository;

import com.venta.curso.Entity.CertificadoEntity;
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
public interface CertificadoRepository extends JpaRepository<CertificadoEntity, Integer> {

    @Query(value = "select fecmat, idmatricula, montomat, grupomat, nummat, estatipomat, idcliente,idpersona, dniper, celper, apeper, nomper, correoper, dirper,(if((select count(*) from certificados where fkidmatricula=idmatricula)=1,'existe','noexiste')) verexiste from matriculas,clientes,personas where matriculas.fkidcliente=clientes.idcliente and clientes.fkidpersona=personas.idpersona and estadomat='MATRICULA'", nativeQuery = true)
    public List<Map<String, Object>> getMatricula();

    @Modifying
    @Transactional
    @Query(value = "insert into certificados(fecenvcert, fkidmatricula, montoenvcert, codenvcert, numenvcert)values(:fec,:mat,:mon,:cod,:num)", nativeQuery = true)
    public void guardarenvio(@Param("fec") String fec, @Param("mat") String mat, @Param("mon") String mon, @Param("cod") String cod, @Param("num") String num);

    @Query(value = "select * from certificados where fkidmatricula=:id",nativeQuery = true)
    public Map<String, Object> getCertificadoMat(@Param("id") String idmat);
}
