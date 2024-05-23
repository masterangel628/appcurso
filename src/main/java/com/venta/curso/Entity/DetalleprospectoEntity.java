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
@Table(name = "detalleprospectos")
public class DetalleprospectoEntity {

    @Id
    @Column(name = "iddetalleprospecto", nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int idmatricula;
    
     @Column(name = "estaverdetpros")
    @Enumerated(EnumType.STRING)
    private EstadoVerificar estadover;
     
    @Column(name = "fecdetpros", nullable = false)
    private LocalDate fecdetpros;
    
    
    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @JoinColumn(name = "fkidprospecto", nullable = false)
    private ProspectoEntity Prospecto;

    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @JoinColumn(name = "fkidusuario", nullable = false)
    private UserEntity Usuario;

}
