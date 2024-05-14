package com.venta.curso.Interface;

import com.venta.curso.Entity.CursoEntity;
import java.math.BigDecimal;
import java.util.List;

/**
 *
 * @author Asus
 */
public interface CursoInterface {

    public List<CursoEntity> getCurso();

    public void saveCurso(String cod, String nom, String dura, String hora, BigDecimal prec, String esta, int iddoc);

    public void editCurso(String cod, String nom, String dura, String hora, BigDecimal prec, int iddoc, int idcur);

    public void CambiarEstado(String estado, String id);
    
    public int existecurso(String cod);
    
     public int existecursoedit(String cod,int idcur);
}
