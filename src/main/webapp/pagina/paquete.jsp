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
        <title>Paquete</title>
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
                                <h1>Gestión de Paquetes</h1>
                            </div>
                            <div class="col-sm-6">
                                <ol class="breadcrumb float-sm-right">
                                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#mpaquete">
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
                                            Lista de Paquetes
                                        </h3>
                                    </div>
                                    <div class="card-body">

                                        <div class="table-responsive">
                                            <table class="table table-striped table-bordered table-hover">
                                                <thead class="table-success">
                                                    <tr>
                                                        <th>Nombre</th>
                                                        <th>Estado</th>
                                                        <th>Acción</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr v-for="paq ,key in paquete">
                                                        <td>{{paq.nompaq}}</td>
                                                        <td>
                                                            <span class="badge badge-success" v-if="paq.estado=='ACTIVO'">{{paq.estado}}</span>
                                                            <span class="badge badge-warning" v-if="paq.estado=='INACTIVO'">{{paq.estado}}</span>
                                                        </td>
                                                        <td>
                                                            <button title="Ver detalle" data-toggle="modal" data-target="#mdetver" @click="getcursopaq(paq)" class="btn btn-info btn-sm"><i class="fa fa-eye"></i></button>
                                                            <button title="Agregar detalle" @click="seleccionar(paq)" data-toggle="modal" data-target="#mdetagregar" class="btn btn-primary btn-sm"><i class="fa fa-plus"></i></button>
                                                            <button title="Editar paquete" data-toggle="modal" data-target="#mpaquetee"
                                                                    @click="seleccionar(paq)" class="btn btn-warning btn-sm"><i class="fas fa-pencil-alt" aria-hidden="true"></i></button>
                                                            <button title="Cambiar de Estado" @click="cambiar(paq)" class="btn btn-danger btn-sm"><i class="fas fa-sync-alt"></i></button>
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
            <div class="modal fade" id="mdetver" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color: #ff1a1a;color: #ffffff;">
                            <h5 class="modal-title" id="staticBackdropLabel">Paquete: {{paq}}</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close" @click="limpiar()">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover">
                                    <thead class="table-success">
                                        <tr>
                                            <th>Curso</th>
                                            <th>Precio</th>
                                            <th>Duración</th>
                                            <th>Horas académicas</th>
                                            <th>Estado</th>
                                            <th>Acción</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr v-for="cp ,key in curpaq">
                                            <td>{{cp[10]}}</td>
                                            <td>{{cp[3]}}</td>
                                            <td>{{cp[8]}}</td>
                                            <td>{{cp[9]}}</td>
                                            <td>
                                                <span class="badge badge-success" v-if="cp[11]=='ACTIVO'">{{cp[11]}}</span>
                                                <span class="badge badge-warning" v-if="cp[11]=='INACTIVO'">{{cp[11]}}</span>
                                            </td>
                                            <td>
                                                <button title="Eliminar"  @click="eliminar(cp)" class="btn btn-info btn-sm"><i class="fa fa-eye"></i></button>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal fade" id="mdetagregar" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color: #ff1a1a;color: #ffffff;">
                            <h5 class="modal-title" id="staticBackdropLabel">Agregar curso</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close" @click="limpiar()">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label>Paquete</label>
                                <input type="text" v-model="paq" class="form-control" autocomplete="off" readonly="true">
                            </div>
                            <div class="form-group">
                                <label>Curso</label>
                                <select v-model="cbocur" id="cbocur" class="form-control">
                                    <option value="0">Seleccione</option>
                                    <option v-for="cur in curso" v-bind:value="cur[1]">{{cur[6]}}</option>
                                </select>
                                <span class="invalid-feedback" role="alert">
                                    <strong>{{msjcur}}</strong>
                                </span>
                            </div>
                            <div class="form-group">
                                <label>Precio</label>
                                <input type="text" id="txtprec" v-model="txtprec" class="form-control" autocomplete="off">
                                <span class="invalid-feedback" role="alert">
                                    <strong>{{msjprec}}</strong>
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
            <div class="modal fade" id="mpaquete" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color: #ff1a1a;color: #ffffff;">
                            <h5 class="modal-title" id="staticBackdropLabel">Registro de Paquete</h5>
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
                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-secondary" type="button" data-dismiss="modal" @click="limpiar()">Cancelar</button>
                            <button class="btn btn-info" type="button" @click="guardar()">Guardar</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal fade" id="mpaquetee" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color: #ff1a1a;color: #ffffff;">
                            <h5 class="modal-title" id="staticBackdropLabel">Editar Paquete</h5>
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
                    paquete: [],
                    curso: [],
                    curpaq:[],
                    txtnom: "",
                    msjnom: "",
                    txtnome: "",
                    msjnome: "",
                    idpaq: "",
                    paq: "",

                    txtprec: "",
                    msjcur: "",
                    msjprec: "",
                    cbocur: 0,
                },
                mounted: function () {
                    this.getpaquete();
                    this.getcurso();
                },
                methods: {
                    limpiar: function () {
                        this.txtnom = "";
                        $('#txtnom').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        this.txtnome = "";
                        $('#txtnome').removeClass('form-control is-valid is-invalid').addClass('form-control');
                    },
                    getpaquete: function () {
                        axios.get('paquete/mpaquete').then(response => {
                            this.paquete = response.data;
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    guardar: function () {
                        var data = new FormData();
                        data.append('nom', this.txtnom);
                        axios.post('paquete/guardar', data).then(response => {
                            if (response.data.resp == 'si') {
                                $('#txtnom').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#mpaquete').modal('toggle');
                                this.getpaquete();
                                this.limpiar();
                            } else {
                                if (response.data.nom != undefined) {
                                    this.msjnom = response.data.nom;
                                    $('#txtnom').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjnom = '';
                                    $('#txtnom').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                }
                            }
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    editar: function () {
                        var data = new FormData();
                        data.append('nom', this.txtnome);
                        data.append('id', this.idpaq);
                        axios.post('paquete/editar', data).then(response => {
                            if (response.data.resp == 'si') {
                                $('#txtnome').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#mpaquetee').modal('toggle');
                                this.getpaquete();
                                this.limpiar();
                            } else {
                                if (response.data.nom != undefined) {
                                    this.msjnome = response.data.nom;
                                    $('#txtnome').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjnome = '';
                                    $('#txtnome').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                }
                            }
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    seleccionar: function (paq) {
                        this.idpaq = paq.idpaquete;
                        this.txtnome = paq.nompaq;
                        this.paq = paq.nompaq;
                    },
                    cambiar: function (paq) {
                        Swal.fire({
                            title: "Mensaje del Sistema",
                            text: "¿Desea cambiar el estado del paquete?",
                            icon: "warning",
                            showCancelButton: true,
                            confirmButtonColor: "#3085d6",
                            cancelButtonColor: "#d33",
                            confirmButtonText: "Si, Cambiar"
                        }).then((result) => {
                            if (result.isConfirmed) {
                                var data = new FormData();
                                data.append('idpaq', paq.idpaquete);
                                data.append('esta', paq.estado);
                                axios.post('paquete/cambiarestado', data).then(response => {
                                    this.getpaquete();
                                }).catch(function (error) {
                                    console.log(error);
                                });
                            }
                        });
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
                        data.append('cur', this.cbocur);
                        data.append('paq', this.idpaq);
                        data.append('prec', this.txtprec);
                        axios.post('paquete/guardardetalle', data).then(response => {
                            if (response.data.resp == 'si') {
                                $('#txtprec').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#cbocur').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#mdetagregar').modal('toggle');
                                this.limpiardetalle();
                            } else {
                                if (response.data.cur != undefined) {
                                    this.msjcur = response.data.cur;
                                    $('#cbocur').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjcur = '';
                                    $('#cbocur').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                }
                                if (response.data.prec != undefined) {
                                    this.msjprec = response.data.prec;
                                    $('#txtprec').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjprec = '';
                                    $('#txtprec').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                }
                            }
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    getcurso: function () {
                        axios.get('paquete/mcurso').then(response => {
                            this.curso = response.data;
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    
                    getcursopaq: function (paq) {
                        this.paq=paq.nompaq;
                        axios.get('paquete/mcursopaquete?cur='+paq.idpaquete).then(response => {
                            this.curpaq = response.data;
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    
                      eliminar: function (curp) {
                        var data = new FormData();
                        data.append('cur', curp[2]);
                        axios.post('paquete/eliminarcursopaq', data).then(response => {
                             $('#mdetver').modal('toggle');
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                },
            });
        </script>
    </body>
</html>
