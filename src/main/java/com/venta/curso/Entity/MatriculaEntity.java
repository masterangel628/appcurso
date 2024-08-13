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
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import java.math.BigDecimal;
import java.sql.Time;
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
@Table(name = "matriculas")
public class MatriculaEntity {

    @Id
    @Column(name = "idmatricula", nullable = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int idmatricula;

    @Column(name = "nummat", nullable = false, length = 100, unique = true)
    private String nummat;

    @Column(name = "estadomat")
    @Enumerated(EnumType.STRING)
    private Estadomatricula estadomat;

    @Column(name = "fecmat", nullable = false)
    private LocalDate fecmat;

    @Column(name = "horamat", nullable = false, columnDefinition = "time")
    private Time horamat;

    @Column(name = "descmat", nullable = true, columnDefinition = "text")
    private String descmat;

    @Column(name = "usernamemat", nullable = false, length = 20)
    private String usernamemat;

    @Column(name = "passwordmat", nullable = false, length = 100)
    private String passwordmat;

    @Column(name = "montomat", precision = 9, scale = 2, nullable = false)
    private BigDecimal montomat;

    @Column(name = "descumat", precision = 9, scale = 2, nullable = true)
    private BigDecimal descumat;

    @Column(name = "grupomat", nullable = false, length = 100)
    private String grupomat;
    
    @Column(name = "bandesc", nullable = false, length = 100)
    private String bandesc;

    @Column(name = "estatipomat")
    @Enumerated(EnumType.STRING)
    private Estadotipo estatipomat;

    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @JoinColumn(name = "fkidcliente", nullable = false)
    private ClienteEntity Cliente;

    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @JoinColumn(name = "fkidsession", nullable = false)
    private SessionEntity Session;

    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @JoinColumn(name = "fkidbanco", nullable = true)
    private BancoEntity Banco;

    @Column(name = "estamat")
    @Enumerated(EnumType.STRING)
    private EstadoEnum estamat;

    @ManyToOne(cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    @JoinColumn(name = "fkidalumno", nullable = false)
    private AlumnoEntity Alumno;
}
