package com.venta.curso.Service;

import com.venta.curso.Entity.UserEntity;
import com.venta.curso.Interface.UserInterface;
import com.venta.curso.Repository.UserRepository;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

/**
 *
 * @author Asus
 */
@Service
@RequiredArgsConstructor
public class UserService implements UserInterface {

    private final UserRepository userRepository;

    @Override
    public UserEntity getinfouser() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String nom = auth.getName();
        UserEntity usu = userRepository.getinfouser(nom);
        return usu;
    }

    @Override
    public List<UserEntity> getUser() {
        return userRepository.findAll();
    }

    @Override
    public UserEntity saveUser(UserEntity user) {
        return userRepository.save(user);
    }

    @Override
    public void editUser(UserEntity user) {
        userRepository.save(user);
    }

    @Override
    public void CambiarEstado(String estado, String id) {
        userRepository.CambiaEstado(estado, id);
    }

    @Override
    public int existeuser(String idper) {
        return userRepository.existeuser(idper);
    }

    @Override
    public void saveRol(int idrol, Long iduser) {
       userRepository.saveRol(idrol, iduser);
    }

    @Override
    public List getRoles() {
        return userRepository.getRoles();
    }

    @Override
    public int existeusername(String usu) {
        return userRepository.existeusername(usu);
    }

    @Override
    public int existeusernamedit(String usu, int id) {
        return userRepository.existeusernamedit(usu, id);
    }

    @Override
    public void editusername(String usu, int id) {
        userRepository.editusername(usu, id); 
    }

    @Override
    public void guardarusuario(String usu, String pass, String esta, String idper) {
        userRepository.guardarusu(usu, pass, esta, idper);
        
    }
}
