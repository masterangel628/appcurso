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
                                            Lista de matriculas por verificar
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
                                                            <button v-if="mat.band==1" title="Ver Váucher" data-toggle="modal" @click="getvau(mat)" data-target="#mvervaucher" class="btn btn-info btn-sm"><i class="fa fa-eye"></i></button>
                                                            <button v-if="mat.band==0" title="Agregar Váucher" @click="seleccionar(mat)" data-toggle="modal" data-target="#mmatricula" class="btn btn-primary btn-sm"><i class="fa fa-plus"></i></button>
                                                            <button v-if="mat.band==1" title="Verificar Váucher" @click="verificar(mat)" class="btn btn-success btn-sm"><i class="fas fa-check"></i></button>
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

            <div class="modal fade" id="mmatricula" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color: #ff1a1a;color: #ffffff;">
                            <h5 class="modal-title" id="staticBackdropLabel">Subir Váucher</h5>
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
                    archivo: null,
                    banco: [],
                    cboban: 0,
                    matricula: [],
                    idmat: "",
                    txtcliente: "",
                    vaumat: "",
                    msjvau: "",
                    msjban: "",
                },
                mounted: function () {
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
                        if (this.archivo == null) {
                            toastr.warning("Seleccione una imagen");
                        } else {
                            var data = new FormData();
                            data.append('vau', this.archivo);
                            data.append('mat', this.idmat);
                            data.append('ban', this.cboban);
                            axios.post('matricula/guardar', data).then(response => {
                                if (response.data.resp == 'si') {
                                    $('#txtvau').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                    $('#cboban').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                    this.getmatricula();
                                    this.limpiar();
                                    $('#mmatricula').modal('toggle');
                                } else {
                                    if (response.data.vau != undefined) {
                                        this.msjvau = response.data.vau;
                                        $('#txtvau').removeClass('form-control').addClass('form-control is-invalid');
                                    } else {
                                        this.msjvau = '';
                                        $('#txtvau').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                    }
                                    if (response.data.ban != undefined) {
                                        this.msjban = response.data.ban;
                                        $('#cboban').removeClass('form-control').addClass('form-control is-invalid');
                                    } else {
                                        this.msjban = '';
                                        $('#cboban').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                    }
                                }
                            }).catch(function (error) {
                                console.log(error);
                            });
                        }
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
                           this.msjvau = '';
                           this.msjban = '';
                        $('#cboban').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $('#txtvau').removeClass('form-control is-valid is-invalid').addClass('form-control');
                         this.idmat='';
                    },
                    verificar: function (mat) {
                        var data = new FormData();
                        data.append('mat', mat.idmatricula);
                        axios.post('matricula/verificar', data).then(response => {
                            this.getmatricula();
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    getvau: function (mat) {
                        this.vaumat = "matricula/images/" + mat.vaumat;
                        this.txtcliente = mat.dniper + " - " + mat.apeper + " " + mat.nomper;
                    },
                    seleccionar: function (mat) {
                        this.idmat = mat.idmatricula;
                        this.txtcliente = mat.dniper + " - " + mat.apeper + " " + mat.nomper;
                    },
                },
            });
        </script>
    </body>
</html>
