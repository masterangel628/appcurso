
<%-- 
    Document   : menu
    Created on : 28 sept. 2022, 10:18:15
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
        <title>Prospecto</title>
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
                                <h1>Gestión de Prospecto</h1>
                            </div>
                        </div>
                    </div>
                </div>
                <section class="content">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="card">
                                    <div class="card-header" style="background-color: #ff1a1a;color: #ffffff;">
                                        <h3 class="card-title">
                                            Importar archivo excel
                                        </h3>
                                    </div>
                                    <div class="card-body">
                                        <div class="form-group">
                                            <label>Archivo</label>
                                            <div class="input-group">
                                                <input type="file" name="file" @change="getArchivo" class="form-control" accept=".xlsx, .xls">
                                                <div class="input-group-append">
                                                    <sec:authorize access="hasAuthority('Registrar Prospecto')">
                                                    <button class="btn btn-primary" type="button" @click="subir()">
                                                        <i class="fas fa-upload"></i>
                                                    </button>
                                                    </sec:authorize>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <span class="loader"></span>
                                        </div>
                                        <center v-if="cenlod">
                                            <div class="spinner-border" style="width: 10rem; height: 10rem;" role="status">
                                                <span class="sr-only">Loading...</span>
                                            </div>
                                        </center>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="card">
                                    <div class="card-header" style="background-color: #ff1a1a;color: #ffffff;">
                                        <h3 class="card-title">
                                            Cartera de clientes
                                        </h3>
                                    </div>
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <table class="table table-striped table-bordered table-hover">
                                                <thead class="table-success">
                                                    <tr>
                                                        <th>Nombre</th>
                                                        <th>Celular</th>
                                                        <th>Fecha</th>
                                                        <th>Estado de Tiempo</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr v-for="pro in prospecto">
                                                        <td>{{pro.nompros}}</td>
                                                        <td>{{pro.celpros}}</td>
                                                        <td>{{pro.fechorpros}}</td>
                                                        <td>{{pro.estatimpros}}</td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
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
        <script>
            let app = new Vue({
                el: '#app',
                data: {
                    prospecto: [],
                    archivo: null,
                    cenlod: false,
                },
                mounted: function () {
                    this.getprospecto();
                },
                methods: {
                    getArchivo(event) {
                        if (!event.target.files.length) {
                            this.archivo = null;
                        } else {
                            this.archivo = event.target.files[0];
                        }
                    },
                    getprospecto: function () {
                        axios.get('prospecto/mprospecto').then(response => {
                            this.prospecto = response.data;
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    subir: function () {
                        if (this.archivo == null) {
                            toastr.warning("Seleccione un archivo");
                        } else {
                            this.cenlod = true;
                            var data = new FormData();
                            data.append('file', this.archivo);
                            axios.post('prospecto/upload', data).then(response => {
                                if (response.data.resp == "si") {
                                    this.getprospecto();
                                    this.archivo = null;
                                    this.cenlod = false;
                                } else {
                                    toastr.warning(response.data.file);
                                    this.cenlod = false;
                                }


                            }).catch(error => {
                            })
                        }
                    },
                },
            });
        </script>
    </body>
</html>

