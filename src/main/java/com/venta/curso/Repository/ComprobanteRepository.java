package com.venta.curso.Repository;

import com.venta.curso.Entity.ComprobanteEntity;
import java.util.List;
import java.util.Map;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

/**
 *
 * @author Asus
 */
@Repository
public interface ComprobanteRepository extends JpaRepository<ComprobanteEntity, Integer> {

    @Query(value = "select nomtipcom,numero,nombre,mcigv_ven,fecmat,horamat,desccomp,idcomprobante from v_venta", nativeQuery = true)
    public List<Map<String, Object>> getComprobante();

    @Query(value = "select codtipcom,serie,num from v_venta where idcomprobante=:idcom", nativeQuery = true)
    public List<Map<String, Object>> getInfoComprobante(String idcom);

}
