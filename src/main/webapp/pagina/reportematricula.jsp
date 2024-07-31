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
        <title>Ver Matricula</title>
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
                                <h1>Gestión de Matricula</h1>
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
                                            Lista de matrícula verificada
                                        </h3>
                                        <div class="card-tools">
                                            <div class="btn-group" role="group" aria-label="Basic example">
                                                <button class="btn btn-danger btn-sm" title="Generar reporte de matriculados" data-toggle="modal" data-target="#mcsv"><i class="fas fa-file-csv"></i></button>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <table class="table table-striped table-bordered table-hover" id="tabdatos">
                                                <thead class="table-success">
                                                    <tr>
                                                        <th width="15%">Número</th>
                                                        <th>Cliente</th>
                                                        <th width="10%">Monto</th>
                                                        <th width="10%">Grupo</th>
                                                        <th>Asesor</th>
                                                        <th width="10%">Fecha</th>
                                                        <th width="5%">Acción</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr v-for="mat in matricula">
                                                        <td>{{mat.nummat}}</td>
                                                        <td>{{mat.documento}} - {{mat.nombre}}</td>
                                                        <td>{{mat.montomat}}</td> 
                                                        <td>{{mat.grupomat}}</td>
                                                         <td>{{mat.nomusu}}</td>
                                                        <td>{{mat.fecmat}}</td>
                                                        <td>
                                                            <button title="Ver Váucher" data-toggle="modal" @click="getvaucher(mat)" data-target="#mvervaucher" class="btn btn-info btn-sm"><i class="fa fa-eye"></i></button>
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

            
            
            <div class="modal fade" id="mcsv" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color: #ff1a1a;color: #ffffff;">
                            <h5 class="modal-title" id="staticBackdropLabel">Reporte de matriculados</h5>
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
                            <button class="btn btn-secondary" type="button" data-dismiss="modal" @click="limpiar()">Cancelar</button>
                            <button class="btn btn-info" @click="reportcsv()">Generar</button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="mvervaucher" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color: #ff1a1a;color: #ffffff;">
                            <h5 class="modal-title" id="staticBackdropLabel">Ver Váucher</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label>Cliente</label>
                                <input type="text" v-model="txtcliente" class="form-control" disabled="true">
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
                    matricula: [],
                    idmat: "",
                    txtcliente: "",
                    vaumat: "",
                    txtfechas: "",
                    txtfecdes: "",
                    vaucher: [],
                },
                mounted: function () {
                    this.getmatricula();
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
                     config: function () {
                        $("#tabdatos").DataTable().destroy();
                        this.tabla();
                    },
                    limpiar: function () {
                        this.txtfechas = "";
                        this.txtfecdes = "";
                    },
                    reportcsv: function () {
                        if (this.txtfecdes != "" && this.txtfechas != "") {
                            window.open('reportematricula/csv?fecdes=' + this.txtfecdes + '&fechas=' + this.txtfechas, ' _blank');
                            $('#mcsv').modal('toggle');
                            this.limpiar();
                        } else {
                            toastr.warning("Seleccione las fechas");
                        }

                    },
                    getmatricula: function () {
                        axios.get('reportematricula/mmatricula').then(response => {
                            this.matricula = response.data;
                            this.config();
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    getvaucher: function (mat) {
                        this.txtcliente = mat.dniper + " - " + mat.apeper + " " + mat.nomper;
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
