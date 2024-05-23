package com.venta.curso.Entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
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
@Table(name = "paquetes")
public class PaqueteEntity {

    @Id
    @Column(name = "idpaquete", nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int idpaquete;

    @Column(name = "nompaq", nullable = false, length = 100, unique = true)
    private String nompaq;

    @Column(name = "estadopaq")
    @Enumerated(EnumType.STRING)
    private EstadoEnum estado;

}
