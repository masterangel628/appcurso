package com.venta.curso.Service;

import com.venta.curso.Entity.UserEntity;
import com.venta.curso.Interface.UserInterface;
import com.venta.curso.Repository.UserRepository;
import java.util.List;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

/**
 *
 * @author Asus
 */
@Service
@RequiredArgsConstructor
public class UserService implements UserInterface {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

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
    public void deleteRol(Long iduser) {
        userRepository.deleteRol(iduser);
    }

    @Override
    public List<Map<String, Object>> getRoles() {
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

    @Override
    public UserEntity getUsuario(String username) {
        return userRepository.getUsuario(username);
    }

    @Override
    public int existemail(String email) {
        return userRepository.existemail(email);
    }

    @Override
    public String getUsername(String correo) {
        return userRepository.getUsername(correo);
    }

    @Override
    public String getNombre(String correo) {
        return userRepository.getNombre(correo);
    }

    @Override
    public String getidpersona() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String nom = auth.getName();
        return userRepository.getidpersona(nom);
    }

    @Override
    public UserEntity findByUsername(String username) {
        return userRepository.findByUsername(username);
    }

    @Override
    public void Cambiarpassword(String username, String password) {
        UserEntity user=userRepository.findByUsername(username);
        user.setPassword(passwordEncoder.encode(password)); 
        userRepository.save(user);
    }
}
