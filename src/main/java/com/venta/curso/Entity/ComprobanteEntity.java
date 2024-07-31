package com.venta.curso.Entity;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToOne;
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
@Table(name = "comprobantes")
public class ComprobanteEntity {

    @Id
    @Column(name = "idcomprobante", nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int idcomprobante;

    @Column(name = "seriecomp", nullable = false, columnDefinition = "INT(3) UNSIGNED ZEROFILL")
    private int seriecomp;

    @Column(name = "numcomp", nullable = false, columnDefinition = "INT(8) UNSIGNED ZEROFILL")
    private int numcomp;

    @Column(name = "desccomp", nullable = true, columnDefinition = "text")
    private String desccomp;

    @Column(name = "obscomp", nullable = true, columnDefinition = "text")
    private String obscomp;

    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @JoinColumn(name = "fkidmatricula", nullable = false)
    private ComprobanteEntity Comprobante;
    
    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @JoinColumn(name = "fkidtipocomprobante", nullable = false)
    private TipocomprobanteEntity Tipocomprobante;

}
