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
        <title>Curso</title>
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
                                <h1>Gestión de Cursos</h1>
                            </div>
                            <div class="col-sm-6">
                                <ol class="breadcrumb float-sm-right">
                                    <sec:authorize access="hasAuthority('Registrar Curso')">
                                        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#mcurso">
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
                                    <div class="card-header" style="background-color: #ff1a1a;color: #ffffff;" >
                                        <h3 class="card-title">
                                            Lista de Cursos
                                        </h3>
                                    </div>
                                    <div class="card-body">

                                        <div class="table-responsive">
                                            <table class="table table-striped table-bordered table-hover">
                                                <thead class="table-success">
                                                    <tr>
                                                        <th>Nombre</th>
                                                        <th>Precio</th>
                                                        <th>Duración</th>
                                                        <th>Horas Académicas</th>
                                                        <th>Docente</th>
                                                        <th>Estado</th>
                                                        <th>Acción</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr v-for="cur ,key in curso">
                                                        <td>{{cur.nomcur}}</td>
                                                        <td>{{cur.precrcur}}</td>
                                                        <td>{{cur.duracur}}</td>
                                                        <td>{{cur.horacur}}</td>
                                                        <td>{{cur.docente.persona.nomper}} {{cur.docente.persona.apeper}}</td>
                                                        <td>
                                                            <span class="badge badge-success" v-if="cur.estado=='ACTIVO'">{{cur.estado}}</span>
                                                            <span class="badge badge-warning" v-if="cur.estado=='INACTIVO'">{{cur.estado}}</span>
                                                        </td>
                                                        <td>
                                                            <sec:authorize access="hasAuthority('Editar Curso')"> access="hasAuthority('Registrar Curso')">
                                                                <button class="btn btn-info btn-sm" title="Cambiar de estado"  @click="cambiar(cur)"><i class="fas fa-sync-alt"></i></button>
                                                                </sec:authorize>
                                                                <sec:authorize access="hasAuthority('Cambiar estado Curso')">
                                                                <button class="btn btn-primary btn-sm" title="Editar Curso" data-toggle="modal" data-target="#mcursoe" @click="seleccionar(cur)"><i class="fas fa-pencil-alt" aria-hidden="true"></i></button>
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
            <div class="modal fade" id="mcurso" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color: #ff1a1a;color: #ffffff;">
                            <h5 class="modal-title" id="staticBackdropLabel">Registro de Curso</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close" @click="limpiar()">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Código</label>
                                        <input type="text" id="txtcod" v-model="txtcod" class="form-control" autocomplete="off">
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{msjcod}}</strong>
                                        </span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Nombre</label>
                                        <input type="text" id="txtnom" v-model="txtnom" class="form-control" autocomplete="off">
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{msjnom}}</strong>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Duración</label>
                                        <input type="text" id="txtdura" v-model="txtdura" class="form-control" autocomplete="off">
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{msjdura}}</strong>
                                        </span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Horas académicas</label>
                                        <input type="text" id="txthora" v-model="txthora" class="form-control" autocomplete="off">
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{msjhora}}</strong>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Precio</label>
                                <input type="text" id="txtprec" v-model="txtprec" class="form-control" autocomplete="off">
                                <span class="invalid-feedback" role="alert">
                                    <strong>{{msjprec}}</strong>
                                </span>
                            </div>
                            <div class="form-group">
                                <label>Docente</label>
                                <select v-model="cbodoc" id="cbodoc" class="form-control">
                                    <option value="0">Seleccione</option>
                                    <option v-for="doc in docente" v-bind:value="doc.iddocente">{{doc.persona.nomper}} {{doc.persona.apeper}} - {{doc.persona.dniper}}</option>
                                </select>
                                <span class="invalid-feedback" role="alert">
                                    <strong>{{msjdoc}}</strong>
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

            <div class="modal fade" id="mcursoe" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color: #ff1a1a;color: #ffffff;">
                            <h5 class="modal-title" id="staticBackdropLabel">Editar Curso</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close" @click="limpiar()">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Código</label>
                                        <input type="text" id="txtcode" v-model="txtcode" class="form-control" autocomplete="off">
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{msjcode}}</strong>
                                        </span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Nombre</label>
                                        <input type="text" id="txtnome" v-model="txtnome" class="form-control" autocomplete="off">
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{msjnome}}</strong>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Duración</label>
                                        <input type="text" id="txtdurae" v-model="txtdurae" class="form-control" autocomplete="off">
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{msjdurae}}</strong>
                                        </span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Horas académicas</label>
                                        <input type="text" id="txthorae" v-model="txthorae" class="form-control" autocomplete="off">
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{msjhorae}}</strong>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Precio</label>
                                <input type="text" id="txtprece" v-model="txtprece" class="form-control" autocomplete="off">
                                <span class="invalid-feedback" role="alert">
                                    <strong>{{msjprece}}</strong>
                                </span>
                            </div>
                            <div class="form-group">
                                <label>Docente</label>
                                <select v-model="cbodoce" id="cbodoce" class="form-control">
                                    <option value="0">Seleccione</option>
                                    <option v-for="doc in docente" v-bind:value="doc.iddocente">{{doc.persona.nomper}} {{doc.persona.apeper}} - {{doc.persona.dniper}}</option>
                                </select>
                                <span class="invalid-feedback" role="alert">
                                    <strong>{{msjdoce}}</strong>
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
                    curso: [],
                    docente: [],
                    txtcod: "",
                    txtnom: "",
                    txtdura: "",
                    txthora: "",
                    txtprec: "",
                    cbodoc: 0,

                    msjcod: "",
                    msjnom: "",
                    msjdura: "",
                    msjhora: "",
                    msjprec: "",
                    msjdoc: 0,

                    txtcode: "",
                    txtnome: "",
                    txtdurae: "",
                    txthorae: "",
                    txtprece: "",
                    cbodoce: 0,
                    idcur: "",

                    msjcode: "",
                    msjnome: "",
                    msjdurae: "",
                    msjhorae: "",
                    msjprece: "",
                    msjdoce: 0,
                },
                mounted: function () {
                    this.getcurso();
                    this.getdocente();
                },
                methods: {
                    limpiar: function () {
                        this.txtcod = "";
                        this.txtnom = "";
                        this.txtdura = "";
                        this.txthora = "";
                        this.txtprec = "";
                        this.cbodoc = 0;

                        $('#txtcod').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $('#txtnom').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $('#txtdura').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $('#txthora').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $('#txtprec').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $('#cbodoc').removeClass('form-control is-valid is-invalid').addClass('form-control');

                        this.txtcode = "";
                        this.txtnome = "";
                        this.txtdurae = "";
                        this.txthorae = "";
                        this.txtprece = "";
                        this.cbodoce = 0;

                        $('#txtcode').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $('#txtnome').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $('#txtdurae').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $('#txthorae').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $('#txtprece').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $('#cbodoce').removeClass('form-control is-valid is-invalid').addClass('form-control');
                    },
                    getcurso: function () {
                        axios.get('curso/mcurso').then(response => {
                            this.curso = response.data;
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    getdocente: function () {
                        axios.get('curso/mdocente').then(response => {
                            this.docente = response.data;
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    guardar: function () {
                        var data = new FormData();
                        data.append('cod', this.txtcod);
                        data.append('nom', this.txtnom);
                        data.append('dura', this.txtdura);
                        data.append('hora', this.txthora);
                        data.append('prec', this.txtprec);
                        data.append('iddoc', this.cbodoc);
                        axios.post('curso/guardar', data).then(response => {
                            if (response.data.resp == 'si') {
                                $('#txtcod').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#txtnom').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#txtdura').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#txthora').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#txtprec').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#cbodoc').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#mcurso').modal('toggle');
                                this.getcurso();
                                this.limpiar();
                            } else {
                                if (response.data.cod != undefined) {
                                    this.msjcod = response.data.cod;
                                    $('#txtcod').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjcod = '';
                                    $('#txtcod').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                }
                                if (response.data.nom != undefined) {
                                    this.msjnom = response.data.nom;
                                    $('#txtnom').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjnom = '';
                                    $('#txtnom').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                }
                                if (response.data.dura != undefined) {
                                    this.msjdura = response.data.dura;
                                    $('#txtdura').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjdura = '';
                                    $('#txtdura').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                }
                                if (response.data.hora != undefined) {
                                    this.msjhora = response.data.hora;
                                    $('#txthora').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjhora = '';
                                    $('#txthora').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                }
                                if (response.data.prec != undefined) {
                                    this.msjprec = response.data.prec;
                                    $('#txtprec').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjprec = '';
                                    $('#txtprec').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                }
                                if (response.data.iddoc != undefined) {
                                    this.msjdoc = response.data.iddoc;
                                    $('#cbodoc').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjdoc = '';
                                    $('#cbodoc').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                }
                            }
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    editar: function () {
                        var data = new FormData();
                        data.append('cod', this.txtcode);
                        data.append('nom', this.txtnome);
                        data.append('dura', this.txtdurae);
                        data.append('hora', this.txthorae);
                        data.append('prec', this.txtprece);
                        data.append('iddoc', this.cbodoce);
                        data.append('idcur', this.idcur);
                        axios.post('curso/editar', data).then(response => {
                            if (response.data.resp == 'si') {
                                $('#txtcode').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#txtnome').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#txtdurae').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#txthorae').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#txtprece').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#cbodoce').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#mcursoe').modal('toggle');
                                this.getcurso();
                                this.limpiar();
                            } else {
                                if (response.data.cod != undefined) {
                                    this.msjcode = response.data.cod;
                                    $('#txtcode').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjcode = '';
                                    $('#txtcode').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                }
                                if (response.data.nom != undefined) {
                                    this.msjnome = response.data.nom;
                                    $('#txtnome').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjnome = '';
                                    $('#txtnome').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                }
                                if (response.data.dura != undefined) {
                                    this.msjdurae = response.data.dura;
                                    $('#txtdurae').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjdurae = '';
                                    $('#txtdurae').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                }
                                if (response.data.hora != undefined) {
                                    this.msjhorae = response.data.hora;
                                    $('#txthorae').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjhorae = '';
                                    $('#txthorae').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                }
                                if (response.data.prec != undefined) {
                                    this.msjprece = response.data.prec;
                                    $('#txtprece').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjprece = '';
                                    $('#txtprece').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                }
                                if (response.data.iddoc != undefined) {
                                    this.msjdoce = response.data.iddoc;
                                    $('#cbodoce').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjdoc = '';
                                    $('#cbodoce').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                }
                            }
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    seleccionar: function (cur) {
                        this.idcur = cur.idcurso;
                        this.txtcode = cur.codcur;
                        this.txtnome = cur.nomcur;
                        this.txtdurae = cur.duracur;
                        this.txthorae = cur.horacur;
                        this.txtprece = cur.precrcur;
                        this.cbodoce = cur.docente.iddocente;
                    },
                    cambiar: function (cur) {
                        Swal.fire({
                            title: "Mensaje del Sistema",
                            text: "¿Desea cambiar el estado del curso?",
                            icon: "warning",
                            showCancelButton: true,
                            confirmButtonColor: "#3085d6",
                            cancelButtonColor: "#d33",
                            confirmButtonText: "Si, Cambiar"
                        }).then((result) => {
                            if (result.isConfirmed) {
                                var data = new FormData();
                                data.append('idcur', cur.idcurso);
                                data.append('esta', cur.estado);
                                axios.post('curso/cambiarestado', data).then(response => {
                                    this.getcurso();
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
