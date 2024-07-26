package com.venta.curso.Interface;

import com.venta.curso.Entity.UserEntity;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Asus
 */
public interface UserInterface {

    public int existemail(String email);

    public UserEntity getinfouser();

    public List<UserEntity> getUser();

    public void editUser(UserEntity user);

    public void CambiarEstado(String estado, String id);

    public int existeuser(String idper);

    public void saveRol(int idrol, Long iduser);

    public void deleteRol(Long iduser);

    public List<Map<String, Object>> getRoles();

    public int existeusername(String usu);

    public int existeusernamedit(String usu, int id);

    public void editusername(String usu, int id);

    public void guardarusuario(String usu, String pass, String esta, String idper);

    public UserEntity getUsuario(String username);
    
    public String getUsername(String correo);
    
    public String getNombre(String correo);
    
    public String getidpersona();
    
    public UserEntity findByUsername(String username);
    
    public String getNombreusu(String fkidusu);
    
    public void Cambiarpassword(String username,String password);
}
