package com.venta.curso.Service;

import com.venta.curso.Entity.BancoEntity;
import com.venta.curso.Interface.BancoInterface;
import com.venta.curso.Repository.BancoRepository;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

/**
 *
 * @author Asus
 */
@Service
@RequiredArgsConstructor
public class BancoService implements BancoInterface {

    private final BancoRepository bancorepo;

    @Override
    public List<BancoEntity> getBanco() {
        return bancorepo.findAll();
    }

    @Override
    public void saveBanco(BancoEntity Ban) {
        bancorepo.save(Ban);
    }

    @Override
    public int existeBanco(String idban) {
        return bancorepo.existebanco(idban);
    }

    @Override
    public int existeBancoedit(String nom, String idban) {
        return bancorepo.existebancoID(nom, Integer.parseInt(idban));
    }

    @Override
    public void Editar(String nom, String num, String id) {
        bancorepo.Editar(nom, num, id);
    }

    @Override
    public void CambiarEstado(String estado, String id) {
        bancorepo.CambiaEstado(estado, id);
    }

}
