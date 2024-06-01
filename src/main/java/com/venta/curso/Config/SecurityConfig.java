package com.venta.curso.Config;

import com.venta.curso.Service.CustomUserDetailsService;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

/**
 *
 * @author Asus
 */
@Configuration
@EnableWebSecurity
@EnableMethodSecurity
public class SecurityConfig {

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity httpSecurity) throws Exception {
        return httpSecurity
                .csrf(csrf -> csrf.disable())
                .authorizeHttpRequests(http -> {
                    http.requestMatchers("/pagina/**").permitAll();
                    http.requestMatchers("/public/**").permitAll();

                    http.requestMatchers("/forgot-password").permitAll();
                    http.requestMatchers("/forgot-password/send-token").permitAll();
                    http.requestMatchers("/reset-password").permitAll();
                    http.requestMatchers("/reset-password/change-password").permitAll();

                    http.requestMatchers("/banco").hasAuthority("Ver Banco");
                    http.requestMatchers("/banco/mbanco").hasAuthority("Ver Banco");
                    http.requestMatchers("/banco/guardar").hasAuthority("Registrar Banco");
                    http.requestMatchers("/banco/editar").hasAuthority("Editar Banco");
                    http.requestMatchers("/banco/cambiarestado").hasAuthority("Cambiar estado Banco");

                    http.requestMatchers("/cliente").hasAuthority("Ver Cliente");
                    http.requestMatchers("/cliente/mcliente").hasAuthority("Ver Cliente");
                    http.requestMatchers("/cliente/guardar").hasAuthority("Registrar Cliente");
                    http.requestMatchers("/cliente/editar").hasAuthority("Editar Cliente");

                    http.requestMatchers("/curso").hasAuthority("Ver Curso");
                    http.requestMatchers("/curso/mdocente").hasAuthority("Ver Curso");
                    http.requestMatchers("/curso/mcurso").hasAuthority("Ver Curso");
                    http.requestMatchers("/curso/guardar").hasAuthority("Registrar Curso");
                    http.requestMatchers("/curso/editar").hasAuthority("Editar Curso");
                    http.requestMatchers("/curso/cambiarestado").hasAuthority("Cambiar estado Curso");

                    http.requestMatchers("/docente").hasAuthority("Ver Docente");
                    http.requestMatchers("/docente/mdocente").hasAuthority("Ver Docente");
                    http.requestMatchers("/docente/guardar").hasAuthority("Registrar Docente");
                    http.requestMatchers("/docente/editar").hasAuthority("Editar Docente");
                    http.requestMatchers("/docente/cambiarestado").hasAuthority("Cambiar estado Docente");

                    http.requestMatchers("/usuario").hasAuthority("Ver Usuario");
                    http.requestMatchers("/usuario/musuario").hasAuthority("Ver Usuario");
                    http.requestMatchers("/usuario/mrol").hasAuthority("Ver Usuario");
                    http.requestMatchers("/usuario/guardar").hasAuthority("Registrar Usuario");
                    http.requestMatchers("/usuario/editar").hasAuthority("Editar Usuario");
                    http.requestMatchers("/usuario/cambiarestado").hasAuthority("Cambiar estado Usuario");

                    http.requestMatchers("/rol").hasAuthority("Gestión de Roles");
                    http.requestMatchers("/rol/mrol").hasAuthority("Gestión de Roles");
                    http.requestMatchers("/rol/mpermiso").hasAuthority("Gestión de Roles");
                    http.requestMatchers("/rol/mpermisorol").hasAuthority("Gestión de Roles");
                    http.requestMatchers("/rol/asignarpermiso").hasAuthority("Gestión de Roles");
                    http.requestMatchers("/rol/quitarpermiso").hasAuthority("Gestión de Roles");

                    http.requestMatchers("/prospecto").hasAuthority("Ver Prospecto");
                    http.requestMatchers("/prospecto/mprospecto").hasAuthority("Ver Prospecto");
                    http.requestMatchers("/prospecto/upload").hasAuthority("Registrar Prospecto");
                    http.requestMatchers("/prospecto/estadotiempo").hasAuthority("Ver Prospecto");
                    http.requestMatchers("/prospecto/limpiar").hasAuthority("Ver Prospecto");

                    http.requestMatchers("/distribuircliente").hasAuthority("Distribuir Clientes");
                    http.requestMatchers("/distribuircliente/distribuir").hasAuthority("Distribuir Clientes");
                    http.requestMatchers("/distribuircliente/musuario").hasAuthority("Distribuir Clientes");
                    http.requestMatchers("/distribuircliente/infocliente").hasAuthority("Distribuir Clientes");
                    http.requestMatchers("/distribuircliente/mestado").hasAuthority("Distribuir Clientes");
                    http.requestMatchers("/distribuircliente/mcliente").hasAuthority("Distribuir Clientes");

                    http.requestMatchers("/matricula").hasAuthority("Matricula");
                    http.requestMatchers("/matricula/mmatricula").hasAuthority("Matricula");
                    http.requestMatchers("/matricula/mcliente").hasAuthority("Matricula");
                    http.requestMatchers("/matricula/verificar").hasAuthority("Matricula");
                    http.requestMatchers("/matricula/images").hasAuthority("Matricula");

                    http.requestMatchers("/reportematricula").hasAuthority("Reporte Matricula");
                    http.requestMatchers("/reportematricula/mmatricula").hasAuthority("Reporte Matricula");
                    http.requestMatchers("/reportematricula/excel").hasAuthority("Reporte Matricula");
                    http.requestMatchers("/reportematricula/pdf").hasAuthority("Reporte Matricula");
                    http.requestMatchers("/reportematricula/images").hasAuthority("Reporte Matricula");

                    http.requestMatchers("/paquete").hasAuthority("Paquete");
                    http.requestMatchers("/paquete/mpaquete").hasAuthority("Paquete");
                    http.requestMatchers("/paquete/mcurso").hasAuthority("Paquete");
                    http.requestMatchers("/paquete/guardar").hasAuthority("Paquete");
                    http.requestMatchers("/paquete/editar").hasAuthority("Paquete");
                    http.requestMatchers("/paquete/cambiarestado").hasAuthority("Paquete");
                    http.requestMatchers("/paquete/guardardetalle").hasAuthority("Paquete");
                    http.requestMatchers("/paquete/mcursopaquete").hasAuthority("Paquete");
                    http.requestMatchers("/paquete/eliminarcursopaq").hasAuthority("Paquete");

                    http.requestMatchers("/procesoprospecto/mbanco").hasAuthority("Proceso Prospecto");
                    http.requestMatchers("/procesoprospecto").hasAuthority("Proceso Prospecto");
                    http.requestMatchers("/procesoprospecto/verificasesion").hasAuthority("Proceso Prospecto");
                    http.requestMatchers("/procesoprospecto/mostrar").hasAuthority("Proceso Prospecto");
                    http.requestMatchers("/procesoprospecto/actualizarestado").hasAuthority("Proceso Prospecto");
                    http.requestMatchers("/procesoprospecto/mcurso").hasAuthority("Proceso Prospecto");
                    http.requestMatchers("/procesoprospecto/mpaquete").hasAuthority("Proceso Prospecto");
                    http.requestMatchers("/procesoprospecto/finalizar").hasAuthority("Proceso Prospecto");
                    http.requestMatchers("/procesoprospecto/comanda").hasAuthority("Proceso Prospecto");
                    http.requestMatchers("/procesoprospecto/eliminacomanda").hasAuthority("Proceso Prospecto");
                    http.requestMatchers("/procesoprospecto/paquetecurso").hasAuthority("Proceso Prospecto");
                    http.requestMatchers("/procesoprospecto/guardar").hasAuthority("Proceso Prospecto");
                    http.requestMatchers("/procesoprospecto/mostrarver").hasAuthority("Proceso Prospecto");
                    http.requestMatchers("/procesoprospecto/actualizar").hasAuthority("Proceso Prospecto");

                    http.requestMatchers("/procesoprospectoadmin/mbanco").hasAuthority("Proceso Prospecto Administrador");
                    http.requestMatchers("/procesoprospectoadmin").hasAuthority("Proceso Prospecto Administrador");
                    http.requestMatchers("/procesoprospectoadmin/verificasesion").hasAuthority("Proceso Prospecto Administrador");
                    http.requestMatchers("/procesoprospectoadmin/mostrar").hasAuthority("Proceso Prospecto Administrador");
                    http.requestMatchers("/procesoprospectoadmin/actualizarestado").hasAuthority("Proceso Prospecto Administrador");
                    http.requestMatchers("/procesoprospectoadmin/mcurso").hasAuthority("Proceso Prospecto Administrador");
                    http.requestMatchers("/procesoprospectoadmin/mpaquete").hasAuthority("Proceso Prospecto Administrador");
                    http.requestMatchers("/procesoprospectoadmin/finalizar").hasAuthority("Proceso Prospecto Administrador");
                    http.requestMatchers("/procesoprospectoadmin/comanda").hasAuthority("Proceso Prospecto Administrador");
                    http.requestMatchers("/procesoprospectoadmin/eliminacomanda").hasAuthority("Proceso Prospecto Administrador");
                    http.requestMatchers("/procesoprospectoadmin/paquetecurso").hasAuthority("Proceso Prospecto Administrador");
                    http.requestMatchers("/procesoprospectoadmin/guardar").hasAuthority("Proceso Prospecto Administrador");
                    http.requestMatchers("/procesoprospectoadmin/mostrarver").hasAuthority("Proceso Prospecto Administrador");
                    http.requestMatchers("/procesoprospectoadmin/actualizar").hasAuthority("Proceso Prospecto Administrador");
                    http.requestMatchers("/procesoprospectoadmin/musuario").hasAuthority("Proceso Prospecto Administrador");

                    http.requestMatchers("/session").hasAuthority("Sesion");
                    http.requestMatchers("/session/cerrar").hasAuthority("Sesion");
                    http.requestMatchers("/session/abrir").hasAuthority("Sesion");
                    
                    http.requestMatchers("/sessionadmin").hasAuthority("Session Administrador");
                    http.requestMatchers("/sessionadmin/muser").hasAuthority("Session Administrador");
                    http.requestMatchers("/sessionadmin/infosesion").hasAuthority("Session Administrador");
                    http.requestMatchers("/sessionadmin/actualizarestado").hasAuthority("Session Administrador");
                    http.requestMatchers("/sessionadmin/cerrar").hasAuthority("Session Administrador");
                    http.requestMatchers("/sessionadmin/abrir").hasAuthority("Session Administrador");
                    
                    http.requestMatchers("/certificado").hasAuthority("Certificado");
                    http.requestMatchers("/certificado/mmatricula").hasAuthority("Certificado");
                    http.requestMatchers("/certificado/detalle").hasAuthority("Certificado");
                    http.requestMatchers("/certificado/enviarcert").hasAuthority("Certificado");
                    

                    http.anyRequest().authenticated();
                })
                .formLogin(form -> form.loginPage("/login")
                .loginProcessingUrl("/login")
                .defaultSuccessUrl("/inicio", true)
                .permitAll()).logout(
                logout -> logout
                        .logoutRequestMatcher(new AntPathRequestMatcher("/logout")).
                        logoutSuccessUrl("/login")
                        .permitAll())
                .build();
    }

    @Bean
    public AuthenticationManager authenticationManager(AuthenticationConfiguration authenticationConfiguration) throws Exception {
        return authenticationConfiguration.getAuthenticationManager();
    }

    @Bean
    public AuthenticationProvider authenticationProvider(CustomUserDetailsService CustomUserDetailsService) {
        DaoAuthenticationProvider provider = new DaoAuthenticationProvider();
        provider.setPasswordEncoder(passwordEncoder());
        provider.setUserDetailsService(CustomUserDetailsService);
        return provider;
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }
}
