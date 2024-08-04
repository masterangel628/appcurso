<%-- 
    Document   : menu
    Created on : 28 sept. 2022, 10:18:15
    Author     : Asus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <meta name="description" content="Sistema de Gestión Cursos - ISIPP">
        <meta name="author" content="Miguel Ángel Toledo Cordova">
        <title>Reporte de ventas</title>
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
                                <h1>Reporte de ventas</h1>
                            </div>
                        </div>
                    </div>
                </div>
                <section class="content">
                    <div class="container-fluid">
                        <div class="row">

                            <div class="col-md-12">
                                <div class="card">
                                    <div class="card-header" style="background-color: #ff1a1a;color: #ffffff;" >
                                        <h3 class="card-title">
                                            Lista de ventas
                                        </h3>
                                        <div class="card-tools">
                                            <div class="btn-group" role="group" aria-label="Basic example">
                                                <button class="btn btn-danger btn-sm" title="Generar reporte de venta"  data-toggle="modal" data-target="#mexcel"><i class="fas fa-file-excel"></i></button>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <table class="table table-striped table-bordered table-hover" id="tabdatos">
                                                <thead class="table-success">
                                                    <tr>
                                                        <th width="15%">Fecha</th>
                                                        <th>Asesor</th>
                                                        <th>Cliente</th>
                                                        <th>Cursos</th>
                                                        <th width="10%">Monto</th>
                                                        <th width="10%">Estado</th>
                                                        <th width="10%">Ver</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr v-for="ven in venta">
                                                        <td>{{ven.fecmat}}</td>
                                                        <td>{{ven.nomusu}}</td>
                                                        <td>{{ven.nomcli}}</td> 
                                                        <td>{{ven.curpa}}</td>
                                                        <td>{{ven.montomat}}</td>
                                                        <td>
                                                            <span class="badge badge-success" v-if="ven.estado=='Vigente'">{{ven.estado}}</span>
                                                            <span class="badge badge-warning" v-if="ven.estado=='Anulado'">{{ven.estado}}</span>
                                                        </td>
                                                        <td>
                                                            <button v-if="ven.estado=='Anulado'" class="btn btn-primary btn-sm" title="Ver motivo de anulación" data-toggle="modal" data-target="#mdesc" @click="seleccionar(ven)"><i class="fa fa-eye"></i></button>
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

            <div class="modal fade" id="mexcel" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color: #ff1a1a;color: #ffffff;">
                            <h5 class="modal-title" id="staticBackdropLabel">Reporte de venta</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close" @click="limpiar()">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <label>Fecha inicio</label>
                                    <input type="date" v-model="txtfecdes" id="txtfecdes" autocomplete="off" class="form-control">
                                </div>
                                <div class="col-md-6">
                                    <label>Fecha final</label>
                                    <input type="date" v-model="txtfechas"id="txtfechas" autocomplete="off" class="form-control">
                                </div>
                            </div>
                        </div>
                        <div class="card-footer">
                            <button class="btn btn-secondary" type="button" data-dismiss="modal"  @click="limpiar()">Cancelar</button>
                            <button class="btn btn-info" @click="reportexcel()">Generar</button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="mdesc" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-scrollable">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color: #ff1a1a;color: #ffffff;">
                            <h5 class="modal-title" id="staticBackdropLabel">Ver Descripción</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label>Cliente</label>
                                <input type="text" v-model="txtcliente" class="form-control" disabled="true">
                            </div>
                            <div class="form-group">
                                <label>Descripción</label>
                                <textarea v-model="txtdesc" class="form-control" readonly="true"></textarea>
                            </div>
                            <div class="row">
                                <div class="col-md-6" v-for="vau in vaucher">
                                    <div class="card mb-2 bg-gradient-dark">
                                        <img class="card-img-top" v-bind:src="'matricula/images/'+vau.nomvau" alt="Dist Photo 1">
                                    </div>
                                </div>
                            </div>
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
                    venta: [],
                    txtfechas: "",
                    txtfecdes: "",
                    txtdesc: "",

                    vaucher: [],
                    txtcliente: '',
                },
                mounted: function () {
                    this.getventa();
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
                    seleccionar: function (ven) {
                        this.txtdesc = ven.descmat;
                        this.getvaucher(ven);
                    },
                    config: function () {
                        $("#tabdatos").DataTable().destroy();
                        this.tabla();
                    },
                    limpiar: function () {
                        this.txtfechas = "";
                        this.txtfecdes = "";
                    },
                    reportexcel: function () {
                        if (this.txtfecdes != "" && this.txtfechas != "") {
                            window.open('reporteventa/excel?fecdes=' + this.txtfecdes + '&fechas=' + this.txtfechas, ' _blank');
                            $('#mexcel').modal('toggle');
                            this.limpiar();
                        } else {
                            toastr.warning("Seleccione las fechas");
                        }

                    },
                    getventa: function () {
                        axios.get('reporteventa/mventa').then(response => {
                            this.venta = response.data;
                            this.config();
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    getvaucher: function (mat) {
                        this.txtcliente = mat.dnicli + " - " + mat.nomcli;
                        axios.get('reportematricula/mvaucher/' + mat.idmatricula).then(response => {
                            this.vaucher = response.data;
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                },
            });
        </script>
    </body>
</html>
