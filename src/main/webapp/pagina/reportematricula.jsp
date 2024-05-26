<%-- 
    Document   : menu
    Created on : 28 sept. 2022, 10:18:15
    Author     : Asus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
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
                            <div class="col-sm-6">
                                <ol class="breadcrumb float-sm-right">
                                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#mreporte">
                                        Reporte
                                    </button> 
                                </ol>
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
                                    </div>
                                    <div class="card-body">

                                        <div class="table-responsive">
                                            <table class="table table-striped table-bordered table-hover">
                                                <thead class="table-success">
                                                    <tr>
                                                        <th>Número</th>
                                                        <th>Cliente</th>
                                                        <th>Grupo</th>
                                                        <th>Fecha</th>
                                                        <th>Acción</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr v-for="mat in matricula">
                                                        <td>{{mat.nummat}}</td>
                                                        <td>{{mat.dniper}} - {{mat.apeper}} {{mat.nomper}}</td>
                                                        <td>{{mat.grupomat}}</td>
                                                        <td>{{mat.fecmat}}</td>
                                                        <td>
                                                            <button title="Ver Váucher" data-toggle="modal" @click="getvau(mat)" data-target="#mvervaucher" class="btn btn-info btn-sm"><i class="fa fa-eye"></i></button>
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

            <div class="modal fade" id="mreporte" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color: #ff1a1a;color: #ffffff;">
                            <h5 class="modal-title" id="staticBackdropLabel">Reporte</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close" @click="limpiar()">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <label>Desde</label>
                                    <input type="date" v-model="txtfecdes" id="txtfecdes" autocomplete="off" class="form-control">
                                </div>
                                <div class="col-md-6">
                                    <label>Hasta</label>
                                    <input type="date" v-model="txtfechas"id="txtfechas" autocomplete="off" class="form-control">
                                </div>
                            </div>
                        </div>
                        <div class="card-footer">
                            <button class="btn btn-primary" @click="reportexcel()">Excel</button>
                            <button class="btn btn-info" @click="reportpdf()">PDF</button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="mvervaucher" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color: #ff1a1a;color: #ffffff;">
                            <h5 class="modal-title" id="staticBackdropLabel">Ver Váucher</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close" @click="limpiar()">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label>Cliente</label>
                                <input type="text" v-model="txtcliente" class="form-control" disabled="true">
                            </div>
                            <div class="table-responsive">
                                <img v-bind:src="this.vaumat" alt="alt"/>
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
                },
                mounted: function () {
                    this.getmatricula();
                },
                methods: {
                    reportexcel: function () {
                        if (this.txtfecdes != "" && this.txtfechas != "") {
                            window.open('reportematricula/excel?fecdes=' + this.txtfecdes + '&fechas=' + this.txtfechas, ' _blank');
                            $('#mreporte').modal('toggle');
                        } else {
                            toastr.warning("Seleccione las fechas");
                        }

                    },
                    reportpdf: function () {

                        if (this.txtfecdes != "" && this.txtfechas != "") {
                            window.open('reportematricula/pdf?fecdes=' + this.txtfecdes + '&fechas=' + this.txtfechas, ' _blank');
                            $('#mreporte').modal('toggle');
                        } else {
                            toastr.warning("Seleccione las fechas");
                        }
                    },
                    getmatricula: function () {
                        axios.get('reportematricula/mmatricula').then(response => {
                            this.matricula = response.data;
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    getvau: function (mat) {
                        this.vaumat = "reportematricula/images/" + mat.vaumat;
                        this.txtcliente = mat.dniper + " - " + mat.apeper + " " + mat.nomper;
                    },
                },
            });
        </script>
    </body>
</html>
