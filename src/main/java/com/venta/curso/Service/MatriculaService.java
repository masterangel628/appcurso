/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.venta.curso.Service;

import com.venta.curso.Interface.MatriculaInterface;
import com.venta.curso.Repository.MatriculaRepository;
import java.util.List;
import java.util.Map;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

/**
 *
 * @author Asus
 */
@Service
@RequiredArgsConstructor
public class MatriculaService implements MatriculaInterface{

    private final MatriculaRepository matricularepo;
    @Override
    public List<Map<String, Object>> getMatricula() {
        return matricularepo.getMatricula();
    }

    @Override
    public void guardarmatricula(String vau, String fec, String cli, String usu, String ban) {
        matricularepo.guardarmatricula(vau, fec, cli, usu, ban); 
    }

    @Override
    public String fecactual() {
        return matricularepo.getfecactual();
    }

    @Override
    public void guardardetmat(String mat, String paq) {
        matricularepo.guardardetmat(mat, paq); 
    }

    @Override
    public List<Map<String, Object>> getPaqueteActivo() {
       return  matricularepo.getpaqueteactivo();
    }

    @Override
    public List<Map<String, Object>> getdetpaquete(String idpaq) {
         return  matricularepo.getdetpaquete(idpaq);
    }

    @Override
    public List<Map<String, Object>> getbanco() {
        return  matricularepo.getbanco();
    }

    
    
}
