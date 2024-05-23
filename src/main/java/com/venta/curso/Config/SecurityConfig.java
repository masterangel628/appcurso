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
