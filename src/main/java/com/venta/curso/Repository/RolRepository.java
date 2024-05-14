/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.venta.curso.Repository;


import com.venta.curso.Entity.RoleEntity;
import java.util.List;
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
public interface RolRepository extends JpaRepository<RoleEntity, Long> {

    @Query(value = "select * from permissions where id not in (select permission_id from role_permissions where role_id=:ro)", nativeQuery = true)
    List getPermiso(@Param("ro") String ro);

    @Query(value = "select role_id, permission_id, name from role_permissions inner join permissions on role_permissions.permission_id=permissions.id and role_id=:ro", nativeQuery = true)
    List getPermisoRol(@Param("ro") String ro);

    @Modifying
    @Transactional
    @Query(value = "insert into role_permissions(role_id,permission_id) values(:rol,:per)", nativeQuery = true)
    void AsignarPermiso(@Param("rol") String rol, @Param("per") String per);

    @Modifying
    @Transactional
    @Query(value = "delete from role_permissions where role_id=:rol and permission_id=:per", nativeQuery = true)
    void QuitarPermiso(@Param("rol") String rol, @Param("per") String per);

}
