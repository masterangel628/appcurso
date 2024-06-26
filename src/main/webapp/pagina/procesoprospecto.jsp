<%-- 
    Document   : procesoprospecto
    Created on : 19 may 2024, 16:12:11
    Author     : Asus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <meta name="description" content="Sistema de Gestión Cursos - ISIPP">
	<meta name="author" content="Miguel Ángel Toledo Cordova">
        <title>Proceso Prospecto</title>
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
                                <h1>Proceso prospecto</h1>
                            </div>
                        </div>
                    </div>
                </div>
                <section class="content">
                    <div class="container-fluid">
                        <div class="row" v-if="divmen">
                            <div class="col-md-12">
                                <div class="alert alert-warning alert-dismissible fade show" role="alert">
                                    <strong>Mensaje:</strong> {{msj}}
                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                        <span aria-hidden="true">&times;</span>
                                    </button>
                                </div>
                            </div>
                        </div>
                        <div class="row" v-if="divconte">
                            <div class="col-md-12">
                                <div class="card">
                                    <div class="card-header" style="background-color: #ff1a1a;color: #ffffff;">
                                        <h3 class="card-title">
                                            Cartera de clientes
                                        </h3>
                                        <div class="card-tools">
                                            <button class="btn btn-danger btn-sm" @click="getclientever()" title="Ver clientes verificados" data-toggle="modal" data-target="#mcverificado">Ver</button>
                                        </div>
                                    </div>
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <table class="table table-striped table-bordered table-hover"  id="tabdatos">
                                                <thead class="table-success">
                                                    <tr>
                                                        <th>Nombre</th>
                                                        <th>Celular</th>
                                                        <sec:authorize access="hasAuthority('ROLE_Administrador')">
                                                        <th>Estado de Tiempo</th>
                                                        </sec:authorize>
                                                        <th>Acción</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr v-for="cli in cliente">
                                                        <td >{{cli.nompros}}</td>
                                                        <td width="15%">{{cli.celpros}}</td>
                                                        <sec:authorize access="hasAuthority('ROLE_Administrador')">
                                                        <td width="25%">{{cli.estatimpros}}</td>
                                                         </sec:authorize>
                                                        <td width="25%">
                                                            <button class="btn btn-warning btn-sm"  @click="cambiarcal(cli)" title="Cambiar a estado Caliente">
                                                                Caliente
                                                            </button>
                                                            <button class="btn btn-success btn-sm"  @click="cambiarti(cli)" title="Cambiar a estado Tibio">
                                                                Tibio
                                                            </button>
                                                            <button class="btn btn-primary btn-sm"  @click="cambiarfri(cli)" title="Cambiar a estado Frio">
                                                                Frio
                                                            </button>
                                                            <button data-toggle="modal" data-target="#mprematricula" @click="seleccionar(cli)" class="btn btn-danger btn-sm" title="Inscribir al cliente">
                                                                <i class="far fa-save"></i>
                                                            </button>
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
            <%@include file="footer.jsp" %>
            <div class="modal fade" id="mprematricula" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg modal-dialog-scrollable">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color: #ff1a1a;color: #ffffff;">
                            <h5 class="modal-title" id="staticBackdropLabel">Registro de Prematrícula</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close" @click="limpiar()">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="bs-stepper linear">
                                <div class="bs-stepper-header" role="tablist">
                                    <div class="step active" data-target="#logins-part">
                                        <button type="button" class="step-trigger" role="tab" aria-controls="logins-part" id="logins-part-trigger" aria-selected="true">
                                            <span class="bs-stepper-circle">1</span>
                                            <span class="bs-stepper-label">Registrar paquete o curso</span>
                                        </button>
                                    </div>
                                    <div class="line"></div>
                                    <div class="step" data-target="#information-part">
                                        <button type="button" class="step-trigger" role="tab" aria-controls="information-part" id="information-part-trigger" aria-selected="false" disabled="disabled">
                                            <span class="bs-stepper-circle">2</span>
                                            <span class="bs-stepper-label">Finalizar prematrícula</span>
                                        </button>
                                    </div>
                                </div>
                                <div class="bs-stepper-content">
                                    <div id="logins-part" class="content active dstepper-block" role="tabpanel" aria-labelledby="logins-part-trigger">
                                        <div class="form-group">
                                            <label>Tipo</label>
                                            <select class="form-control" v-model="cbotipo" id="cbotipo" @change="cambiartipo">
                                                <option value="0">Seleccione</option>
                                                <option value="CURSO">Curso</option>
                                                <option value="PAQUETE">Paquete</option>
                                            </select>
                                        </div>
                                        <div class="form-group" v-if="divcurso">
                                            <label>Curso</label>
                                            <div class="input-group">
                                                <select class="form-control" v-model="cbocurso" id="cbocurso">
                                                    <option value="0">Seleccione</option>
                                                    <option v-for="cur in curso" v-bind:value="cur.idcurso">{{cur.nomcur}}</option>
                                                </select>
                                                <div class="input-group-append">
                                                    <button class="btn btn-primary" @click="guardar()">
                                                        <i class="fas fa-plus"></i>
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group"  v-if="divpaquete">
                                            <label>Paquete</label>
                                            <div class="input-group">
                                                <select class="form-control"  v-model="cbopaquete" id="cbopaquete" @change="getpaquetecurso">
                                                    <option value="0">Seleccione</option>
                                                    <option v-for="paq in paquete" v-bind:value="paq.idpaquete">{{paq.nompaq}}</option>
                                                </select>
                                                <div class="input-group-append">
                                                    <button class="btn btn-primary" @click="guardar()">
                                                        <i class="fas fa-plus"></i>
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group"  v-if="divpaquete">
                                            <label>Cursos que incluye el paquete</label>
                                            <ul id="example-1">
                                                <li v-for="paqcur in paquetecurso">
                                                    {{paqcur.nomcur}}
                                                </li>
                                            </ul>
                                        </div>
                                        <div class="table-responsive">
                                            <table class="table table-striped table-bordered table-hover" id="tabprospecto">
                                                <thead class="table-success">
                                                    <tr>
                                                        <th>Tipo</th>
                                                        <th>Nombre</th>
                                                        <th>Monto</th>
                                                        <th>Acción</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr v-for="com in comanda">
                                                        <td>{{com.tipocurpaq}}</td>
                                                        <td>{{com.curpaq}}</td>
                                                        <td>{{com.montocom}}</td>
                                                        <td>
                                                            <button class="btn btn-danger btn-sm" @click="eliminar(com)"><i class="fas fa-trash-alt"></i></button>
                                                        </td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                        <button class="btn btn-primary" @click="siguiente()">Siguiente</button>
                                    </div>
                                    <div id="information-part" class="content" role="tabpanel" aria-labelledby="information-part-trigger">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label>Cliente</label>
                                                    <div class="input-group">
                                                        <input type="text" class="form-control" id="txtcliente" @keyup="buscarcliente" autocomplete="off">
                                                        <input type="hidden" id="txtidcliente">
                                                        <div id="listacliente" class="dropdown-menu"></div>
                                                        <div class="input-group-append">
                                                            <button class="btn btn-primary" data-toggle="modal" data-target="#mcliente" title="Agregar Cliente"><i class="fas fa-plus"></i>
                                                            </button>
                                                        </div>
                                                        <span class="invalid-feedback" role="alert">
                                                            <strong>{{msjcliente}}</strong>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label>Tipo matrícula</label>
                                                    <select class="form-control" v-model="cbotipomat" id="cbotipomat">
                                                        <option value="0">Seleccione</option>
                                                        <option value="REGULAR">Regular</option>
                                                        <option value="ACELERADO">Acelerado</option>
                                                    </select>
                                                    <span class="invalid-feedback" role="alert">
                                                        <strong>{{msjtipomat}}</strong>
                                                    </span>
                                                </div>
                                            </div>
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
                                        <button class="btn btn-danger" onclick="stepper.previous()">Anterior</button>
                                        <button type="button" class="btn btn-primary" @click="finalizar()">Guardar</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


            <div class="modal fade" id="mcliente" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-scrollable">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color: #ff1a1a;color: #ffffff;">
                            <h5 class="modal-title" id="staticBackdropLabel">Registro de Cliente</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close" @click="limpiarcliente()">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>DNI</label>
                                        <input type="text" id="txtdni" v-model="txtdni" maxlength="8" @keyup="completar()" class="form-control" autocomplete="off">
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
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Correo</label>
                                        <input type="text" id="txtcor" v-model="txtcor" class="form-control" autocomplete="off">
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{msjcor}}</strong>
                                        </span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Departamento</label>
                                        <select v-model="cbodep" id="cbodep" class="form-control" @change="getprovincia">
                                            <option value="0">Seleccione</option>
                                            <option v-for="dep in departamento" v-bind:value="dep.iddepartamento">{{dep.nom_dep}}</option>
                                        </select>
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{msjdep}}</strong>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Provincia</label>
                                        <select v-model="cboprov" id="cboprov" class="form-control" @change="getdistrito">
                                            <option value="0">Seleccione</option>
                                            <option v-for="prov in provincia" v-bind:value="prov.idprovincia">{{prov.nom_prov}}</option>
                                        </select>
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{msjprov}}</strong>
                                        </span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Distrito</label>
                                        <select v-model="cbodist" id="cbodist" class="form-control">
                                            <option value="0">Seleccione</option>
                                            <option v-for="dist in distrito" v-bind:value="dist.iddistrito">{{dist.nom_dist}}</option>
                                        </select>
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{msjdist}}</strong>
                                        </span>
                                    </div>
                                </div>
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
                            <button class="btn btn-secondary" type="button" data-dismiss="modal" @click="limpiarcliente()">Cancelar</button>
                            <button class="btn btn-info" type="button" @click="guardarcliente()">Guardar</button>
                        </div>
                    </div>
                </div>
            </div>


            <div class="modal fade" id="mcverificado" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg modal-dialog-scrollable">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color: #ff1a1a;color: #ffffff;">
                            <h5 class="modal-title" id="staticBackdropLabel">Clientes verificados</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close" @click="actualizartabla()">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover"  id="tabdato">
                                    <thead class="table-success">
                                        <tr>
                                            <th>Nombre</th>
                                            <th>Celular</th>
                                            <sec:authorize access="hasAuthority('ROLE_Administrador')">
                                                        <th>Estado de Tiempo</th>
                                                        </sec:authorize>
                                            <th>Acción</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr v-for="cli in clientever">
                                            <td >{{cli.nompros}}</td>
                                            <td width="15%">{{cli.celpros}}</td>
                                             <sec:authorize access="hasAuthority('ROLE_Administrador')">
                                                        <td width="25%">{{cli.estatimpros}}</td>
                                                         </sec:authorize>
                                            <td width="10%">
                                                <button class="btn btn-warning btn-sm" @click="cambiarnover(cli)" title="Cambiar a estado No Verificado">
                                                    Cambiar
                                                </button>
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
        <%@include file="scrip.jsp" %>
        <script>
            // BS-Stepper Init
            document.addEventListener('DOMContentLoaded', function () {
                window.stepper = new Stepper(document.querySelector('.bs-stepper'))
            })
            let app = new Vue({
                el: '#app',
                data: {

                    archivo: null,
                    banco: [],
                    cboban: 0,
                    vaumat: "",
                    msjvau: "",
                    msjban: "",

                    msjcliente: "",
                    msjtipomat: "",

                    departamento: [],
                    provincia: [],
                    distrito: [],

                    txtdni: "",
                    txtape: "",
                    txtnom: "",
                    txtcel: "",
                    txtdir: "",
                    txtcor: "",
                    cbodep: 0,
                    cboprov: 0,
                    cbodist: 0,

                    msjdni: "",
                    msjape: "",
                    msjnom: "",
                    msjcel: "",
                    msjdir: "",
                    msjcor: "",
                    msjdep: "",
                    msjprov: "",
                    msjdist: "",

                    paquetecurso: [],
                    cliente: [],
                    clientever: [],
                    comanda: [],
                    curso: [],
                    paquete: [],
                    cbocurso: 0,
                    cbopaquete: 0,
                    cbotipo: 0,
                    divcurso: false,
                    divpaquete: false,
                    iddetpros: "",
                    cbotipomat: 0,

                    divmen: false,
                    divconte: false,
                    msj: "",
                },
                mounted: function () {
                    this.verificarsesion();
                    this.getcliente();
                    this.getdepartamento();
                    this.getbanco();
                },
                methods: {
                    actualizartabla: function () {
                        this.getcliente();
                    },
                    cambiarnover: function (cli) {
                        var data = new FormData();
                        data.append('iddetpro', cli.iddetalleprospecto);
                        axios.post('procesoprospecto/actualizar', data).then(response => {
                            this.getclientever();
                        }).catch(error => {
                        })
                    },
                    tabla: function (tab) {
                        this.$nextTick(() => {
                            $('#' + tab).DataTable({
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
                    config: function (tab) {
                        $("#" + tab).DataTable().destroy();
                        this.tabla(tab);
                    },
                    getbanco: function () {
                        axios.get('procesoprospecto/mbanco').then(response => {
                            this.banco = response.data;
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    getArchivo(event) {
                        if (!event.target.files.length) {
                            this.archivo = null;
                        } else {
                            this.archivo = event.target.files[0];
                        }
                    },
                    suportprovincia: function (dep) {
                        axios.get('persona/provincia/' + dep).then(response => {
                            this.provincia = response.data;
                        });
                    },
                    suportdistrito: function (prov) {
                        axios.get('persona/distrito/' + prov).then(response => {
                            this.distrito = response.data;
                        });
                    },
                    getdepartamento: function () {
                        var url = 'persona/departamento';
                        axios.get(url).then(response => {
                            this.departamento = response.data;
                        })
                    },
                    getprovincia: function () {
                        var url = 'persona/provincia/' + this.cbodep;
                        axios.get(url).then(response => {
                            this.cboprov = 0;
                            this.provincia = response.data;
                            this.cbodist = 0;
                            this.distrito = [];
                        })
                    },
                    getdistrito: function () {
                        var url = 'persona/distrito/' + this.cboprov;
                        axios.get(url).then(response => {
                            this.cbodist = 0;
                            this.distrito = response.data;
                        })
                    },
                    completar: function () {
                        if (this.txtdni.length == 8) {
                            axios.get('persona/consulta/' + this.txtdni).then(response => {
                                if (response.data.msj == "bd") {
                                    this.txtape = response.data.persona.apeper;
                                    this.txtnom = response.data.persona.nomper;
                                    this.txtdir = response.data.persona.dirper;
                                    this.txtcel = response.data.persona.celper;
                                    this.txtcor = response.data.persona.correoper;
                                    this.cbodep = response.data.persona.distrito.provincia.departamento.iddepartamento;
                                    this.suportprovincia(this.cbodep);
                                    this.cboprov = response.data.persona.distrito.provincia.idprovincia;
                                    this.suportdistrito(this.cboprov);
                                    this.cbodist = response.data.persona.distrito.iddistrito;
                                }
                                if (response.data.msj == "api") {
                                    var p = JSON.parse(response.data.persona);
                                    console.log(p.data.ubigeo[0]);
                                    this.txtape = p.data.apellido_paterno + " " + p.data.apellido_materno;
                                    this.txtnom = p.data.nombres;
                                    this.txtdir = p.data.direccion;
                                    this.cbodep = p.data.ubigeo[0];
                                    this.suportprovincia(this.cbodep);
                                    this.cboprov = p.data.ubigeo[1];
                                    this.suportdistrito(this.cboprov);
                                    this.cbodist = p.data.ubigeo[2];
                                }
                            }).catch(function (error) {
                                console.log(error);
                            });
                        } else {
                            this.txtape = "";
                            this.txtnom = "";
                            this.txtdir = "";
                            this.txtcor = "";
                            this.txtcel = "";
                            this.cboprov = 0;
                            this.cbodist = 0;
                            this.cbodep = 0;
                            this.distrito = [];
                            this.provincia = [];
                        }
                    },
                    verificarsesion: function () {
                        axios.get('procesoprospecto/verificasesion').then(response => {
                            if (response.data.resp == "si") {
                                this.divconte = true;
                                this.divmen = false;
                            } else {
                                this.divconte = false;
                                this.divmen = true;
                                this.msj = "Primero tiene que abrir una sesión";
                            }
                        }).catch(function (error) {

                        });
                    },
                    limpiarcliente: function () {
                        this.txtdni = "";
                        this.txtape = "";
                        this.txtnom = "";
                        this.txtcel = "";
                        this.txtdir = "";
                        this.txtcor = "";
                        this.cbodep = 0;
                        this.cboprov = 0;
                        this.cbodist = 0;

                        $('#txtdni').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $('#txtape').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $('#txtnom').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $('#txtcel').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $('#txtdir').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $('#txtcor').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $('#cbodep').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $('#cboprov').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $('#cbodist').removeClass('form-control is-valid is-invalid').addClass('form-control');

                        this.msjdni = "";
                        this.msjape = "";
                        this.msjnom = "";
                        this.msjcel = "";
                        this.msjdir = "";
                        this.msjcor = "";
                        this.msjdep = "";
                        this.msjprov = "";
                        this.msjdist = "";


                    },
                    buscarcliente: function () {
                        var lista = $("#listacliente");
                        var palabra = $("#txtcliente").val();
                        if (palabra.length > 0) {
                            $.ajax({
                                url: 'cliente/buscar?bus=' + palabra,
                                type: 'GET',
                                success: function (data) {
                                    lista.find('li').remove();
                                    $(data).each(function (i, v) {
                                        lista.append('<li class="dropdown-item" onclick="setitemcliente(\'' + v.idcliente + '\',\'' + v.cliente + '\')">' + v.cliente + '</li>');
                                    });
                                    if (data != "") {
                                        $("#listacliente").show();
                                    } else {
                                        $('#listacliente').hide();
                                    }
                                }
                            });
                        } else {
                            $('#listacliente').hide();
                        }
                    },
                    finalizar: function () {
                        if (this.archivo == null) {
                            toastr.warning("Seleccione un archivo");
                        } else {
                            var data = new FormData();
                            data.append('tip', this.cbotipomat);
                            data.append('detpro', this.iddetpros);
                            data.append('cli', $("#txtidcliente").val());
                            data.append('vau', this.archivo);
                            data.append('ban', this.cboban);
                            axios.post('procesoprospecto/finalizar', data).then(response => {
                                if (response.data.resp == 'si') {
                                    $('#txtvau').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                    $('#cboban').removeClass('form-control is-invalid').addClass('form-control is-valid');

                                    $('#mprematricula').modal('toggle');
                                    this.limpiar();
                                    this.getcliente();
                                    toastr.success("La prematrícula se registró correctamente");
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
                                    if (response.data.cli != undefined) {
                                        this.msjcliente = response.data.cli;
                                        $('#txtcliente').removeClass('form-control').addClass('form-control is-invalid');
                                    } else {
                                        this.msjcliente = '';
                                        $('#txtcliente').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                    }
                                    if (response.data.tip != undefined) {
                                        this.msjtipomat = response.data.tip;
                                        $('#cbotipomat').removeClass('form-control').addClass('form-control is-invalid');
                                    } else {
                                        this.msjtipomat = '';
                                        $('#cbotipomat').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                    }

                                }
                            }).catch(function (error) {
                                console.log(error);
                            });
                        }
                    },
                    guardarcliente: function () {
                        var data = new FormData();
                        data.append('dni', this.txtdni);
                        data.append('ape', this.txtape);
                        data.append('nom', this.txtnom);
                        data.append('cel', this.txtcel);
                        data.append('dir', this.txtdir);
                        data.append('cor', this.txtcor);
                        data.append('dep', this.cbodep);
                        data.append('prov', this.cboprov);
                        data.append('dist', this.cbodist);
                        axios.post('cliente/guardar', data).then(response => {
                            if (response.data.resp == 'si') {
                                $('#txtdni').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#txtape').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#txtnom').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#txtcel').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#txtdir').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#txtcor').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#cbodep').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#cboprov').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#cbodist').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#mcliente').modal('toggle');
                                this.limpiarcliente();
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
                                if (response.data.dep != undefined) {
                                    this.msjdep = response.data.dep;
                                    $('#cbodep').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjdep = '';
                                    $('#cbodep').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                }
                                if (response.data.prov != undefined) {
                                    this.msjprov = response.data.prov;
                                    $('#cboprov').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjprov = '';
                                    $('#cboprov').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                }
                                if (response.data.dist != undefined) {
                                    this.msjdist = response.data.dist;
                                    $('#cbodist').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjdist = '';
                                    $('#cbodist').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                }
                            }


                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    getpaquetecurso: function () {
                        axios.get('procesoprospecto/paquetecurso?idpaq=' + this.cbopaquete).then(response => {
                            this.paquetecurso = response.data;
                            console.log(response.data)
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    cambiartipo: function () {
                        if (this.cbotipo == 0) {
                            this.divcurso = false;
                            this.divpaquete = false;
                        }
                        if (this.cbotipo == "CURSO") {
                            this.divcurso = true;
                            this.divpaquete = false;
                            this.cbopaquete = 0;
                            this.paquete = [];
                            this.getcurso();
                        }
                        if (this.cbotipo == "PAQUETE") {
                            this.divcurso = false;
                            this.divpaquete = true;
                            this.cbocurso = 0;
                            this.curso = [];
                            this.getpaquete();
                        }
                    },
                    siguiente: function () {
                        if (this.comanda.length != 0) {
                            stepper.next();
                        } else {
                            toastr.warning("Tiene que registrar curso o paquete");
                        }

                    },
                    eliminar: function (com) {
                        var data = new FormData();
                        data.append('idco', com.idcomanda);
                        axios.post('procesoprospecto/eliminacomanda', data).then(response => {
                            this.getcomanda();
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    getcurso: function () {
                        axios.get('procesoprospecto/mcurso').then(response => {
                            this.curso = response.data;
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    getcomanda: function () {
                        axios.get('procesoprospecto/comanda?iddetpro=' + this.iddetpros).then(response => {
                            this.comanda = response.data;
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    getpaquete: function () {
                        axios.get('procesoprospecto/mpaquete').then(response => {
                            this.paquete = response.data;
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    guardar: function () {
                        var data = new FormData();
                        if (this.cbocurso != 0) {
                            data.append('curpaq', this.cbocurso);
                        } else {
                            if (this.cbopaquete != 0) {
                                data.append('curpaq', this.cbopaquete);
                            } else {
                                data.append('curpaq', '0');
                            }
                        }
                        data.append('tipo', this.cbotipo);
                        data.append('detpro', this.iddetpros);
                        axios.post('procesoprospecto/guardar', data).then(response => {
                            if (response.data.resp == 'si') {
                                if (response.data.proc == "existepaq") {
                                    toastr.warning("El paquete ya se encuentra registrado");
                                }
                                if (response.data.proc == "sipaq") {
                                    toastr.success("El paquete se registró correctamente");
                                }
                                if (response.data.proc == "existecur") {
                                    toastr.warning("El curso ya se encuentra registrado");
                                }
                                if (response.data.proc == "sicur") {
                                    toastr.success("El curso se registró correctamente");
                                }
                            } else {
                                if (this.cbotipo == "CURSO") {
                                    if (response.data.curpaq != undefined) {
                                        toastr.warning(response.data.curpaq);
                                    }
                                }
                                if (this.cbotipo == "PAQUETE") {
                                    if (response.data.curpaq != undefined) {
                                        toastr.warning(response.data.curpaq);
                                    }
                                }
                            }
                            this.getcomanda();
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    limpiar: function () {
                        this.divcurso = false;
                        this.divpaquete = false;
                        this.cbotipo = 0;
                        this.cbocurso = 0;
                        this.cbopaquete = 0;
                        this.paquete = [];
                        this.curso = [];
                        stepper.to(1);
                        this.iddetpros = "";
                        $("#txtidcliente").val("");
                        $("#txtcliente").val("");
                        $('#listacliente').hide();
                        this.cbotipomat = 0;

                        this.msjcliente = '';
                        this.msjtipomat = '';
                        this.msjvau = '';
                        this.msjban = '';
                        this.cboban = 0;
                        $('#txtcliente').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $('#cbotipomat').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $('#cboban').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $('#txtvau').removeClass('form-control is-valid is-invalid').addClass('form-control');

                    },
                    seleccionar: function (cli) {
                        this.iddetpros = cli.iddetalleprospecto;
                        this.getcomanda();
                    },
                    getcliente: function () {
                        axios.get('procesoprospecto/mostrar').then(response => {
                            this.cliente = response.data;
                            this.config("tabdatos");
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    getclientever: function () {
                        axios.get('procesoprospecto/mostrarver').then(response => {
                            this.clientever = response.data;
                            this.config("tabdato");
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    cambiarcal: function (cli) {
                        var data = new FormData();
                        data.append('esta', "CALIENTE");
                        data.append('idpro', cli.fkidprospecto);
                        data.append('iddetpro', cli.iddetalleprospecto);
                        axios.post('procesoprospecto/actualizarestado', data).then(response => {
                            this.getcliente();
                        }).catch(error => {
                        })
                    },
                    cambiarti: function (cli) {
                        var data = new FormData();
                        data.append('esta', "TIBIO");
                        data.append('idpro', cli.fkidprospecto);
                        data.append('iddetpro', cli.iddetalleprospecto);
                        axios.post('procesoprospecto/actualizarestado', data).then(response => {
                            this.getcliente();
                        }).catch(error => {
                        })
                    },
                    cambiarfri: function (cli) {
                        var data = new FormData();
                        data.append('esta', "FRIO");
                        data.append('idpro', cli.fkidprospecto);
                        data.append('iddetpro', cli.iddetalleprospecto);
                        axios.post('procesoprospecto/actualizarestado', data).then(response => {
                            this.getcliente();
                        }).catch(error => {
                        })
                    },
                },
            });
            function setitemcliente(id, cli) {
                $("#txtidcliente").val(id);
                $("#txtcliente").val(cli);
                $('#listacliente').hide();
            }
        </script>
    </body>
</html>


