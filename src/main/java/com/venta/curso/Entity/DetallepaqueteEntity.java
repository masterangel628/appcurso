
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
@Table(name = "detallepaquetes")
public class DetallepaqueteEntity {
    @Id
    @Column(name = "iddetallepaquete", nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int iddetallepaquete;
    
    @Column(name = "precpaq", precision = 9, scale = 2, nullable = false)
    private BigDecimal precpaq;
    
    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @JoinColumn(name = "fkidcurso", nullable = false)
    private CursoEntity curso;
    
    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @JoinColumn(name = "fkidpaquete", nullable = false)
    private PaqueteEntity paquete;
    
    
}
