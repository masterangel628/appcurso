package com.venta.curso.Entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.math.BigDecimal;
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
@Table(name = "comandas")
public class ComandaEntity {

    @Id
    @Column(name = "idcomanda")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int idcomanda;

    @Column(name = "fkidsession", length = 20, nullable = false)
    private String fkidsession;

    @Column(name = "cur", length = 80)
    private String cur;

    @Column(name = "paq", length = 80)
    private String paq;

    @Column(name = "detpros", length = 80)
    private String detpros;

    @Column(name = "tipocurpaq", length = 80, nullable = false)
    private String tipocurpaq;

    @Column(name = "montocom", precision = 9, scale = 2, nullable = false)
    private BigDecimal montocom;
}
