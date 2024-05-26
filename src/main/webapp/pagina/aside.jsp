<%-- 
    Document   : aside
    Created on : 9 may 2024, 22:05:12
    Author     : Asus
--%>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<aside class="main-sidebar sidebar-light-warning elevation-4">
    <a href="inicio" class="brand-link">
        <img src="public/dist/img/icono.png" alt="AdminLTE Logo" class="brand-image img-circle elevation-3" style="opacity: .8">
        <span class="brand-text font-weight-light">ISIPP</span>
    </a>
    <div class="sidebar">
        <nav class="mt-2">
            <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false" id="menu">
                <li class="nav-item">
                    <a href="inicio" class="nav-link active">
                        <i class="nav-icon fas fa-th"></i>
                        <p>
                            Inicio
                        </p>
                    </a>
                </li>
                <li class="nav-item">
                    <a href="#" class="nav-link">
                        <i class="nav-icon fab fa-nutritionix"></i>
                        <p>
                            Matrícula
                            <i class="right fas fa-angle-left"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        <sec:authorize access="hasAuthority('Ver Cliente')">
                            <li class="nav-item">
                                <a href="cliente" class="nav-link">
                                    <i class="far fa-circle nav-icon"></i>
                                    <p>Cliente</p>
                                </a>
                            </li>
                        </sec:authorize>
                        <sec:authorize access="hasAuthority('Matricula')">
                            <li class="nav-item">
                                <a href="matricula" class="nav-link">
                                    <i class="far fa-circle nav-icon"></i>
                                    <p>Matrícula</p>
                                </a>
                            </li>
                        </sec:authorize>
                    </ul>
                </li>
                <li class="nav-item">
                    <a href="#" class="nav-link">
                        <i class="nav-icon fas fa-project-diagram"></i>
                        <p>
                            Prospecto
                            <i class="right fas fa-angle-left"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        <sec:authorize access="hasAuthority('Ver Prospecto')">
                            <li class="nav-item">
                                <a href="prospecto" class="nav-link">
                                    <i class="far fa-circle nav-icon"></i>
                                    <p>Prospecto</p>
                                </a>
                            </li>
                        </sec:authorize>
                        <sec:authorize access="hasAuthority('Proceso Prospecto')">
                            <li class="nav-item">
                                <a href="procesoprospecto" class="nav-link">
                                    <i class="far fa-circle nav-icon"></i>
                                    <p>Proceso Prospecto</p>
                                </a>
                            </li>
                        </sec:authorize>
                        <sec:authorize access="hasAuthority('Distribuir Clientes')">
                            <li class="nav-item">
                                <a href="distribuircliente" class="nav-link">
                                    <i class="far fa-circle nav-icon"></i>
                                    <p>Distribuir Cliente</p>
                                </a>
                            </li>
                        </sec:authorize>
                    </ul>
                </li>
                <li class="nav-item">
                    <a href="#" class="nav-link">
                        <i class="nav-icon fas fa-sort-amount-up-alt"></i>
                        <p>
                            Mantenimiento
                            <i class="right fas fa-angle-left"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        <sec:authorize access="hasAuthority('Ver Curso')">
                            <li class="nav-item">
                                <a href="curso" class="nav-link">
                                    <i class="far fa-circle nav-icon"></i>
                                    <p>Curso</p>
                                </a>
                            </li>
                        </sec:authorize>
                        <sec:authorize access="hasAuthority('Ver Docente')">
                            <li class="nav-item">
                                <a href="docente" class="nav-link">
                                    <i class="far fa-circle nav-icon"></i>
                                    <p>Docente</p>
                                </a>
                            </li>
                        </sec:authorize>
                        <sec:authorize access="hasAuthority('Ver Banco')">
                            <li class="nav-item">
                                <a href="banco" class="nav-link">
                                    <i class="far fa-circle nav-icon"></i>
                                    <p>Banco</p>
                                </a>
                            </li>
                        </sec:authorize>
                        <sec:authorize access="hasAuthority('Paquete')">  
                            <li class="nav-item">
                                <a href="paquete" class="nav-link">
                                    <i class="far fa-circle nav-icon"></i>
                                    <p>Paquete</p>
                                </a>
                            </li>
                        </sec:authorize>
                    </ul>
                </li>
                <li class="nav-item">
                    <a href="#" class="nav-link">
                        <i class="nav-icon fas fa-user"></i>
                        <p>
                            Usuario
                            <i class="right fas fa-angle-left"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        <sec:authorize access="hasAuthority('Ver Usuario')">
                            <li class="nav-item">
                                <a href="usuario" class="nav-link">
                                    <i class="far fa-circle nav-icon"></i>
                                    <p>Usuario</p>
                                </a>
                            </li>
                        </sec:authorize>
                        <sec:authorize access="hasAuthority('Gestión de Roles')">
                            <li class="nav-item">
                                <a href="rol" class="nav-link">
                                    <i class="far fa-circle nav-icon"></i>
                                    <p>Roles</p>
                                </a>
                            </li>
                        </sec:authorize>
                        <sec:authorize access="hasAuthority('Sesion')">
                            <li class="nav-item">
                                <a href="session" class="nav-link">
                                    <i class="far fa-circle nav-icon"></i>
                                    <p>Sesión</p>
                                </a>
                            </li>
                        </sec:authorize>
                    </ul>
                </li>
                <li class="nav-item">
                    <a href="#" class="nav-link">
                        <i class="nav-icon fas fa-folder-open"></i>
                        <p>
                            Reporte
                            <i class="right fas fa-angle-left"></i>
                        </p>
                    </a>
                    <ul class="nav nav-treeview">
                        <sec:authorize access="hasAuthority('Reporte Matricula')">
                            <li class="nav-item">
                                <a href="reportematricula" class="nav-link">
                                    <i class="far fa-circle nav-icon"></i>
                                    <p>Matrícula</p>
                                </a>
                            </li>
                        </sec:authorize>
                    </ul>
                </li>
            </ul>
        </nav>
    </div>
</aside>
