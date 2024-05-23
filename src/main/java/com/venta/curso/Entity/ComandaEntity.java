package com.venta.curso.Entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
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
@Table(name = "comandas")
public class ComandaEntity {

    @Id
    @Column(name = "idcomanda")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int idcomanda;

    @Column(name = "fkidusuario", length = 20, nullable = false)
    private String fkidusuario;

    @Column(name = "curpaq", length = 80, nullable = false)
    private String curpaq;
    
    @Column(name = "tipocurpaq", length = 80, nullable = false)
    private String tipocurpaq;
}
