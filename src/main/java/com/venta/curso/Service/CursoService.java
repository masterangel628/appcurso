package com.venta.curso.Service;

import com.venta.curso.Entity.CursoEntity;
import com.venta.curso.Interface.CursoInterface;
import com.venta.curso.Repository.CursoRepository;
import java.math.BigDecimal;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

/**
 *
 * @author Asus
 */
@Service
@RequiredArgsConstructor
public class CursoService implements CursoInterface {

    private final CursoRepository cursorepo;

    @Override
    public List<CursoEntity> getCurso() {
        return cursorepo.findAll();
    }

    @Override
    public void saveCurso(
            String cod, String nom,
            String dura,
            String hora, BigDecimal prec,
            String esta, int iddoc) {
        cursorepo.Registrar(cod, nom,
                dura, hora, prec, esta, iddoc);
    }

    @Override
    public void CambiarEstado(String esta, String id) {
        cursorepo.CambiaEstado(esta, id);
    }

    @Override
    public void editCurso(String cod, String nom, String dura, String hora, BigDecimal prec, int iddoc, int idcur) {
        cursorepo.Editar(cod, nom, dura, hora, prec, iddoc, idcur);
    }

    @Override
    public int existecurso(String cod) {
        return cursorepo.existecurso(cod);
    }

    @Override
    public int existecursoedit(String cod, int idcur) {
        return cursorepo.existecursoID(cod, idcur);
    }

}
