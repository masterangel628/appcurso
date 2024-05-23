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
        <title>Docente</title>
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
                                <h1>Gestión de Docentes</h1>
                            </div>
                            <div class="col-sm-6">
                                <ol class="breadcrumb float-sm-right">
                                    <sec:authorize access="hasAuthority('Registrar Docente')">
                                        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#mdocente">
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
                                            Lista de Docentes
                                        </h3>
                                    </div>
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <table class="table table-striped table-bordered table-hover">
                                                <thead class="table-success">
                                                    <tr>
                                                        <th>DNI</th>
                                                        <th>Nombre</th>
                                                        <th>Celular</th>
                                                        <th>Dirección</th>
                                                        <th>Correo</th>
                                                        <th>Estado</th>
                                                        <th>Acción</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr v-for="doc in docente">
                                                        <td>{{doc.persona.dniper}}</td>
                                                        <td>{{doc.persona.nomper}} {{doc.persona.apeper}}</td>
                                                        <td>{{doc.persona.celper}}</td>
                                                        <td>{{doc.persona.dirper}}</td>
                                                        <td>{{doc.persona.correoper}}</td>
                                                        <td>
                                                            <span class="badge badge-success" v-if="doc.estado=='ACTIVO'">{{doc.estado}}</span>
                                                            <span class="badge badge-warning" v-if="doc.estado=='INACTIVO'">{{doc.estado}}</span>
                                                        </td>
                                                        <td>
                                                            <sec:authorize access="hasAuthority('Registrar Docente')">
                                                                <button class="btn btn-info btn-sm" title="Cambiar de estado"  @click="cambiar(doc)">
                                                                    <i class="fas fa-sync-alt"></i>
                                                                </button>
                                                            </sec:authorize>
                                                            <sec:authorize access="hasAuthority('Registrar Docente')">
                                                                <button class="btn btn-primary btn-sm" title="Editar Docente" data-toggle="modal" data-target="#mdocentee" @click="seleccionar(doc)">
                                                                    <i class="fas fa-pencil-alt" aria-hidden="true"></i>
                                                                </button>
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
            <div class="modal fade" id="mdocente" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color: #ff1a1a;color: #ffffff;">
                            <h5 class="modal-title" id="staticBackdropLabel">Registro de Docente</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close" @click="limpiar()">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>DNI</label>
                                        <input type="text" id="txtdni" @keyup="completar()" maxlength="8" v-model="txtdni" class="form-control" autocomplete="off">
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{msjdni}}</strong>
                                        </span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Apellido</label>
                                        <input type="text" id="txtape" v-model="txtape" class="form-control" autocomplete="off">
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{msjape}}</strong>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Nombre</label>
                                        <input type="text" id="txtnom" v-model="txtnom" class="form-control" autocomplete="off">
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{msjnom}}</strong>
                                        </span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Celular</label>
                                        <input type="text" id="txtcel" v-model="txtcel" class="form-control" autocomplete="off">
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{msjcel}}</strong>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Correo</label>
                                <input type="text" id="txtcor" v-model="txtcor" class="form-control" autocomplete="off">
                                <span class="invalid-feedback" role="alert">
                                    <strong>{{msjcor}}</strong>
                                </span>
                            </div>
                            <div class="form-group">
                                <label>Dirección</label>
                                <textarea v-model="txtdir" id="txtdir" class="form-control"></textarea>
                                <span class="invalid-feedback" role="alert">
                                    <strong>{{msjdir}}</strong>
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

            <div class="modal fade" id="mdocentee" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color: #ff1a1a;color: #ffffff;">
                            <h5 class="modal-title" id="staticBackdropLabel">Editar Docente</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close" @click="limpiar()">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>DNI</label>
                                        <input type="text" id="txtdnie"  v-model="txtdnie" class="form-control" autocomplete="off">
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{msjdnie}}</strong>
                                        </span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Apellido</label>
                                        <input type="text" id="txtapee" v-model="txtapee" class="form-control" autocomplete="off">
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{msjapee}}</strong>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Nombre</label>
                                        <input type="text" id="txtnome" v-model="txtnome" class="form-control" autocomplete="off">
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{msjnome}}</strong>
                                        </span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Celular</label>
                                        <input type="text" id="txtcele" v-model="txtcele" class="form-control" autocomplete="off">
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{msjcele}}</strong>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Correo</label>
                                <input type="text" id="txtcore" v-model="txtcore" class="form-control" autocomplete="off">
                                <span class="invalid-feedback" role="alert">
                                    <strong>{{msjcore}}</strong>
                                </span>
                            </div>
                            <div class="form-group">
                                <label>Dirección</label>
                                <textarea v-model="txtdire" id="txtdire" class="form-control"></textarea>
                                <span class="invalid-feedback" role="alert">
                                    <strong>{{msjdire}}</strong>
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
                    docente: [],

                    txtdni: "",
                    txtape: "",
                    txtnom: "",
                    txtcel: "",
                    txtdir: "",
                    txtcor: "",

                    msjdni: "",
                    msjape: "",
                    msjnom: "",
                    msjcel: "",
                    msjdir: "",
                    msjcor: "",

                    txtdnie: "",
                    txtapee: "",
                    txtnome: "",
                    txtcele: "",
                    txtdire: "",
                    txtcore: "",

                    msjdnie: "",
                    msjapee: "",
                    msjnome: "",
                    msjcele: "",
                    msjdire: "",
                    msjcore: "",

                    idper: "",
                },
                mounted: function () {
                    this.getdocente();
                },
                
                methods: {
                    completar: function () {
                        if (this.txtdni.length == 8) {
                            axios.get('persona/consulta/' + this.txtdni).then(response => {
                                if(response.data.msj=="bd"){
                                    this.txtape = response.data.persona.apeper;
                                    this.txtnom = response.data.persona.nomper;
                                    this.txtdir = response.data.persona.dirper;
                                    this.txtcel = response.data.persona.celper;
                                    this.txtcor = response.data.persona.correoper;
                                }
                                 if(response.data.msj=="api"){
                                     var p = JSON.parse(response.data.persona);
                                    this.txtape = p.data.apellido_paterno+" "+p.data.apellido_materno;
                                    this.txtnom = p.data.nombres;
                                    this.txtdir = p.data.direccion;
                                }
                            }).catch(function (error) {
                                console.log(error);
                            });
                        } else {
                            this.txtape ="";
                            this.txtnom = "";
                            this.txtdir ="";
                        }
                    },
                    limpiar: function () {
                        this.txtdni = "";
                        this.txtape = "";
                        this.txtnom = "";
                        this.txtcel = "";
                        this.txtdir = "";
                        this.txtcor = "";

                        $('#txtdni').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $('#txtape').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $('#txtnom').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $('#txtcel').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $('#txtdir').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $('#txtcor').removeClass('form-control is-valid is-invalid').addClass('form-control');

                        this.msjdni = "";
                        this.msjape = "";
                        this.msjnom = "";
                        this.msjcel = "";
                        this.msjdir = "";
                        this.msjcor = "";

                        this.txtdnie = "";
                        this.txtapee = "";
                        this.txtnome = "";
                        this.txtcele = "";
                        this.txtdire = "";
                        this.txtcore = "";

                        $('#txtdnie').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $('#txtapee').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $('#txtnome').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $('#txtcele').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $('#txtdire').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $('#txtcore').removeClass('form-control is-valid is-invalid').addClass('form-control');

                        this.msjdnie = "";
                        this.msjapee = "";
                        this.msjnome = "";
                        this.msjcele = "";
                        this.msjdire = "";
                        this.msjcore = "";
                    },
                    getdocente: function () {
                        axios.get('docente/mdocente').then(response => {
                            this.docente = response.data;
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    guardar: function () {
                        var data = new FormData();
                        data.append('dni', this.txtdni);
                        data.append('ape', this.txtape);
                        data.append('nom', this.txtnom);
                        data.append('cel', this.txtcel);
                        data.append('dir', this.txtdir);
                        data.append('cor', this.txtcor);
                        axios.post('docente/guardar', data).then(response => {
                            if (response.data.resp == 'si') {
                                $('#txtdni').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#txtape').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#txtnom').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#txtcel').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#txtdir').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#txtcor').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#mdocente').modal('toggle');
                                this.getdocente();
                                this.limpiar();
                            } else {
                                if (response.data.dni != undefined) {
                                    this.msjdni = response.data.dni;
                                    $('#txtdni').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjdni = '';
                                    $('#txtdni').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                }
                                if (response.data.ape != undefined) {
                                    this.msjape = response.data.ape;
                                    $('#txtape').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjape = '';
                                    $('#txtape').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                }
                                if (response.data.nom != undefined) {
                                    this.msjnom = response.data.nom;
                                    $('#txtnom').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjnom = '';
                                    $('#txtnom').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                }
                                if (response.data.dir != undefined) {
                                    this.msjdir = response.data.dir;
                                    $('#txtdir').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjdir = '';
                                    $('#txtdir').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                }
                                if (response.data.cor != undefined) {
                                    this.msjcor = response.data.cor;
                                    $('#txtcor').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjcor = '';
                                    $('#txtcor').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                }
                                if (response.data.cel != undefined) {
                                    this.msjcel = response.data.cel;
                                    $('#txtcel').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjcel = '';
                                    $('#txtcel').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                }
                            }


                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    editar: function () {
                        var data = new FormData();
                        data.append('dni', this.txtdnie);
                        data.append('ape', this.txtapee);
                        data.append('nom', this.txtnome);
                        data.append('cel', this.txtcele);
                        data.append('dir', this.txtdire);
                        data.append('cor', this.txtcore);
                        data.append('idper', this.idper);
                        axios.post('docente/editar', data).then(response => {
                            if (response.data.resp == 'si') {
                                $('#txtdnie').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#txtapee').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#txtnome').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#txtcele').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#txtdire').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#txtcore').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#mdocentee').modal('toggle');
                                this.getdocente();
                                this.limpiar();
                            } else {
                                if (response.data.dni != undefined) {
                                    this.msjdnie = response.data.dni;
                                    $('#txtdnie').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjdnie = '';
                                    $('#txtdnie').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                }
                                if (response.data.ape != undefined) {
                                    this.msjapee = response.data.ape;
                                    $('#txtapee').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjapee = '';
                                    $('#txtapee').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                }
                                if (response.data.nom != undefined) {
                                    this.msjnome = response.data.nom;
                                    $('#txtnome').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjnome = '';
                                    $('#txtnome').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                }
                                if (response.data.dir != undefined) {
                                    this.msjdire = response.data.dir;
                                    $('#txtdire').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjdire = '';
                                    $('#txtdire').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                }
                                if (response.data.cor != undefined) {
                                    this.msjcore = response.data.cor;
                                    $('#txtcore').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjcore = '';
                                    $('#txtcore').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                }
                                if (response.data.cel != undefined) {
                                    this.msjcele = response.data.cel;
                                    $('#txtcele').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjcele = '';
                                    $('#txtcele').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                }
                            }

                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    seleccionar: function (doc) {
                        this.txtdnie = doc.persona.dniper;
                        this.txtapee = doc.persona.apeper;
                        this.txtnome = doc.persona.nomper;
                        this.txtcele = doc.persona.celper;
                        this.txtdire = doc.persona.dirper;
                        this.txtcore = doc.persona.correoper;
                        this.idper = doc.persona.idpersona;
                    },
                    cambiar: function (doc) {
                        Swal.fire({
                            title: "Mensaje del Sistema",
                            text: "¿Desea cambiar el estado del docente?",
                            icon: "warning",
                            showCancelButton: true,
                            confirmButtonColor: "#3085d6",
                            cancelButtonColor: "#d33",
                            confirmButtonText: "Si, Cambiar"
                        }).then((result) => {
                            if (result.isConfirmed) {
                                var data = new FormData();
                                data.append('iddoc', doc.iddocente);
                                data.append('esta', doc.estado);
                                axios.post('docente/cambiarestado', data).then(response => {
                                    this.getdocente();
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
