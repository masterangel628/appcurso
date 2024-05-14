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
@Table(name = "cursos")
public class CursoEntity {

    @Id
    @Column(name = "idcurso")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int idcurso;

    @Column(name = "codcur", length = 20, unique = true, nullable = false)
    private String codcur;

    @Column(name = "nomcur", length = 100, nullable = false)
    private String nomcur;

    @Column(name = "duracur", length = 100, nullable = true)
    private String duracur;

    @Column(name = "horacur", length = 100, nullable = true)
    private String horacur;

    @Column(name = "precrcur", precision = 9, scale = 2, nullable = false)
    private BigDecimal precrcur;

    @Column(name = "estacur", nullable = false)
    @Enumerated(EnumType.STRING)
    private EstadoEnum estado;

    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @JoinColumn(name = "fkiddocente", nullable = false)
    private DocenteEntity Docente;

    
}
