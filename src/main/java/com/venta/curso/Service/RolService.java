/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.venta.curso.Service;

import com.venta.curso.Entity.RoleEntity;
import com.venta.curso.Interface.RolInterface;
import com.venta.curso.Repository.RolRepository;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

/**
 *
 * @author Asus
 */
@Service
@RequiredArgsConstructor
public class RolService implements RolInterface {

    private final RolRepository rolRepository;

   

    @Override
    public void AsignarPermiso(String idrol, String idper) {
        rolRepository.AsignarPermiso(idrol, idper); 
    }

    @Override
    public void QuitarPermiso(String idrol, String idper) {
         rolRepository.QuitarPermiso(idrol, idper); 
    }

    @Override
    public List getPermisoRol(String rol) {
         return rolRepository.getPermisoRol(rol);
    }

    @Override
    public List getPermiso(String ro) {
        return rolRepository.getPermiso(ro);
    }

    @Override
    public List<RoleEntity> getRoles() {
        return rolRepository.findAll();
    }

}
