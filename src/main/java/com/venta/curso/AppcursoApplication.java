package com.venta.curso;

import com.venta.curso.Entity.CursoEntity;
import com.venta.curso.Entity.DocenteEntity;
import com.venta.curso.Entity.EstadoEnum;
import com.venta.curso.Entity.PermissionEntity;
import com.venta.curso.Entity.PersonaEntity;
import com.venta.curso.Entity.RoleEntity;
import com.venta.curso.Entity.UserEntity;
import com.venta.curso.Repository.CursoRepository;
import com.venta.curso.Repository.RolRepository;
import com.venta.curso.Repository.UserRepository;
import java.math.BigDecimal;
import java.util.List;
import java.util.Set;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class AppcursoApplication {

    @Bean
    CommandLineRunner init(CursoRepository cursoRepository, UserRepository userRepository,RolRepository rolrepository) {
        return args -> {

            PersonaEntity persona1 = PersonaEntity.builder()
                    .dniper("56453456")
                    .apeper("Rojas Calderon").nomper("Martin")
                    .dirper("Huaraz").celper("987876787")
                    .correoper("martin@gmail.com")
                    .build();
            PersonaEntity persona2 = PersonaEntity.builder()
                    .dniper("54567804")
                    .apeper("Castillo Miranda").nomper("Adilson")
                    .dirper("Huaraz").celper("934343098")
                    .correoper("adilson@gmail.com")
                    .build();

            DocenteEntity docente1 = DocenteEntity.builder()
                    .estado(EstadoEnum.ACTIVO)
                    .Persona(persona1).build();
            DocenteEntity docente2 = DocenteEntity.builder()
                    .estado(EstadoEnum.ACTIVO)
                    .Persona(persona2).build();

            CursoEntity curso1 = CursoEntity.builder().codcur("cod001").nomcur("SIAF-SP")
                    .duracur("5 semanas").horacur("140 Hrs").
                    precrcur(new BigDecimal("270.00")).estado(EstadoEnum.ACTIVO).
                    Docente(docente1).build();

            CursoEntity curso2 = CursoEntity.builder().codcur("cod002").nomcur("Gestión de RR.HH.")
                    .duracur("10 semanas").horacur("280 Hrs").
                    precrcur(new BigDecimal("500.00")).estado(EstadoEnum.ACTIVO).
                    Docente(docente2).build();

            cursoRepository.saveAll(List.of(curso1, curso2));

            PersonaEntity persona3 = PersonaEntity.builder()
                    .dniper("75707130")
                    .apeper("Toledo Cordova").nomper("Miguel")
                    .dirper("Prolongación Luzuriaga Ultima cuadra rio seco").celper("920817611")
                    .correoper("grone_mas_a@hotmail.com")
                    .build();

            //Docente
            PermissionEntity docregistrar = PermissionEntity.builder().name("Registrar Docente").build();
            PermissionEntity doceditar = PermissionEntity.builder().name("Editar Docente").build();
            PermissionEntity docver = PermissionEntity.builder().name("Ver Docente").build();
            PermissionEntity doccambiar = PermissionEntity.builder().name("Cambiar estado Docente").build();

            //Curso
            PermissionEntity curregistrar = PermissionEntity.builder().name("Registrar Curso").build();
            PermissionEntity cureditar = PermissionEntity.builder().name("Editar Curso").build();
            PermissionEntity curver = PermissionEntity.builder().name("Ver Curso").build();
            PermissionEntity curcambiar = PermissionEntity.builder().name("Cambiar estado Curso").build();

            //Cliente
            PermissionEntity cliregistrar = PermissionEntity.builder().name("Registrar Cliente").build();
            PermissionEntity clieditar = PermissionEntity.builder().name("Editar Cliente").build();
            PermissionEntity cliver = PermissionEntity.builder().name("Ver Cliente").build();

            //Banco
            PermissionEntity banregistrar = PermissionEntity.builder().name("Registrar Banco").build();
            PermissionEntity baneditar = PermissionEntity.builder().name("Editar Banco").build();
            PermissionEntity banver = PermissionEntity.builder().name("Ver Banco").build();
            PermissionEntity bancambiar = PermissionEntity.builder().name("Cambiar estado Banco").build();
            
            //Usuario
            PermissionEntity usuregistrar = PermissionEntity.builder().name("Registrar Usuario").build();
            PermissionEntity usueditar = PermissionEntity.builder().name("Editar Usuario").build();
            PermissionEntity usuver = PermissionEntity.builder().name("Ver Usuario").build();
            PermissionEntity usucambiar = PermissionEntity.builder().name("Cambiar estado Usuario").build();
            
            //Rol
            PermissionEntity rolges = PermissionEntity.builder().name("Gestión de Roles").build();
            
            //Prospecto
            PermissionEntity proregistrar = PermissionEntity.builder().name("Registrar Prospecto").build();
            PermissionEntity prover = PermissionEntity.builder().name("Ver Prospecto").build();
            

            RoleEntity roleAdmin = RoleEntity.builder()
                    .role("Administrador")
                    .permissionList(Set.of(docregistrar, doceditar, docver, doccambiar,
                             curregistrar, cureditar, curver, curcambiar, cliregistrar, clieditar, cliver,
                             banregistrar, baneditar, banver, bancambiar,
                             usuregistrar, usueditar, usuver, usucambiar,
                    rolges,
                    proregistrar,prover))
                    .build();

            RoleEntity roleAsesor = RoleEntity.builder()
                    .role("Asesor")
                    .build();

            RoleEntity roleContador = RoleEntity.builder()
                    .role("Contador")
                    .build();
            
            rolrepository.saveAll(List.of(roleAsesor,roleContador));

            UserEntity user1 = UserEntity.builder()
                    .username("angel97")
                    .password("$2a$10$cMY29RPYoIHMJSuwRfoD3eQxU1J5Rww4VnNOUOAEPqCBshkNfrEf6")
                    .roles(Set.of(roleAdmin))
                    .estado(EstadoEnum.ACTIVO)
                    .Persona(persona3)
                    .build();

            userRepository.saveAll(List.of(user1));

        };
    }

    public static void main(String[] args) {
        SpringApplication.run(AppcursoApplication.class, args);
    }

}
