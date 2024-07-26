<%-- 
    Document   : aside
    Created on : 9 may 2024, 22:05:12
    Author     : Asus
--%>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<aside class="main-sidebar sidebar-light-warning elevation-4">
    <a href="<%= request.getContextPath()%>/inicio" class="brand-link">
        <img src="<%= request.getContextPath()%>/public/dist/img/icono.png" alt="AdminLTE Logo" class="brand-image img-circle elevation-3" style="opacity: .8">
        <span class="brand-text font-weight-light">ISIPP</span>
    </a>
    <div class="sidebar">
        <nav class="mt-2">
            <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false" id="menu">
                <li class="nav-item">
                    <a href="<%= request.getContextPath()%>/inicio" class="nav-link active">
                        <i class="nav-icon fas fa-th"></i>
                        <p>
                            Inicio
                        </p>
                    </a>
                </li>
                <sec:authorize access="hasAnyAuthority('Ver Cliente','Matricula')">
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
                                    <a href="<%= request.getContextPath()%>/cliente" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Cliente</p>
                                    </a>
                                </li>
                            </sec:authorize>
                            <sec:authorize access="hasAuthority('Matricula')">
                                <li class="nav-item">
                                    <a href="<%= request.getContextPath()%>/matricula" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Matrícula</p>
                                    </a>
                                </li>
                            </sec:authorize>
                        </ul>
                    </li>
                </sec:authorize>
                <sec:authorize access="hasAnyAuthority('Ver Prospecto','Proceso Prospecto','Distribuir Clientes','Proceso Prospecto Administrador')">
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
                                    <a href="<%= request.getContextPath()%>/prospecto" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Prospecto</p>
                                    </a>
                                </li>
                            </sec:authorize>
                            <sec:authorize access="hasAuthority('Proceso Prospecto')">
                                <li class="nav-item">
                                    <a href="<%= request.getContextPath()%>/procesoprospecto" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Proceso Prospecto</p>
                                    </a>
                                </li>
                            </sec:authorize>
                            <sec:authorize access="hasAuthority('Distribuir Clientes')">
                                <li class="nav-item">
                                    <a href="<%= request.getContextPath()%>/distribuircliente" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Distribuir Cliente</p>
                                    </a>
                                </li>
                            </sec:authorize>
                            <sec:authorize access="hasAuthority('Proceso Prospecto Administrador')">
                                <li class="nav-item">
                                    <a href="<%= request.getContextPath()%>/procesoprospectoadmin" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Prospecto Administrador</p>
                                    </a>
                                </li>
                            </sec:authorize>
                        </ul>
                    </li>
                </sec:authorize>
                <sec:authorize access="hasAnyAuthority('Ver Curso','Ver Docente','Ver Banco','Paquete')">
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
                                    <a href="<%= request.getContextPath()%>/curso" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Curso</p>
                                    </a>
                                </li>
                            </sec:authorize>
                            <sec:authorize access="hasAuthority('Ver Docente')">
                                <li class="nav-item">
                                    <a href="<%= request.getContextPath()%>/docente" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Docente</p>
                                    </a>
                                </li>
                            </sec:authorize>
                            <sec:authorize access="hasAuthority('Ver Banco')">
                                <li class="nav-item">
                                    <a href="<%= request.getContextPath()%>/banco" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Banco</p>
                                    </a>
                                </li>
                            </sec:authorize>
                            <sec:authorize access="hasAuthority('Paquete')">  
                                <li class="nav-item">
                                    <a href="<%= request.getContextPath()%>/paquete" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Paquete</p>
                                    </a>
                                </li>
                            </sec:authorize>
                        </ul>
                    </li>
                </sec:authorize>
                <sec:authorize access="hasAnyAuthority('Ver Usuario','Gestión de Roles','Sesion','Session Administrador')">
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
                                    <a href="<%= request.getContextPath()%>/usuario" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Usuario</p>
                                    </a>
                                </li>
                            </sec:authorize>
                            <sec:authorize access="hasAuthority('Gestión de Roles')">
                                <li class="nav-item">
                                    <a href="<%= request.getContextPath()%>/rol" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Roles</p>
                                    </a>
                                </li>
                            </sec:authorize>
                            <sec:authorize access="hasAuthority('Sesion')">
                                <li class="nav-item">
                                    <a href="<%= request.getContextPath()%>/session" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Sesión</p>
                                    </a>
                                </li>
                            </sec:authorize>
                            <sec:authorize access="hasAuthority('Session Administrador')">
                                <li class="nav-item">
                                    <a href="<%= request.getContextPath()%>/sessionadmin" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Sesión Administrador</p>
                                    </a>
                                </li>
                            </sec:authorize>
                        </ul>
                    </li>
                </sec:authorize>

                <sec:authorize access="hasAnyAuthority('Certificado')">
                    <li class="nav-item">
                        <a href="#" class="nav-link">
                            <i class="nav-icon fas fa-certificate"></i>
                            <p>
                                Certificado
                                <i class="right fas fa-angle-left"></i>
                            </p>
                        </a>
                        <ul class="nav nav-treeview">
                            <sec:authorize access="hasAuthority('Certificado')">
                                <li class="nav-item">
                                    <a href="<%= request.getContextPath()%>/certificado" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Seguimiento</p>
                                    </a>
                                </li>
                            </sec:authorize>
                        </ul>
                    </li>
                </sec:authorize>
                <sec:authorize access="hasAnyAuthority('Reporte Matricula')">
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
                                    <a href="<%= request.getContextPath()%>/reportematricula" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Matrícula</p>
                                    </a>
                                </li>
                            </sec:authorize>
                            <sec:authorize access="hasAuthority('Reporte Venta')">
                                <li class="nav-item">
                                    <a href="<%= request.getContextPath()%>/reporteventa" class="nav-link">
                                        <i class="far fa-circle nav-icon"></i>
                                        <p>Venta</p>
                                    </a>
                                </li>
                            </sec:authorize>
                        </ul>
                    </li>
                </sec:authorize>
            </ul>
        </nav>
    </div>
</aside>
