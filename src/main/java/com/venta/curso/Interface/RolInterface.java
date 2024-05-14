
package com.venta.curso.Interface;

import com.venta.curso.Entity.RoleEntity;
import java.util.List;

/**
 *
 * @author Asus
 */
public interface RolInterface {
     List<RoleEntity> getRoles();
    List getPermiso(String ro);
    List getPermisoRol(String ro);
    void AsignarPermiso(String rol, String per);
    void QuitarPermiso(String rol,String per);
}
