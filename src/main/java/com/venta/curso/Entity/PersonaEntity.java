package com.venta.curso.Entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
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
@Table(name = "personas")
public class PersonaEntity {

    @Id
    @Column(name = "idpersona", nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int idpersona;

    @Column(name = "dniper", nullable = false, unique = true, length = 8)
    private String dniper;

    @Column(name = "nomper", nullable = false, length = 80)
    private String nomper;

    @Column(name = "apeper", nullable = false, length = 80)
    private String apeper;

    @Column(name = "dirper", columnDefinition = "text" ,nullable = false)
    private String dirper;

    @Column(name = "celper", length = 9,nullable = false)
    private String celper;
    
    @Column(name = "correoper", length = 100)
    private String correoper;
 
}
