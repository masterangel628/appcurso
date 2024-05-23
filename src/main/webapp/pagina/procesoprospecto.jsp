<%-- 
    Document   : procesoprospecto
    Created on : 19 may 2024, 16:12:11
    Author     : Asus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
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
                        <div class="row mb-2">
                            <div class="col-sm-6">
                                <h1>Gestión de Clientes</h1>
                            </div>
                        </div>
                    </div>
                </div>
                <section class="content">
                    <div class="container-fluid">
                        <div class="card">
                            <div class="card-header" style="background-color: #ff1a1a;color: #ffffff;">
                                <h3 class="card-title">
                                    Cartera de clientes
                                </h3>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-striped table-bordered table-hover" id="tabprospecto">
                                        <thead class="table-success">
                                            <tr>
                                                <th>Nombre</th>
                                                <th>Celular</th>
                                                <th>Estado de Tiempo</th>
                                                <th>Acción</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr v-for="cli in cliente">
                                                <td width="40%">{{cli.nompros}}</td>
                                                <td>{{cli.celpros}}</td>
                                                <td>{{cli.estatimpros}}</td>
                                                <td>
                                                    <button class="btn btn-warning btn-sm" v-if="cli.estatimpros!='CALIENTE'" @click="cambiarcal(cli)" title="Cambiar a estado Caliente">
                                                        Caliente
                                                    </button>
                                                    <button class="btn btn-success btn-sm" v-if="cli.estatimpros!='TIBIO'" @click="cambiarti(cli)" title="Cambiar a estado Tibio">
                                                        Tibio
                                                    </button>
                                                    <button class="btn btn-primary btn-sm" v-if="cli.estatimpros!='FRIO'" @click="cambiarfri(cli)" title="Cambiar a estado Frio">
                                                        Frio
                                                    </button>
                                                    <button data-toggle="modal" data-target="#mprematricula" @click="seleccionar(cli)" class="btn btn-danger btn-sm" title="Inscribir al cliente">
                                                        <i class="far fa-save"></i>
                                                    </button>
                                                </td>
                                            </tr>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
            </div>
            <%@include file="footer.jsp" %>
            <div class="modal fade" id="mprematricula" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg modal-dialog-scrollable">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color: #ff1a1a;color: #ffffff;">
                            <h5 class="modal-title" id="staticBackdropLabel">Registro de Matricula</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close" @click="limpiar()">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label>DNI</label>
                                                    <input type="text" id="txtdni" v-model="txtdni" class="form-control" autocomplete="off">
                                                    <span class="invalid-feedback" role="alert">
                                                        <strong>{{msjdni}}</strong>
                                                    </span>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label>Apellido</label>
                                                    <input type="text" id="txtape" v-model="txtape" class="form-control" autocomplete="off">
                                                    <span class="invalid-feedback" role="alert">
                                                        <strong>{{msjape}}</strong>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label>Nombre</label>
                                                    <input type="text" id="txtnom" v-model="txtnom" class="form-control" autocomplete="off">
                                                    <span class="invalid-feedback" role="alert">
                                                        <strong>{{msjnom}}</strong>
                                                    </span>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label>Celular</label>
                                                    <input type="text" id="txtcel" v-model="txtcel" class="form-control" autocomplete="off">
                                                    <span class="invalid-feedback" role="alert">
                                                        <strong>{{msjcel}}</strong>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label>Correo</label>
                                            <input type="text" id="txtcor" v-model="txtcor" class="form-control" autocomplete="off">
                                            <span class="invalid-feedback" role="alert">
                                                <strong>{{msjcor}}</strong>
                                            </span>
                                        </div>
                                        <div class="form-group">
                                            <label>Dirección</label>
                                            <textarea v-model="txtdir" id="txtdir" class="form-control"></textarea>
                                            <span class="invalid-feedback" role="alert">
                                                <strong>{{msjdir}}</strong>
                                            </span>
                                        </div>
                                        <button class="btn btn-primary" @click="guardar()">Guardar</button>
                                    </div>
                                    
                    </div>
                </div>
            </div>
        </div>
        <%@include file="scrip.jsp" %>
        <script>
            // BS-Stepper Init
            document.addEventListener('DOMContentLoaded', function () {
                window.stepper = new Stepper(document.querySelector('.bs-stepper'))
            });
            let app = new Vue({
                el: '#app',
                data: {
                    cliente: [],

                    
                },
                mounted: function () {
                    this.getcliente();
                },
                methods: {
                    limpiar: function () {
                        
                    },
                    seleccionar: function (cli) {
                        console.log(cli);
                    },
                    getcliente: function () {
                        axios.get('procesoprospecto/mostrar').then(response => {
                            this.cliente = response.data;
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    cambiarcal: function (cli) {
                        var data = new FormData();
                        data.append('esta', "CALIENTE");
                        data.append('idpro', cli.fkidprospecto);
                        axios.post('procesoprospecto/actualizarestado', data).then(response => {
                            this.getcliente();
                        }).catch(error => {
                        })
                    },
                    cambiarti: function (cli) {
                        var data = new FormData();
                        data.append('esta', "TIBIO");
                        data.append('idpro', cli.fkidprospecto);
                        axios.post('procesoprospecto/actualizarestado', data).then(response => {
                            this.getcliente();
                        }).catch(error => {
                        })
                    },
                    cambiarfri: function (cli) {
                        var data = new FormData();
                        data.append('esta', "FRIO");
                        data.append('idpro', cli.fkidprospecto);
                        axios.post('procesoprospecto/actualizarestado', data).then(response => {
                            this.getcliente();
                        }).catch(error => {
                        })
                    },
                },
            });
        </script>
    </body>
</html>


