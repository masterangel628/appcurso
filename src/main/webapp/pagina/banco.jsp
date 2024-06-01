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
        <title>Banco</title>
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
                                <h1>Gestión de Bancos</h1>
                            </div>
                            <div class="col-sm-6">
                                <ol class="breadcrumb float-sm-right">
                                    <sec:authorize access="hasAuthority('Registrar Banco')">
                                        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#mbanco">
                                            Agregar
                                        </button> 
                                    </sec:authorize>
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
                                    <div class="card-header" style="background-color: #ff1a1a;color: #ffffff;">
                                        <h3 class="card-title">
                                            Lista de Bancos
                                        </h3>
                                    </div>
                                    <div class="card-body">

                                        <div class="table-responsive">
                                            <table class="table table-striped table-bordered table-hover" id="tabdatos">
                                                <thead class="table-success">
                                                    <tr>
                                                        <th>Nombre</th>
                                                        <th>Número</th>
                                                        <th>Estado</th>
                                                        <th>Acción</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr v-for="ban in banco">
                                                        <td>{{ban.nomban}}</td>
                                                        <td>{{ban.nmroban}}</td>
                                                        <td>
                                                            <span class="badge badge-success" v-if="ban.estado=='ACTIVO'">{{ban.estado}}</span>
                                                            <span class="badge badge-warning" v-if="ban.estado=='INACTIVO'">{{ban.estado}}</span>
                                                        </td>
                                                        <td>
                                                            <sec:authorize access="hasAuthority('Editar Banco')">
                                                                <button class="btn btn-info btn-sm" title="Cambiar de estado"  @click="cambiar(ban)"><i class="fas fa-sync-alt"></i></button>
                                                                </sec:authorize>
                                                                <sec:authorize access="hasAuthority('Cambiar estado Banco')">
                                                                <button class="btn btn-primary btn-sm" title="Editar Banco" data-toggle="modal" data-target="#mbancoe" @click="seleccionar(ban)"><i class="fas fa-pencil-alt" aria-hidden="true"></i></button>
                                                                </sec:authorize>
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
            <div class="modal fade" id="mbanco" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color: #ff1a1a;color: #ffffff;">
                            <h5 class="modal-title" id="staticBackdropLabel">Registro de Banco</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close" @click="limpiar()">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label>Nombre</label>
                                <input type="text" id="txtnom" v-model="txtnom" class="form-control" autocomplete="off">
                                <span class="invalid-feedback" role="alert">
                                    <strong>{{msjnom}}</strong>
                                </span>
                            </div>
                            <div class="form-group">
                                <label>Número</label>
                                <input type="text" id="txtnum" v-model="txtnum" class="form-control" autocomplete="off">
                                <span class="invalid-feedback" role="alert">
                                    <strong>{{msjnum}}</strong>
                                </span>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-secondary" type="button" data-dismiss="modal" @click="limpiar()">Cancelar</button>
                            <button class="btn btn-info" type="button" @click="guardar()">Guardar</button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="mbancoe" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color: #ff1a1a;color: #ffffff;">
                            <h5 class="modal-title" id="staticBackdropLabel">Editar Banco</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close" @click="limpiar()">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label>Nombre</label>
                                <input type="text" id="txtnome" v-model="txtnome" class="form-control" autocomplete="off">
                                <span class="invalid-feedback" role="alert">
                                    <strong>{{msjnome}}</strong>
                                </span>
                            </div>
                            <div class="form-group">
                                <label>Número</label>
                                <input type="text" id="txtnume" v-model="txtnume" class="form-control" autocomplete="off">
                                <span class="invalid-feedback" role="alert">
                                    <strong>{{msjnume}}</strong>
                                </span>
                            </div>                            
                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-secondary" type="button" data-dismiss="modal" @click="limpiar()">Cancelar</button>
                            <button class="btn btn-info" type="button" @click="editar()">Guardar</button>
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
                    banco: [],
                    txtnom: "",
                    txtnum: "",

                    msjnom: "",
                    msjnum: "",

                    txtnome: "",
                    txtnume: "",

                    msjnome: "",
                    msjnume: "",

                    idban: "",
                },
                mounted: function () {
                    this.getbanco();
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
                    limpiar: function () {
                        this.txtnom = "";
                        this.txtnum = "";


                        $('#txtnom').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $('#txtnum').removeClass('form-control is-valid is-invalid').addClass('form-control');

                        this.txtnome = "";
                        this.txtnume = "";

                        $('#txtnome').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $('#txtnome').removeClass('form-control is-valid is-invalid').addClass('form-control');
                    },
                    getbanco: function () {
                        axios.get('banco/mbanco').then(response => {
                            this.banco = response.data;
                            this.config();
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    guardar: function () {
                        var data = new FormData();
                        data.append('nom', this.txtnom);
                        data.append('num', this.txtnum);
                        axios.post('banco/guardar', data).then(response => {
                            if (response.data.resp == 'si') {
                                $('#txtnom').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#txtnum').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#mbanco').modal('toggle');
                                this.getbanco();
                                this.limpiar();
                            } else {
                                if (response.data.nom != undefined) {
                                    this.msjnom = response.data.nom;
                                    $('#txtnom').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjnom = '';
                                    $('#txtnom').removeClass('form-control is-invalid').addClass('form-control is-valid');
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
                    editar: function () {
                        var data = new FormData();
                        data.append('nom', this.txtnome);
                        data.append('num', this.txtnume);
                        data.append('idban', this.idban);
                        axios.post('banco/editar', data).then(response => {
                            if (response.data.resp == 'si') {
                                $('#txtnome').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#txtnume').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#mbancoe').modal('toggle');
                                this.getbanco();
                                this.limpiar();
                            } else {
                                if (response.data.nom != undefined) {
                                    this.msjnome = response.data.nom;
                                    $('#txtnome').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjnome = '';
                                    $('#txtnome').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                }
                                if (response.data.num != undefined) {
                                    this.msjnume = response.data.num;
                                    $('#txtnume').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjnume = '';
                                    $('#txtnume').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                }
                            }
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    seleccionar: function (ban) {
                        this.idban = ban.idbanco;
                        this.txtnome = ban.nomban;
                        this.txtnume = ban.nmroban;
                    },
                    cambiar: function (ban) {
                        Swal.fire({
                            title: "Mensaje del Sistema",
                            text: "¿Desea cambiar el estado del banco?",
                            icon: "warning",
                            showCancelButton: true,
                            confirmButtonColor: "#3085d6",
                            cancelButtonColor: "#d33",
                            confirmButtonText: "Si, Cambiar"
                        }).then((result) => {
                            if (result.isConfirmed) {
                                var data = new FormData();
                                data.append('idban', ban.idbanco);
                                data.append('esta', ban.estado);
                                axios.post('banco/cambiarestado', data).then(response => {
                                    this.getbanco();
                                }).catch(function (error) {
                                    console.log(error);
                                });
                            }
                        });
                    },
                },
            });
        </script>
    </body>
</html>
