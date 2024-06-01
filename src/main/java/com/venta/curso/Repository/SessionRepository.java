package com.venta.curso.Repository;

import com.venta.curso.Entity.SessionEntity;
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
public interface SessionRepository extends JpaRepository<SessionEntity, Integer> {

    @Modifying
    @Transactional
    @Query(value = "insert into sessiones(codses,fecinises,estadoses,fkidusuario)values(f_codsession(),curdate(),'ABIERTO',:usu)", nativeQuery = true)
    public void abrirsession(@Param("usu") String usu);

    @Modifying
    @Transactional
    @Query(value = "update sessiones set estadoses='CERRADO',fecfinses=curdate()  where idsession=:id", nativeQuery = true)
    public void cerrarsession(@Param("id") String idses);

    @Query(value = "select idsession from sessiones where fkidusuario=:usu and estadoses='ABIERTO' limit 1", nativeQuery = true)
    public int getidsession(@Param("usu") String usu);

    @Query(value = "select exists(select * from sessiones where fkidusuario=:usu and estadoses='ABIERTO')", nativeQuery = true)
    public int verificasessionabi(@Param("usu") String usu);

    @Query(value = "select exists(select * from sessiones where fkidusuario=:usu and fecinises=curdate())", nativeQuery = true)
    public int verificasession(@Param("usu") String usu);

    @Query(value = "select id, username, dniper, celper,concat(apeper,' ',nomper) usuario, correoper, dirper from users,personas where users.fkidpersona=personas.idpersona", nativeQuery = true)
    public List<Map<String, Object>> getUsuario();

    @Query(value = "select codses,fecinises,idsession,estadoses,if((estadoses='ABIERTO'),'Por cerrar',fecfinses) fechacierre from sessiones where fkidusuario=:usu order by idsession desc limit 1", nativeQuery = true)
    public Map<String, Object> getSesionultimausu(@Param("usu") String usu);
    
    @Modifying
    @Transactional
    @Query(value = "update sessiones set estadoses=:esta,fecfinses=curdate() where idsession=:id", nativeQuery = true)
    public void actualizarestado(@Param("id") String idses,@Param("esta") String esta);

}
