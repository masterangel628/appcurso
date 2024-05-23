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
@Table(name = "sessiones")
public class SessionEntity {

    @Id
    @Column(name = "idsession", nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int idsession;

    @Column(name = "codses", nullable = false, length = 40, unique = true)
    private String codses;

    @Column(name = "fecinises", nullable = false)
    private LocalDate fecinises;

    @Column(name = "fecfinses", nullable = true)
    private LocalDate fecfinses;

    @Column(name = "estadoses")
    @Enumerated(EnumType.STRING)
    private Estadosession estado;

    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @JoinColumn(name = "fkidusuario", nullable = false)
    private UserEntity Usuario;

}
