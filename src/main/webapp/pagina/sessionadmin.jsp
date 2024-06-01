<%-- 
    Document   : sessionadmin
    Created on : 29 may 2024, 0:57:17
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

                            <div class="col-md-12">
                                <div class="card">
                                    <div class="card-header" style="background-color: #ff1a1a;color: #ffffff;">
                                        <h3 class="card-title">
                                            Lista de usuarios
                                        </h3>
                                    </div>
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <table class="table table-striped table-bordered table-hover" id="tabdatos">
                                                <thead class="table-success">
                                                    <tr>
                                                        <th>Username</th>
                                                        <th>DNI</th>
                                                        <th>Nombre</th>
                                                        <th>Celular</th>
                                                        <th>Acción</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr v-for="usu in usuario">
                                                        <td width="10%">{{usu.username}}</td>
                                                        <td width="10%">{{usu.dniper}}</td>
                                                        <td>{{usu.usuario}}</td>
                                                        <td width="10%">{{usu.celper}}</td>
                                                        <td width="20%">
                                                            <button class="btn btn-success btn-sm" @click="abrir(usu.id)">Abrir</button>
                                                            <button class="btn btn-warning btn-sm" @click="cerrar(usu.id)">Cerrar</button>
                                                            <button class="btn btn-info btn-sm" title="Ver última sesión" data-toggle="modal" data-target="#mdetalle" @click="getinfosesion(usu)">Info</button>
                                                        </td>
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
            <div class="modal fade" id="mdetalle" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color: #ff1a1a;color: #ffffff;">
                            <h5 class="modal-title" id="staticBackdropLabel">Ver Sesión</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label>Información</label>
                                <textarea  v-model="txtinfo" rows="6" class="form-control" disabled="true"></textarea>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancelar</button>
                            <button class="btn btn-info" type="button" @click="actualizar()">Actualizar</button>
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
                    usuario: [],
                    estadoses: "",
                    fecinises: "",
                    codses: "",
                    idsession: "",
                    fechacierre: "",
                    txtinfo: "",
                },
                mounted: function () {
                    this.getusuario();
                },
                methods: {
                    tabla: function () {
                        this.$nextTick(() => {
                            $('#tabdatos').DataTable({
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
                                    "info": "Mostrando página _PAGE_ de _PAGES_",
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
                        $("#tabdatos").DataTable().destroy();
                        this.tabla();
                    },
                    abrir: function (usu) {
                        var data = new FormData();
                        data.append('usu', usu);
                        axios.post('sessionadmin/abrir', data).then(response => {
                            if (response.data.resp == "si") {
                                toastr.success("La sesión se abrió correctamente");
                            }
                            if (response.data.resp == "existe") {
                                toastr.warning("Hay usuario tiene una sesión abierta");
                            }
                            if (response.data.resp == "yaexiste") {
                                toastr.warning("Solo se permite una sesión por día");
                            }
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    getusuario: function () {
                        axios.get('sessionadmin/muser').then(response => {
                            this.usuario = response.data;
                            this.config();
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    getinfosesion: function (usu) {
                        axios.get('sessionadmin/infosesion?usu=' + usu.id).then(response => {
                            if (response.data.codses != undefined) {
                                this.estadoses = response.data.estadoses;
                                this.fecinises = response.data.fecinises;
                                this.codses = response.data.codses;
                                this.idsession = response.data.idsession;
                                this.fechacierre = response.data.fechacierre;
                                this.txtinfo = "Usuario: " + usu.usuario + "\nCódigo: " + this.codses + "\nFecha de apertura: " + this.fecinises + "\nEstado: " + this.estadoses + "\nFecha de cierre: " + this.fechacierre;
                            } else {
                                this.txtinfo = "Usuario: " + usu.usuario + "\nMensaje: El usuario no tiene ninguna sesión";
                            }
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    cerrar: function (usu) {
                        var data = new FormData();
                        data.append('usu', usu);
                        axios.post('sessionadmin/cerrar', data).then(response => {
                            if (response.data.resp == "si") {
                                toastr.success("La sesión se cerró correctamente");
                            }
                            if (response.data.resp == "no") {
                                toastr.warning("No tiene ninguna sesión abierto");
                            }
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    actualizar: function () {
                        var data = new FormData();
                        data.append('idses', this.idsession);
                        data.append('esta', this.estadoses);
                        axios.post('sessionadmin/actualizarestado', data).then(response => {
                            if (response.data.resp == "si") {
                                $('#mdetalle').modal('toggle');
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