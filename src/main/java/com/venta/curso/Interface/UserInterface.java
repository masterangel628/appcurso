package com.venta.curso.Interface;

import com.venta.curso.Entity.UserEntity;
import java.util.List;

/**
 *
 * @author Asus
 */
public interface UserInterface {

    public UserEntity getinfouser();

    public List<UserEntity> getUser();

    public void editUser(UserEntity user);

    public void CambiarEstado(String estado, String id);

    public int existeuser(String idper);

    public UserEntity saveUser(UserEntity user);

    public void saveRol(int idrol, Long iduser);

    public List getRoles();

    public int existeusername(String usu);
    
    public int existeusernamedit(String usu,int id);
    
    public void editusername(String usu,int id);
    
    public void guardarusuario(String usu,String pass,String esta,String idper);
}
