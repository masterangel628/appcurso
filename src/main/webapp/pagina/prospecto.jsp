
<%-- 
    Document   : menu
    Created on : 28 sept. 2022, 10:18:15
    Author     : Asus
--%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <meta name="description" content="Sistema de Gestión Cursos - ISIPP">
	<meta name="author" content="Miguel Ángel Toledo Cordova">
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
                            <div class="col-sm-6">
                                <ol class="breadcrumb float-sm-right">
                                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#mdistribuir">
                                        Agregar
                                    </button> 
                                </ol>
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
                                <div class="card-tools">
                                    <button class="btn btn-danger" data-toggle="modal" data-target="#mactualizar" title="Proceso de actualización">Actualizar</button>
                                </div>
                            </div>
                            <div class="card-body">
                                <div class="table-responsive">
                                    <table class="table table-striped table-bordered table-hover" id="tabprospecto">
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
                                                <td width="40%">{{pro.nompros}}</td>
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
                </section>
            </div>
            <div class="modal fade" id="mdistribuir" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color: #ff1a1a;color: #ffffff;">
                            <h5 class="modal-title" id="staticBackdropLabel"> Importar archivo excel</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
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
                            <center v-if="cenlod">
                                <div class="spinner-border" style="width: 5rem; height: 5rem;" role="status">
                                    <span class="sr-only">Loading...</span>
                                </div>
                            </center>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal fade" id="mactualizar" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color: #ff1a1a;color: #ffffff;">
                            <h5 class="modal-title" id="staticBackdropLabel">Actualizar clientes</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <span>Proceso de actualización</span>
                            <center v-if="cenlodproc">
                                <div class="spinner-border" style="width: 5rem; height: 5rem;" role="status">
                                    <span class="sr-only">Loading...</span>
                                </div>
                            </center>
                        </div>
                        <div class="card-footer">
                            <button class="btn btn-primary" @click="actualizarestado()">Actualizar estado</button>
                            <button class="btn btn-info" @click="cambiarnoasig()">Actualizar asignación</button>
                        </div>
                    </div>
                </div>
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
                    cenlodproc: false,
                },
                mounted: function () {
                    this.getprospecto();
                },
                methods: {
                    tabla: function () {
                        this.$nextTick(() => {
                            $('#tabprospecto').DataTable({
                                "language": {
                                    "lengthMenu": "Mostrar " +
                                            "<select class='custom-select custom-select-sm form-control form-control-sm'>" +
                                            "<option value='5'>5</option>" +
                                            "<option value='10'>10</option>" +
                                            "<option value='25'>25</option>" +
                                            "<option value='50'>50</option>" +
                                            "<option value='100'>100</option>" +
                                            "<option value='-1'>Todo</option>" +
                                            "</select>" +
                                            " registros por página",
                                    "zeroRecords": "No se encontró nada, lo siento",
                                    "info": "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
                                    "infoEmpty": "No hay registros disponibles",
                                    "infoFiltered": "(Filtrado de _MAX_ registros totales)",
                                    "search": "Buscar:",
                                    "paginate": {
                                        "next": "Siguiente",
                                        "previous": "Anterior"
                                    }
                                }

                            });
                        });
                    },
                    config: function () {
                        $("#tabprospecto").DataTable().destroy();
                        this.tabla();
                    },
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
                            this.config();
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
                                    $('#mdistribuir').modal('toggle');
                                } else {
                                    toastr.warning(response.data.file);
                                    this.cenlod = false;
                                }


                            }).catch(error => {
                            })
                        }
                    },
                    actualizarestado: function () {
                        Swal.fire({
                            title: "Mensaje del Sistema",
                            text: "¿Desea cambiar el estado de tiempo de los clientes?",
                            icon: "warning",
                            showCancelButton: true,
                            confirmButtonColor: "#3085d6",
                            cancelButtonColor: "#d33",
                            confirmButtonText: "Si, Cambiar"
                        }).then((result) => {
                            if (result.isConfirmed) {
                                this.cenlodproc = true;
                                axios.post('prospecto/estadotiempo').then(response => {
                                    if (response.data == "si") {
                                        this.getprospecto();
                                        this.cenlodproc = false;
                                        $('#mactualizar').modal('toggle');
                                    }
                                }).catch(error => {
                                })
                            }
                        });
                    },
                    cambiarnoasig: function () {
                        Swal.fire({
                            title: "Mensaje del Sistema",
                            text: "¿Este proceso se debe de ejecutar al finalizar el dia despues que todos los usuarios cierren sesión?",
                            icon: "warning",
                            showCancelButton: true,
                            confirmButtonColor: "#3085d6",
                            cancelButtonColor: "#d33",
                            confirmButtonText: "Si, Cambiar"
                        }).then((result) => {
                            if (result.isConfirmed) {
                                this.cenlodproc = true;
                                axios.post('prospecto/limpiar').then(response => {
                                    if (response.data == "si") {
                                        this.getprospecto();
                                        this.cenlodproc = false;
                                        $('#mactualizar').modal('toggle');
                                    }
                                }).catch(error => {
                                })
                            }
                        });
                    },
                },
            });
        </script>
    </body>
</html>

