package com.venta.curso.Entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 *
 * @author Asus
 */
@Setter
@Getter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "tipocomprobantes")
public class TipocomprobanteEntity {

    @Id
    @Column(name = "idtipocomprobante", nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int idtipocomprobante;

    @Column(name = "codtipcom", nullable = false, length = 10)
    private String codtipcom;

    @Column(name = "nomtipcom", nullable = false, length = 120)
    private String nomtipcom;

    @Column(name = "serietu", nullable = false)
    private String serietu;

    @Column(name = "numtu", nullable = false, columnDefinition = "INT(8) UNSIGNED ZEROFILL")
    private int numtu;
}
