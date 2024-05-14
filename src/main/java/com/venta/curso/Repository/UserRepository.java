package com.venta.curso.Repository;

import com.venta.curso.Entity.RoleEntity;
import com.venta.curso.Entity.UserEntity;
import java.util.List;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author Asus
 */
@Repository
public interface UserRepository extends JpaRepository<UserEntity, Long> {

    Optional<UserEntity> findUserEntityByUsername(String username);

    @Query(value = "select * from users where username=:user", nativeQuery = true)
    UserEntity getinfouser(@Param("user") String user);

    @Modifying
    @Transactional
    @Query(value = "update users set estado=:esta where id=:id", nativeQuery = true)
    public void CambiaEstado(@Param("esta") String esta, @Param("id") String id);

    @Query(value = "select exists(select * from users where fkidpersona=:idper)", nativeQuery = true)
    public int existeuser(@Param("idper") String idper);

    @Modifying
    @Transactional
    @Query(value = "insert into user_roles(user_id,role_id)values(:iduser,:idrol)", nativeQuery = true)
    public int saveRol(@Param("idrol") int idrol, @Param("iduser") Long iduser);

    @Query(value = "select * from roles", nativeQuery = true)
    List getRoles();
    
     @Query(value = "select exists(select * from users where username=:usu)", nativeQuery = true)
    public int existeusername(@Param("usu") String usu);
    
    @Query(value = "select exists(select * from users where username=:usu and id<>:id)", nativeQuery = true)
    public int existeusernamedit(@Param("usu") String usu,@Param("id") int id);
    
    @Modifying
    @Transactional
    @Query(value = "update users set username=:usu where id=:id", nativeQuery = true)
    public void editusername(@Param("usu") String usu, @Param("id") int id);


}
