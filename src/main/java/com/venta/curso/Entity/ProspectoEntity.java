
package com.venta.curso.Entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
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
@Table(name = "prospectos")
public class ProspectoEntity {
    @Id
    @Column(name = "idprospecto")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int idprospecto;

    @Column(name = "nompros", length = 100, nullable = false)
    private String nompros;

    @Column(name = "celpros", length = 20, nullable = false)
    private String celpros;

    @Column(name = "fechorpros", nullable = false)
    private LocalDate fechorpros;

    @Column(name = "estatimpros", nullable = false)
    @Enumerated(EnumType.STRING)
    private EstadoTimEnum estatimpros;
    
    @Column(name = "estaaspros", nullable = false)
    @Enumerated(EnumType.STRING)
    private EstadoAsEnum estaaspros;
}
