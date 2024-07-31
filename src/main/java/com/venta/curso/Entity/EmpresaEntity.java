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
@Table(name = "empresas")
public class EmpresaEntity {

    @Id
    @Column(name = "idempresa", nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int idempresa;

    @Column(name = "rucemp", nullable = false, unique = true, length = 11)
    private String rucemp;

    @Column(name = "razsoemp", nullable = false, length = 200)
    private String razsoemp;

    @Column(name = "diremp", columnDefinition = "text", nullable = false)
    private String diremp;

    @Column(name = "celemp", length = 9, nullable = false)
    private String celemp;
    
    @Column(name = "correoemp", length = 100)
    private String correoemp;

    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @JoinColumn(name = "fkiddistrito", nullable = true)
    private DistritoEntity Distrito;
}
