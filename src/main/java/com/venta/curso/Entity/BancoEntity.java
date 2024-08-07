
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
@Table(name = "bancos")
public class BancoEntity {

    @Id
    @Column(name = "idbanco", nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int idbanco;

    @Column(name = "nomban", nullable = false, length = 80)
    private String nomban;

    @Column(name = "nmroban", nullable = false, length = 80)
    private String nmroban;

    @Column(name = "estadoban")
    @Enumerated(EnumType.STRING)
    private EstadoEnum estado;

}
