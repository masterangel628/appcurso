
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
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.*;

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
@Table(name = "docentes")
public class DocenteEntity {
    @Id
    @Column(name = "iddocente", nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int iddocente;
    
    @Column(name = "estadodoc")
    @Enumerated(EnumType.STRING)
    private EstadoEnum estado;
    
    @OneToOne(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @JoinColumn(name = "fkidpersona", nullable = false)
    private PersonaEntity Persona;

   
    
    
}
