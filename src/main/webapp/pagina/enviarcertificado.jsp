<%-- 
    Document   : enviarcertificado
    Created on : 28 may 2024, 12:15:07
    Author     : Asus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Certificado</title>
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
                                <h1>Certificado</h1>
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
                                            Lista de matriculas
                                        </h3>
                                    </div>
                                    <div class="card-body">

                                        <div class="table-responsive">
                                            <table class="table table-striped table-bordered table-hover" id="tabdatos">
                                                <thead class="table-success">
                                                    <tr>
                                                        <th>Número</th>
                                                        <th>Cliente</th>
                                                        <th>Monto</th>
                                                        <th>Grupo</th>
                                                        <th>Fecha</th>
                                                        <th>Acción</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr v-for="mat in matricula">
                                                        <td width="15%">{{mat.nummat}}</td>
                                                        <td>{{mat.dniper}} - {{mat.apeper}} {{mat.nomper}}</td>
                                                        <td width="15%">{{mat.montomat}}</td> 
                                                        <td width="15%">{{mat.grupomat}}</td>
                                                        <td width="15%">{{mat.fecmat}}</td>
                                                        <td width="5%">
                                                            <button v-if="mat.verexiste=='existe'" title="Ver detalle" data-toggle="modal" @click="getdetalle(mat)" data-target="#mdetalle" class="btn btn-info btn-sm"><i class="fa fa-eye"></i></button>
                                                            <button v-if="mat.verexiste=='noexiste'" title="Registrar envio" data-toggle="modal" data-target="#menviarcert" @click="seleccionar(mat)" class="btn btn-info btn-sm"><i class="fas fa-plus"></i></button>
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
                            <h5 class="modal-title" id="staticBackdropLabel">Ver envio</h5>
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
                                <label>Información</label>
                                <textarea v-model="txtinfo" class="form-control" rows="5" disabled="true"></textarea>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal fade" id="menviarcert" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color: #ff1a1a;color: #ffffff;">
                            <h5 class="modal-title" id="staticBackdropLabel">Registrar envio</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close" @click="limpiar()">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label>Cliente</label>
                                <input type="text" v-model="txtcliente" class="form-control" disabled="true">
                            </div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>Código</label>
                                        <input type="text" id="txtcod" v-model="txtcod" class="form-control" autocomplete="off">
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{msjcod}}</strong>
                                        </span>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>Número</label>
                                        <input type="text" id="txtnum" v-model="txtnum" class="form-control" autocomplete="off">
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{msjnum}}</strong>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>Monto</label>
                                        <input type="text" id="txtmon" v-model="txtmon" class="form-control" autocomplete="off">
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{msjmon}}</strong>
                                        </span>
                                    </div>
                                </div>
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label>Fecha</label>
                                        <input type="date" id="txtfec" v-model="txtfec" class="form-control" autocomplete="off">
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{msjfec}}</strong>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="card-footer">
                            <button class="btn btn-secondary" type="button" data-dismiss="modal" @click="limpiar()">
                                Cancelar
                            </button>
                            <button class="btn btn-info" type="button" @click="guardar()">
                                Guardar
                            </button>
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

                    txtcod: "",
                    txtnum: "",
                    txtfec: "",
                    txtmon: "",

                    msjcod: "",
                    msjnum: "",
                    msjfec: "",
                    msjmon: "",

                    txtinfo: "",

                    numenvcert: "",
                    fecenvcert: "",
                    codenvcert: "",
                    montoenvcert: "",

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
                    seleccionar: function (mat) {
                        this.txtcliente = mat.dniper + " - " + mat.apeper + " " + mat.nomper;
                        this.idmat = mat.idmatricula;
                    },
                    getdetalle: function (mat) {
                        this.txtcliente = mat.dniper + " - " + mat.apeper + " " + mat.nomper;
                        this.idmat = mat.idmatricula;
                        axios.get('certificado/detalle?mat=' + this.idmat).then(response => {
                            this.txtinfo = "Número: " + response.data.numenvcert + "\nCódigo: " + response.data.codenvcert +
                                    "\nFecha: " + response.data.fecenvcert + "\nMonto: " + response.data.montoenvcert;
                        }).catch(function (error) {
                            console.log(error);
                        });

                    },
                    limpiar: function () {
                        this.txtcod = "";
                        this.txtnum = "";
                        this.txtmon = "";
                        this.txtfec = "";

                        this.txtcliente = "";
                        this.idmat = "";

                        $('#txtcod').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $('#txtnum').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $('#txtmon').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $('#txthora').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $('#txtfec').removeClass('form-control is-valid is-invalid').addClass('form-control');
                    },
                    getmatricula: function () {
                        axios.get('certificado/mmatricula').then(response => {
                            this.matricula = response.data;
                            this.config();
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    guardar: function () {
                        var data = new FormData();
                        data.append('fec', this.txtfec);
                        data.append('idmat', this.idmat);
                        data.append('mon', this.txtmon);
                        data.append('cod', this.txtcod);
                        data.append('num', this.txtnum);
                        axios.post('certificado/enviarcert', data).then(response => {
                            if (response.data.resp == 'si') {
                                $('#txtfec').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#txtmon').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#txtcod').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#txtnum').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#menviarcert').modal('toggle');
                                this.getmatricula();
                                this.limpiar();
                            } else {
                                if (response.data.fec != undefined) {
                                    this.msjfec = response.data.fec;
                                    $('#txtfec').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjfec = '';
                                    $('#txtfec').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                }
                                if (response.data.mon != undefined) {
                                    this.msjmon = response.data.mon;
                                    $('#txtmon').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjmon = '';
                                    $('#txtmon').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                }
                                if (response.data.cod != undefined) {
                                    this.msjcod = response.data.cod;
                                    $('#txtcod').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjcod = '';
                                    $('#txtcod').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                }
                                if (response.data.num != undefined) {
                                    this.msjnum = response.data.num;
                                    $('#txtnum').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjnum = '';
                                    $('#txtnum').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                }
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
