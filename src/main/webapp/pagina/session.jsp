<%-- 
    Document   : session
    Created on : 20 may 2024, 11:48:55
    Author     : Asus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Sesión</title>
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
                        <div class="row mb-2">
                            <div class="col-sm-6">
                                <h1>Gestión de Sesiones</h1>
                            </div>
                        </div>
                    </div>
                </div>
                <section class="content">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-12 col-sm-12">
                                <div class="card card-primary card-outline card-outline-tabs">
                                    <div class="card-header p-0 border-bottom-0">
                                        <ul class="nav nav-tabs" id="custom-tabs-four-tab" role="tablist">
                                            <li class="nav-item">
                                                <a class="nav-link active" id="custom-tabs-four-home-tab" data-toggle="pill" href="#tababrirsesion" role="tab" aria-controls="custom-tabs-four-home" aria-selected="true">Abrir Sesión</a>
                                            </li>
                                            <li class="nav-item">
                                                <a class="nav-link" id="custom-tabs-four-profile-tab" data-toggle="pill" href="#tabcerrarsesion" role="tab" aria-controls="custom-tabs-four-profile" aria-selected="false">Cerrar Sesión</a>
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="card-body">
                                        <div class="tab-content" id="custom-tabs-four-tabContent">
                                            <div class="tab-pane fade active show" id="tababrirsesion" role="tabpanel" aria-labelledby="custom-tabs-four-home-tab">
                                                <button class="btn btn-success" @click="abrir()">Abrir</button>
                                            </div>
                                            <div class="tab-pane fade" id="tabcerrarsesion" role="tabpanel" aria-labelledby="custom-tabs-four-profile-tab">
                                                <button class="btn btn-success" @click="cerrar()">Cerrar</button>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                        <!--div class="row">
                            <div class="col-md-12">
                                <div class="card card-primary card-tabs">
                                    <div class="card-header p-0 pt-1">
                                        <ul class="nav nav-tabs" id="custom-tabs-five-tab" role="tablist">
                                            <li class="nav-item">
                                                <a class="nav-link" id="custom-tabs-five-overlay-tab" data-toggle="pill" href="#custom-tabs-five-overlay" role="tab" aria-controls="custom-tabs-five-overlay" aria-selected="false">Overlay</a>
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="card-body">
                                        <div class="tab-content" id="custom-tabs-five-tabContent">
                                            <div class="tab-pane fade" id="custom-tabs-five-overlay" role="tabpanel" aria-labelledby="custom-tabs-five-overlay-tab">
                                                <div class="overlay-wrapper">
                                                    <div class="overlay">
                                                        <i class="fas fa-3x fa-sync-alt fa-spin"></i>
                                                        <div class="text-bold pt-2">Loading...</div>
                                                    </div>
                                                    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin malesuada lacus ullamcorper dui molestie, sit amet congue quam finibus. Etiam ultricies nunc non magna feugiat commodo. Etiam odio magna, mollis auctor felis vitae, ullamcorper ornare ligula. Proin pellentesque tincidunt nisi, vitae ullamcorper felis aliquam id. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Proin id orci eu lectus blandit suscipit. Phasellus porta, ante et varius ornare, sem enim sollicitudin eros, at commodo leo est vitae lacus. Etiam ut porta sem. Proin porttitor porta nisl, id tempor risus rhoncus quis. In in quam a nibh cursus pulvinar non consequat neque. Mauris lacus elit, condimentum ac condimentum at, semper vitae lectus. Cras lacinia erat eget sapien porta consectetur.
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div-->
                    </div>
                </section>
            </div>
            <%@include file="footer.jsp" %>
        </div>
        <%@include file="scrip.jsp" %>
        <script>
            let app = new Vue({
                el: '#app',
                data: {
                    
                },
                mounted: function () {
                },
                methods: {
                    abrir: function () {
                        axios.post('session/abrir').then(response => {
                            if(response.data.resp=="si"){
                                toastr.success("La sesión se abrió correctamente");
                            }
                            if(response.data.resp=="existe"){
                                toastr.warning("Hay una sesión abierta");
                            }
                            if(response.data.resp=="yaexiste"){
                                toastr.warning("Solo se permite una sesión por día");
                            }
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    cerrar: function () {
                        axios.post('session/cerrar').then(response => {
                             if(response.data.resp=="si"){
                                toastr.success("La sesión se cerró correctamente");
                            }
                            if(response.data.resp=="no"){
                                toastr.warning("No tiene ninguna sesión abierto");
                            }
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                },
            });
        </script>
    </body>
</html>
