package com.venta.curso.Repository;

import com.venta.curso.Entity.MatriculaEntity;
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
public interface MatriculaRepository extends JpaRepository<MatriculaEntity, Integer> {

    @Modifying
    @Transactional
    @Query(value = "insert into matriculas(vaumat,fecmat,fkidcliente,fkidusuario,fkidbanco)values(:vau,:fec,:cli,:usu,:ban)", nativeQuery = true)
    public void guardarmatricula(@Param("vau") String vau, @Param("fec") String fec, @Param("cli") String cli, @Param("usu") String usu, @Param("ban") String ban);

    @Query(value = "select * from matriculas,bancos,clientes,personas where matriculas.fkidbanco=bancos.idbanco and matriculas.fkidcliente=clientes.idcliente and clientes.fkidpersona=personas.idpersona", nativeQuery = true)
    public List<Map<String, Object>> getMatricula();

    @Query(value = "select curdate()", nativeQuery = true)
    public String getfecactual();

    @Modifying
    @Transactional
    @Query(value = "insert into detallematriculas(fkidmatricula,fkidpaquete)values(:mat,:paq)", nativeQuery = true)
    public void guardardetmat(@Param("mat") String mat, @Param("paq") String paq);

    @Query(value = "select * from paquetes where estadopaq='ACTIVO'", nativeQuery = true)
    public List<Map<String, Object>> getpaqueteactivo();

    @Query(value = "select * from detallepaquetes,cursos where detallepaquetes.fkidcurso=cursos.idcurso and fkidpaquete=:idpaq", nativeQuery = true)
    public List<Map<String, Object>> getdetpaquete(@Param("idpaq") String idpaq);

    @Query(value = "select * from bancos where estadoban='ACTIVO'", nativeQuery = true)
    public List<Map<String, Object>> getbanco();
}
