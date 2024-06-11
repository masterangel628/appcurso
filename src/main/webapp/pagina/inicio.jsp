<%-- 
    Document   : inicio
    Created on : 19 may 2024, 15:04:56
    Author     : Asus
--%>

<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <meta name="description" content="Sistema de Gestión Cursos - ISIPP">
	<meta name="author" content="Miguel Ángel Toledo Cordova">
        <title>Inicio</title>
        <link href="public/dist/img/icono.png" rel="icon">
        <%@include file="estilocss.jsp" %>
    </head>
    <body class="hold-transition sidebar-mini layout-fixed">
        <div class="wrapper" id="app">
            <%@include file="navbar.jsp" %>
            <%@include file="aside.jsp" %>
            <div class="content-wrapper">
                <div class="content-header">
                    <div class="container-fluid">

                    </div>
                </div>
                <section class="content">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-lg-3 col-6">
                                <div class="small-box bg-info">
                                    <div class="inner">
                                        <h3>{{cantcliasig}}</h3>
                                        <p>Clientes asignados</p>
                                    </div>
                                    <div class="icon">
                                        <i class="ion ion-person-add"></i>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-3 col-6">

                                <div class="small-box bg-success">
                                    <div class="inner">
                                        <h3>{{cantcliveri}}</h3>
                                        <p>Clientes verificados</p>
                                    </div>
                                    <div class="icon">
                                        <i class="ion ion-person-add"></i>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-3 col-6">

                                <div class="small-box bg-warning">
                                    <div class="inner">
                                        <h3>{{cantclinoveri}}</h3>
                                        <p>Clientes no verificados</p>
                                    </div>
                                    <div class="icon">
                                        <i class="ion ion-person-add"></i>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-3 col-6">

                                <div class="small-box bg-danger">
                                    <div class="inner">
                                        <h3>{{cantclimat}}</h3>
                                        <p>Clientes matriculados</p>
                                    </div>
                                    <div class="icon">
                                        <i class="ion ion-person-add"></i>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </section>
            </div>
            <%@include file="footer.jsp" %>
        </div>
        <%@include file="scrip.jsp" %>
    </body>
    <script>
        let app = new Vue({
            el: '#app',
            data: {
                cantcliasig: 0,
                cantclimat: 0,
                cantclinoveri: 0,
                cantcliveri: 0,
            },
            mounted: function () {
                this.getinfo();
            },
            methods: {
                getinfo: function () {
                    axios.get('inicio/info').then(response => {
                        this.cantcliasig = response.data.cantcliasig;
                        this.cantclimat = response.data.cantclimat;
                        this.cantclinoveri = response.data.cantclinoveri;
                        this.cantcliveri = response.data.cantcliveri;
                    }).catch(function (error) {
                        console.log(error);
                    });
                },
            },
        });
    </script>
</html>


