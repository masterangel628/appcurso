
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
@Table(name = "departamentos")
public class DepartamentoEntity {
    @Id
    @Column(name = "iddepartamento", length = 10, nullable = false)
    private String iddepartamento;

    @Column(name = "nom_dep", nullable = false, length = 60, unique = true)
    private String nom_dep;
}
