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
        <title>Matricula</title>
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
                                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#mmatricula">
                                        Agregar
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
                                            Lista de Matriculas
                                        </h3>
                                    </div>
                                    <div class="card-body">

                                        <div class="table-responsive">
                                            <table class="table table-striped table-bordered table-hover">
                                                <thead class="table-success">
                                                    <tr>
                                                        <th>Cliente</th>
                                                        <th>Banco</th>
                                                        <th>Fecha</th>
                                                        <th>Váucher</th>
                                                        <th>Acción</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr v-for="mat in matricula">
                                                        <td>{{mat.apeper}} {{mat.nomper}} - {{mat.dniper}}</td>
                                                        <td>{{mat.nomban}}</td>
                                                        <td>{{mat.fecmat}}</td>
                                                        <td>
                                                            <img v-bind:src="'images/'+mat.vaumat" alt="alt"/>
                                                        </td>
                                                        <td>
                                                            <button title="Ver Váucher"  class="btn btn-info btn-sm"><i class="fa fa-eye"></i></button>
                                                            <button title="Agregar Paquete" @click="seleccionar(mat)" data-toggle="modal" data-target="#mdetagregar" class="btn btn-primary btn-sm"><i class="fa fa-plus"></i></button>
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

            <div class="modal fade" id="mdetagregar" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color: #ff1a1a;color: #ffffff;">
                            <h5 class="modal-title" id="staticBackdropLabel">Agregar Paquete</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close" @click="limpiar()">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label>Paquete</label>
                                <select v-model="cbopaq" id="cbopaq" class="form-control" @change="getcurso()">
                                    <option value="0">Seleccione</option>
                                    <option v-for="paq in paquete" v-bind:value="paq.idpaquete">{{paq.nompaq}}</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Curso</label>
                                <select v-model="cbocur" id="cbocur" class="form-control">
                                    <option value="0">Seleccione</option>
                                    <option v-for="cur in curso" v-bind:value="cur.idcurso">{{cur.nomcur}}</option>
                                </select>
                                <span class="invalid-feedback" role="alert">
                                    <strong>{{msjcur}}</strong>
                                </span>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-secondary" type="button" data-dismiss="modal" @click="limpiardetalle()">Cancelar</button>
                            <button class="btn btn-info" type="button" @click="guardardetalle()">Guardar</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal fade" id="mmatricula" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color: #ff1a1a;color: #ffffff;">
                            <h5 class="modal-title" id="staticBackdropLabel">Registro de Matricula</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close" @click="limpiar()">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label>Cliente</label>
                                <select v-model="cbocli" id="cbocli" class="form-control">
                                    <option value="0">Seleccione</option>
                                    <option v-for="cli in cliente" v-bind:value="cli.idcliente">{{cli.persona.nomper}} {{cli.persona.apeper}} - {{cli.persona.dniper}}</option>
                                </select>
                                <span class="invalid-feedback" role="alert">
                                    <strong>{{msjcli}}</strong>
                                </span>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Banco</label>
                                        <select v-model="cboban" id="cboban" class="form-control">
                                            <option value="0">Seleccione</option>
                                            <option v-for="ban in banco" v-bind:value="ban.idbanco">{{ban.nomban}}</option>
                                        </select>
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{msjban}}</strong>
                                        </span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Váucher</label>
                                        <input type="file" id="txtvau" @change="getArchivo" accept=".png,.jpg,.jpeg" class="form-control" autocomplete="off">
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{msjvau}}</strong>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-secondary" type="button" data-dismiss="modal" @click="limpiar()">Cancelar</button>
                            <button class="btn btn-info" type="button" @click="guardar()">Guardar</button>
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

                    cliente: [],
                    archivo: null,
                    banco: [],
                    cbocli: 0,
                    cboban: 0,
                    txtvau: "",
                    msjcli: "",
                    msjban: "",
                    msjvau: "",
                    matricula: [],
                    paquete: [],
                    cbopaq: 0,

                    curso: [],
                    curpaq: [],

                    idpaq: "",
                    idmat: "",
                    msjcur: "",
                    cbocur: 0,
                },
                mounted: function () {
                    this.getpaquete();
                    this.getcurso();

                    this.getcliente();
                    this.getbanco();
                    this.getmatricula();
                },
                methods: {
                    getArchivo(event) {
                        if (!event.target.files.length) {
                            this.archivo = null;
                        } else {
                            this.archivo = event.target.files[0];
                        }
                    },
                    guardar: function () {
                        var data = new FormData();
                        data.append('vau', this.archivo);
                        data.append('cli', this.cbocli);
                        data.append('ban', this.cboban);
                        axios.post('matricula/guardar', data).then(response => {
                            this.getmatricula();
                            $('#mmatricula').modal('toggle');
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    getcliente: function () {
                        axios.get('matricula/mcliente').then(response => {
                            this.cliente = response.data;
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    getbanco: function () {
                        axios.get('matricula/mbanco').then(response => {
                            this.banco = response.data;
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    getmatricula: function () {
                        axios.get('matricula/mmatricula').then(response => {
                            this.matricula = response.data;
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    limpiar: function () {
                        this.txtnome = "";
                        $('#txtnome').removeClass('form-control is-valid is-invalid').addClass('form-control');
                    },
                    getpaquete: function () {
                        axios.get('matricula/mpaquete').then(response => {
                            this.paquete = response.data;
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },

                    seleccionar: function (mat) {
                        this.idmat = mat.idmatricula;
                    },
                    limpiardetalle: function () {
                        this.paq = "";
                        this.txtprec = "";
                        this.msjprec = "";
                        $('#txtprec').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        this.cbocur = 0;
                        this.msjcur = "";
                        $('#cbocur').removeClass('form-control is-valid is-invalid').addClass('form-control');
                    },
                    guardardetalle: function () {
                        var data = new FormData();
                        data.append('paq', this.cbopaq);
                        data.append('mat', this.idmat);
                        axios.post('matricula/guardardetmat', data).then(response => {

                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    getcurso: function () {
                        axios.get('matricula/mdetpaquete?paq=' + this.cbopaq).then(response => {
                            this.curso = response.data;
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },

                },
            });
        </script>
    </body>
</html>
