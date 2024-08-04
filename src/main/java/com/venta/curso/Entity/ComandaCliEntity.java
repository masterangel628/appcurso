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
@Table(name = "comandaclis")
public class ComandaCliEntity {

    @Id
    @Column(name = "idcomandacli")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int idcomandacli;

    @Column(name = "fkidsession", length = 20, nullable = false)
    private String fkidsession;

    @Column(name = "idper", length = 20, nullable = false)
    private String idper;

    @Column(name = "idcli", length = 20, nullable = false)
    private String idcli;

    @Column(name = "detpros", length = 80)
    private String detpros;
}
