package com.venta.curso.Entity;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.time.LocalDate;
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
@Table(name = "certificados")
public class CertificadoEntity {

    @Id
    @Column(name = "idcertificado", nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int idcertificado;

    @Column(name = "fecenvcert", nullable = false)
    private LocalDate fecenvcert;

    @Column(name = "montoenvcert", precision = 9, scale = 2, nullable = false)
    private BigDecimal montoenvcert;

    @Column(name = "numenvcert", length = 100, nullable = true)
    private String numenvcert;

    @Column(name = "codenvcert", length = 100, nullable = true)
    private String codenvcert;

    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @JoinColumn(name = "fkidmatricula", nullable = false)
    private MatriculaEntity Matricula;
}
