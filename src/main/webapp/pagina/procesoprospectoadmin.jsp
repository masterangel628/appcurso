<%-- 
    Document   : procesoprospecto
    Created on : 19 may 2024, 16:12:11
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
        <title>Proceso Prospecto - Administrador</title>
        <link href="public/dist/img/icono.png" rel="icon">
        <%@include file="estilocss.jsp" %>
        <style>
            .selected{
                background-color: blue;
                color:white;
            }
            .image-preview {
                display: flex;
                flex-wrap: wrap;
                gap: 10px;
                margin-top: 10px;
            }
            .image-preview img {
                max-width: 100px;
                max-height: 100px;
                border: 1px solid #ccc;
                object-fit: cover;
            }
            .image-preview .image-item {
                position: relative;
                display: inline-block;
            }
            .image-preview .image-item button {
                position: absolute;
                top: 5px;
                right: 5px;
                background: rgba(255, 0, 0, 0.6);
                border: none;
                color: white;
                cursor: pointer;
                border-radius: 50%;
                width: 20px;
                height: 20px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 14px;
            }
        </style>
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
                            <div class="col-sm-6">
                                <ol class="breadcrumb float-sm-right">
                                    <button @click="veriseleccion()" class="btn btn-danger btn-sm" title="Inscribir al cliente"><img src="public/dist/img/salvado.png"/>Prematrícula</button>

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
                                    <div class="card-body">
                                        <div class="form-group">
                                            <label>Usuario</label>
                                            <select class="form-control" v-model="cbousu" @change="cambiauser()">
                                                <option value="0">Seleccione</option>
                                                <option v-for="usu in usuario" v-bind:value="usu.id">{{usu.usuario}} - {{usu.cliente}}</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
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
                                    </div>
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <table class="table table-bordered" id="tabdatos" >
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
                                                    <tr v-for="cli ,key in cliente" @click="selectrow(key)" :class="{selected: selectindex==key}">
                                                        <td>{{cli.nompros}}</td>
                                                        <td><span class="badge badge-warning" v-if="cli.estatimpros=='CALIENTE' && cli.estaverdetpros=='VERIFICADO'">{{cli.celpros}}</span>
                                                            <span class="badge badge-success" v-if="cli.estatimpros=='TIBIO' && cli.estaverdetpros=='VERIFICADO'">{{cli.celpros}}</span>
                                                            <span class="badge badge-primary" v-if="cli.estatimpros=='FRIO' && cli.estaverdetpros=='VERIFICADO'">{{cli.celpros}}</span>
                                                            <span v-if="cli.estaverdetpros=='NOVERIFICADO'">{{cli.celpros}}</span></td>
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
                                                            <button class="btn btn-primary btn-sm" @click="cambiarfri(cli)" title="Cambiar a estado Frio">
                                                                Frio
                                                            </button>
                                                            <button @click="abrirmodal(cli)" class="btn btn-info btn-sm" title="Agregar descripción">
                                                                <i class="fas fa-plus"></i>
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
                                    <div class="step" data-target="#registercli">
                                        <button type="button" class="step-trigger" role="tab" aria-controls="registercli" id="registercli-trigger" aria-selected="false" disabled="disabled">
                                            <span class="bs-stepper-circle">2</span>
                                            <span class="bs-stepper-label">Registrar cliente</span>
                                        </button>
                                    </div>
                                    <div class="line"></div>
                                    <div class="step" data-target="#information-part">
                                        <button type="button" class="step-trigger" role="tab" aria-controls="information-part" id="information-part-trigger" aria-selected="false" disabled="disabled">
                                            <span class="bs-stepper-circle">3</span>
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

                                    <div id="registercli" class="content" role="tabpanel" aria-labelledby="registercli-trigger">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label>Cliente</label>
                                                    <div class="input-group">
                                                        <div class="input-group-prepend">
                                                            <select v-model="cbotipocli" class="form-control" @change="mostraregal">
                                                                <option value="DNI">DNI</option>
                                                                <option value="RUC">RUC</option>
                                                            </select>
                                                        </div>
                                                        <input type="text" class="form-control" id="txtcliente" @keyup="buscarcliente" autocomplete="off">
                                                        <input type="hidden" id="txtidcliente">
                                                        <div id="listacliente" class="dropdown-menu"></div>
                                                        <div class="input-group-append">
                                                            <button class="btn btn-primary" @click="mostrarform()" title="Agregar Cliente"><i class="fas fa-plus"></i>
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
                                                    <label>Alumno</label>
                                                    <div class="input-group">
                                                        <input type="hidden" id="txtidpem">
                                                        <input type="text" class="form-control" id="txtalumno" @keyup="buscaralumno" autocomplete="off">
                                                        <div id="listaalumno" class="dropdown-menu"></div>
                                                        <div class="input-group-append" v-if="divregal">
                                                            <button class="btn btn-primary" data-toggle="modal" data-target="#malumno" title="Registrar Alumno"><i class="fas fa-save"></i>
                                                            </button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="text-center">
                                            <button class="btn btn-success btn-block" @click="guardarclicom()">Guardar</button>
                                        </div>
                                        <div class="form-group">
                                            <label>Información</label>
                                            <textarea class="form-control" v-model="txtclidesc" rows="3" disabled="true"></textarea>
                                        </div>
                                        <br>
                                        <button class="btn btn-danger" onclick="stepper.previous()">Anterior</button>
                                        <button class="btn btn-primary" @click="siguiente1()">Siguiente</button>


                                    </div>

                                    <div id="information-part" class="content" role="tabpanel" aria-labelledby="information-part-trigger">
                                        <div class="row">

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
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label>Descuento</label>
                                                    <div class="input-group">
                                                        <div class="input-group-prepend">
                                                            <select v-model="cbotipodesc" class="form-control" @change="mostrardesc">
                                                                <option value="SI">SI</option>
                                                                <option value="NO">NO</option>
                                                            </select>
                                                        </div>
                                                        <input type="number" id="txtmdesc" v-model="txtmdesc" class="form-control" @keyup="cambiamonto" autocomplete="off">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label>Monto a Pagar</label>
                                                    <input type="text" v-model="txtmonto" class="form-control" disabled="true">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label>Váucher</label>
                                            <input type="file" id="txtvau" multiple  @change="getArchivos" accept=".png,.jpg,.jpeg" class="form-control" autocomplete="off">
                                            <span class="invalid-feedback" role="alert">
                                                <strong>{{msjvau}}</strong>
                                            </span>
                                            <div class="image-preview" id="imagePreview"></div>
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
            <div class="modal fade" id="mclienteruc" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-scrollable">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color: #ff1a1a;color: #ffffff;">
                            <h5 class="modal-title" id="staticBackdropLabel">Registro de Cliente</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close" @click="limpiarruc()">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>RUC</label>
                                        <input type="text" id="txtruc" v-model="txtruc" maxlength="11" @keyup="completarruc()" class="form-control" autocomplete="off">
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{msjruc}}</strong>
                                        </span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Razón Social</label>
                                        <input type="text" id="txtraz" v-model="txtraz" class="form-control" autocomplete="off">
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{msjraz}}</strong>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Correo</label>
                                        <input type="text" id="txtcoruc" v-model="txtcoruc" class="form-control" autocomplete="off">
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{msjcoruc}}</strong>
                                        </span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Celular</label>
                                        <input type="text" id="txtcelruc" v-model="txtcelruc" class="form-control" autocomplete="off">
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{msjcelruc}}</strong>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Departamento</label>
                                <select v-model="cbodepruc" id="cbodepruc" class="form-control" @change="getprovinciaruc">
                                    <option value="0">Seleccione</option>
                                    <option v-for="dep in departamento" v-bind:value="dep.iddepartamento">{{dep.nom_dep}}</option>
                                </select>
                                <span class="invalid-feedback" role="alert">
                                    <strong>{{msjdepruc}}</strong>
                                </span>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Provincia</label>
                                        <select v-model="cboprovruc" id="cboprovruc" class="form-control" @change="getdistritoruc">
                                            <option value="0">Seleccione</option>
                                            <option v-for="prov in provincia" v-bind:value="prov.idprovincia">{{prov.nom_prov}}</option>
                                        </select>
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{msjprovruc}}</strong>
                                        </span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Distrito</label>
                                        <select v-model="cbodistruc" id="cbodistruc" class="form-control">
                                            <option value="0">Seleccione</option>
                                            <option v-for="dist in distrito" v-bind:value="dist.iddistrito">{{dist.nom_dist}}</option>
                                        </select>
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{msjdistruc}}</strong>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Dirección</label>
                                <textarea v-model="txtdiruc" id="txtdiruc" class="form-control"></textarea>
                                <span class="invalid-feedback" role="alert">
                                    <strong>{{msjdirruc}}</strong>
                                </span>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-secondary" type="button" data-dismiss="modal" @click="limpiarruc()">Cancelar</button>
                            <button class="btn btn-info" type="button" @click="guardaruc()">Guardar</button>
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

            <div class="modal fade" id="mactualizardesc" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-scrollable">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color: #ff1a1a;color: #ffffff;">
                            <h5 class="modal-title" id="staticBackdropLabel">Agregar Descripción</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close" @click="limpiardes()">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label>Descripción</label>
                                <textarea v-model="txtdesc" class="form-control"></textarea>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-secondary" type="button" data-dismiss="modal" @click="limpiarcliente()">Cancelar</button>
                            <button class="btn btn-info" type="button" @click="actualizardes()">Actualizar</button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="malumno" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-scrollable">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color: #ff1a1a;color: #ffffff;">
                            <h5 class="modal-title" id="staticBackdropLabel">Registro de Alumno</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close" @click="limpiaralumno()">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>DNI</label>
                                        <input type="text" id="txtdnial" v-model="txtdnial" maxlength="8" @keyup="completaralumno()" class="form-control" autocomplete="off">
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{msjdnial}}</strong>
                                        </span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Apellido</label>
                                        <input type="text" id="txtapeal" v-model="txtapeal" class="form-control" autocomplete="off">
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{msjapeal}}</strong>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Nombre</label>
                                        <input type="text" id="txtnomal" v-model="txtnomal" class="form-control" autocomplete="off">
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{msjnomal}}</strong>
                                        </span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Celular</label>
                                        <input type="text" id="txtcelal" v-model="txtcelal" class="form-control" autocomplete="off">
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{msjcelal}}</strong>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Correo</label>
                                        <input type="text" id="txtcoral" v-model="txtcoral" class="form-control" autocomplete="off">
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{msjcoral}}</strong>
                                        </span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Departamento</label>
                                        <select v-model="cbodepal" id="cbodepal" class="form-control" @change="getprovincia">
                                            <option value="0">Seleccione</option>
                                            <option v-for="dep in departamento" v-bind:value="dep.iddepartamento">{{dep.nom_dep}}</option>
                                        </select>
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{msjdepal}}</strong>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Provincia</label>
                                        <select v-model="cboproval" id="cboproval" class="form-control" @change="getdistrito">
                                            <option value="0">Seleccione</option>
                                            <option v-for="prov in provincia" v-bind:value="prov.idprovincia">{{prov.nom_prov}}</option>
                                        </select>
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{msjproval}}</strong>
                                        </span>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Distrito</label>
                                        <select v-model="cbodistal" id="cbodistal" class="form-control">
                                            <option value="0">Seleccione</option>
                                            <option v-for="dist in distrito" v-bind:value="dist.iddistrito">{{dist.nom_dist}}</option>
                                        </select>
                                        <span class="invalid-feedback" role="alert">
                                            <strong>{{msjdistal}}</strong>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Dirección</label>
                                <textarea v-model="txtdiral" id="txtdiral" class="form-control"></textarea>
                                <span class="invalid-feedback" role="alert">
                                    <strong>{{msjdiral}}</strong>
                                </span>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-secondary" type="button" data-dismiss="modal" @click="limpiaralumno()">Cancelar</button>
                            <button class="btn btn-info" type="button" @click="guardaralumno()">Guardar</button>
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
                    txtdesc: "",
                    archivos: [],

                    usuario: [],
                    cbousu: 0,

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

                    txtdnial: "",
                    txtapeal: "",
                    txtnomal: "",
                    txtcelal: "",
                    txtdiral: "",
                    txtcoral: "",
                    cbodepal: 0,
                    cboproval: 0,
                    cbodistal: 0,

                    msjdnial: "",
                    msjapeal: "",
                    msjnomal: "",
                    msjcelal: "",
                    msjdiral: "",
                    msjcoral: "",
                    msjdepal: "",
                    msjproval: "",
                    msjdistal: "",

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

                    idpro: "",
                    selectindex: null,

                    cbotipocli: "DNI",

                    txtruc: "",
                    txtraz: "",
                    txtcoruc: "",
                    txtcelruc: "",
                    cbodepruc: 0,
                    cboprovruc: 0,
                    cbodistruc: 0,
                    txtdiruc: "",

                    msjruc: "",
                    msjraz: "",
                    msjcoruc: "",
                    msjcelruc: "",
                    msjdepruc: "",
                    msjprovruc: "",
                    msjdistruc: "",
                    msjdirruc: "",

                    divregal: false,
                    txtclidesc: '',

                    txtmdesc: '0',
                    txtmonto: '',
                    cbotipodesc: 'NO',

                    montopagar: '',
                },
                mounted: function () {
                    this.getusuario();
                    $("#txtalumno").attr('disabled', true);
                },
                methods: {
                    mostrardesc: function () {
                        if (this.cbotipodesc == "NO") {
                            $("#txtmdesc").attr('disabled', true);
                            this.txtmdesc = 0;
                        } else {
                            $("#txtmdesc").removeAttr("disabled");
                        }
                    },
                    cambiamonto: function () {
                        if (this.montopagar > this.txtmdesc) {
                            this.txtmonto = this.montopagar - this.txtmdesc;
                        } else {
                            toastr.warning("El descuento debe ser menor que el monto a pagar");
                        }

                    },
                    guardarclicom: function () {
                        if (this.iddetpros != "" && $("#txtidcliente").val() != "" && $("#txtidpem").val() != "") {
                            var data = new FormData();
                            data.append('detpro', this.iddetpros);
                            data.append('cli', $("#txtidcliente").val());
                            data.append('per', $("#txtidpem").val());
                            data.append('usu', this.cbousu);
                            axios.post('procesoprospectoadmin/guardarclicom', data).then(response => {
                                this.getclicom();
                                $("#txtidcliente").val("");
                                $("#txtcliente").val("");
                                $("#txtidpem").val("");
                                $("#txtalumno").val("");

                            }).catch(function (error) {
                                console.log(error);
                            });
                        } else {
                            toastr.warning("Seleccione un cliente");
                        }
                    },
                    getclicom: function () {
                        axios.get('procesoprospectoadmin/mclicom?detpro=' + this.iddetpros + '&usu=' + this.cbousu).then(response => {
                            if (response.data[0].tipo == "DNI") {
                                this.txtclidesc = "Cliente: " + response.data[0].persona;
                            }
                            if (response.data[0].tipo == "RUC") {
                                this.txtclidesc = "Cliente: " + response.data[0].cliente + "\nAlumno: " + response.data[0].persona;
                            }
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    mostraregal: function () {
                        if (this.cbotipocli == "DNI") {
                            $("#txtalumno").attr('disabled', true);
                            this.divregal = false;
                        }
                        if (this.cbotipocli == "RUC") {
                            $("#txtalumno").removeAttr("disabled");
                            this.divregal = true;
                        }
                        $("#txtidcliente").val("");
                        $("#txtcliente").val("");
                        $("#txtidpem").val("");
                        $("#txtalumno").val("");
                        $('#listacliente').hide();
                    },
                    mostrarform: function () {
                        if (this.cbotipocli == "DNI") {
                            this.divregal = false;
                            $('#mcliente').modal('toggle');
                        }
                        if (this.cbotipocli == "RUC") {
                            this.divregal = true;
                            $('#mclienteruc').modal('toggle');
                        }
                    },
                    completaralumno: function () {
                        if (this.txtdnial.length == 8) {
                            axios.get('persona/consulta/' + this.txtdnial).then(response => {
                                if (response.data.msj == "bd") {
                                    this.txtapeal = response.data.persona.apeper;
                                    this.txtnomal = response.data.persona.nomper;
                                    this.txtdiral = response.data.persona.dirper;
                                    this.txtcelal = response.data.persona.celper;
                                    this.txtcoral = response.data.persona.correoper;
                                    this.cbodepal = response.data.persona.distrito.provincia.departamento.iddepartamento;
                                    this.suportprovincia(this.cbodepal);
                                    this.cboproval = response.data.persona.distrito.provincia.idprovincia;
                                    this.suportdistrito(this.cboproval);
                                    this.cbodistal = response.data.persona.distrito.iddistrito;
                                }
                                if (response.data.msj == "api") {
                                    var p = JSON.parse(response.data.persona);
                                    this.txtapeal = p.data.apellido_paterno + " " + p.data.apellido_materno;
                                    this.txtnomal = p.data.nombres;
                                    this.txtdiral = p.data.direccion;
                                    this.cbodepal = p.data.ubigeo[0];
                                    this.suportprovincia(this.cbodepal);
                                    this.cboproval = p.data.ubigeo[1];
                                    this.suportdistrito(this.cboproval);
                                    this.cbodistal = p.data.ubigeo[2];
                                }
                            }).catch(function (error) {
                                console.log(error);
                            });
                        } else {
                            this.txtapeal = "";
                            this.txtnomal = "";
                            this.txtdiral = "";
                            this.txtcoral = "";
                            this.txtcelal = "";
                            this.cboproval = 0;
                            this.cbodistal = 0;
                            this.cbodepal = 0;
                            this.distritoal = [];
                            this.provinciaal = [];
                        }
                    },
                    limpiaralumno: function () {
                        this.txtdnial = "";
                        this.txtapeal = "";
                        this.txtnomal = "";
                        this.txtcelal = "";
                        this.txtdiral = "";
                        this.txtcoral = "";
                        this.cbodepal = 0;
                        this.cboproval = 0;
                        this.cbodistal = 0;

                        $('#txtdnial').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $('#txtapeal').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $('#txtnomal').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $('#txtcelal').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $('#txtdiral').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $('#txtcoral').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $('#cbodepal').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $('#cboproval').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $('#cbodistal').removeClass('form-control is-valid is-invalid').addClass('form-control');

                        this.msjdnial = "";
                        this.msjapeal = "";
                        this.msjnomal = "";
                        this.msjcelal = "";
                        this.msjdiral = "";
                        this.msjcoral = "";
                        this.msjdepal = "";
                        this.msjproval = "";
                        this.msjdistal = "";
                    },
                    limpiarruc: function () {
                        this.txtruc = "";
                        this.txtraz = "";
                        this.txtdiruc = "";
                        this.cbodepruc = 0;
                        this.cboprovruc = 0;
                        this.cbodistruc = 0;
                        this.txtcoruc = "";
                        this.txtcelruc = "";
                        this.distrito = [];
                        this.provincia = [];

                        $('#txtruc').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $('#txtraz').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $('#txtdiruc').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $('#cbodepruc').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $('#cboprovruc').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $('#cbodistruc').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $('#txtcoruc').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $('#txtcelruc').removeClass('form-control is-valid is-invalid').addClass('form-control');

                    },
                    completarruc: function () {
                        if (this.txtruc.length == 11) {
                            axios.get('empresa/consulta/' + this.txtruc).then(response => {
                                if (response.data.msj == "bd") {
                                    this.txtruc = response.data.empresa.rucemp;
                                    this.txtraz = response.data.empresa.razsoemp;
                                    this.txtdiruc = response.data.empresa.diremp;
                                    this.txtcoruc = response.data.empresa.correoemp;
                                    this.txtcelruc = response.data.empresa.celemp;
                                    this.cbodepruc = response.data.empresa.distrito.provincia.departamento.iddepartamento;
                                    this.suportprovincia(this.cbodepruc);
                                    this.cboprovruc = response.data.empresa.distrito.provincia.idprovincia;
                                    this.suportdistrito(this.cboprovruc);
                                    this.cbodistruc = response.data.empresa.distrito.iddistrito;
                                }
                                if (response.data.msj == "api") {
                                    var p = JSON.parse(response.data.empresa);
                                    this.txtraz = p.data.nombre_o_razon_social;
                                    this.txtdiruc = p.data.direccion;
                                    this.cbodepruc = p.data.ubigeo[0];
                                    this.suportprovincia(this.cbodepruc);
                                    this.cboprovruc = p.data.ubigeo[1];
                                    this.suportdistrito(this.cboprovruc);
                                    this.cbodistruc = p.data.ubigeo[2];
                                }
                            }).catch(function (error) {
                                console.log(error);
                            });
                        } else {
                            this.txtraz = "";
                            this.txtdiruc = "";
                            this.cbodepruc = 0;
                            this.cboprovruc = 0;
                            this.cbodistruc = 0;
                            this.txtcoruc = "";
                            this.txtcelruc = "";
                            this.distrito = [];
                            this.provincia = [];
                        }
                    },
                    selectrow: function (index) {
                        this.selectindex = index;
                        this.iddetpros = this.cliente[this.selectindex].iddetalleprospecto;
                    },
                    veriseleccion: function () {
                        if (this.iddetpros == "") {
                            toastr.warning("Seleecione un cliente");
                        } else {
                            $('#mprematricula').modal('toggle');
                            this.getcomanda();
                            this.getclicom();
                        }
                    },
                    abrirmodal: function (cli) {
                        $('#mactualizardesc').modal('toggle');
                        this.txtdesc = cli.descpros;
                        this.idpro = cli.fkidprospecto;
                    },
                    limpiardes: function () {
                        this.txtdesc = "";
                    },
                    actualizardes: function () {
                        var data = new FormData();
                        data.append('des', this.txtdesc);
                        data.append('idpro', this.idpro);
                        axios.post('procesoprospectoadmin/actualizardesc', data).then(response => {
                            $('#mactualizardesc').modal('toggle');
                            this.getcliente();
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    buscaralumno: function () {
                        var lista = $("#listaalumno");
                        var palabra = $("#txtalumno").val();
                        if (palabra.length > 0) {
                            $.ajax({
                                url: 'persona/buscar?bus=' + palabra,
                                type: 'GET',
                                success: function (data) {
                                    lista.find('li').remove();
                                    $(data).each(function (i, v) {
                                        lista.append('<li class="dropdown-item" onclick="setitemalumno(\'' + v.idpersona + '\',\'' + v.nombre + '\')">' + v.nombre + '</li>');
                                    });
                                    if (data != "") {
                                        $("#listaalumno").show();
                                    } else {
                                        $('#listaalumno').hide();
                                    }
                                }
                            });
                        } else {
                            $('#listaalumno').hide();
                        }
                    },
                    guardaralumno: function () {
                        var data = new FormData();
                        data.append('dni', this.txtdnial);
                        data.append('ape', this.txtapeal);
                        data.append('nom', this.txtnomal);
                        data.append('cel', this.txtcelal);
                        data.append('dir', this.txtdiral);
                        data.append('cor', this.txtcoral);
                        data.append('dep', this.cbodepal);
                        data.append('prov', this.cboproval);
                        data.append('dist', this.cbodistal);
                        axios.post('persona/guardar', data).then(response => {
                            if (response.data.resp == 'si') {
                                $('#txtdnial').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#txtapeal').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#txtnomal').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#txtcelal').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#txtdiral').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#txtcoral').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#cbodepal').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#cboproval').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#cbodistal').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#malumno').modal('toggle');
                                this.limpiaralumno();
                            } else {
                                if (response.data.dni != undefined) {
                                    this.msjdnial = response.data.dni;
                                    $('#txtdnial').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjdnial = '';
                                    $('#txtdnial').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                }
                                if (response.data.ape != undefined) {
                                    this.msjapeal = response.data.ape;
                                    $('#txtapeal').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjapeal = '';
                                    $('#txtapeal').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                }
                                if (response.data.nom != undefined) {
                                    this.msjnomal = response.data.nom;
                                    $('#txtnomal').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjnomal = '';
                                    $('#txtnomal').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                }
                                if (response.data.dir != undefined) {
                                    this.msjdiral = response.data.dir;
                                    $('#txtdiral').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjdiral = '';
                                    $('#txtdiral').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                }
                                if (response.data.cor != undefined) {
                                    this.msjcoral = response.data.cor;
                                    $('#txtcoral').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjcoral = '';
                                    $('#txtcoral').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                }
                                if (response.data.cel != undefined) {
                                    this.msjcelal = response.data.cel;
                                    $('#txtcelal').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjcelal = '';
                                    $('#txtcelal').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                }
                                if (response.data.dep != undefined) {
                                    this.msjdepal = response.data.dep;
                                    $('#cbodepal').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjdepal = '';
                                    $('#cbodepal').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                }
                                if (response.data.prov != undefined) {
                                    this.msjproval = response.data.prov;
                                    $('#cboproval').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjproval = '';
                                    $('#cboproval').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                }
                                if (response.data.dist != undefined) {
                                    this.msjdistal = response.data.dist;
                                    $('#cbodistal').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjdistal = '';
                                    $('#cbodistal').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                }
                            }


                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    actualizartabla: function () {
                        this.getcliente();
                    },
                    guardaruc: function () {
                        var data = new FormData();
                        data.append('ruc', this.txtruc);
                        data.append('raz', this.txtraz);
                        data.append('dir', this.txtdiruc);
                        data.append('cel', this.txtcelruc);
                        data.append('cor', this.txtcoruc);
                        data.append('dep', this.cbodepruc);
                        data.append('prov', this.cboprovruc);
                        data.append('dist', this.cbodistruc);
                        axios.post('cliente/ruc/guardar', data).then(response => {

                            if (response.data.resp == 'si') {
                                $('#txtruc').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#txtraz').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#txtdiruc').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#txtcelruc').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#txtdir').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#txtcoruc').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#cbodepruc').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#cboprovruc').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#cbodistruc').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#mclienteruc').modal('toggle');
                                this.limpiarruc();
                            } else {
                                if (response.data.ruc != undefined) {
                                    this.msjruc = response.data.ruc;
                                    $('#txtruc').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjruc = '';
                                    $('#txtruc').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                }
                                if (response.data.raz != undefined) {
                                    this.msjraz = response.data.raz;
                                    $('#txtraz').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjraz = '';
                                    $('#txtraz').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                }
                                if (response.data.dir != undefined) {
                                    this.msjdiruc = response.data.dir;
                                    $('#txtdiruc').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjdiruc = '';
                                    $('#txtdiruc').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                }
                                if (response.data.cor != undefined) {
                                    this.msjcoruc = response.data.cor;
                                    $('#txtcoruc').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjcoruc = '';
                                    $('#txtcoruc').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                }
                                if (response.data.cel != undefined) {
                                    this.msjcelruc = response.data.cel;
                                    $('#txtcelruc').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjcelruc = '';
                                    $('#txtcelruc').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                }
                                if (response.data.dep != undefined) {
                                    this.msjdepruc = response.data.dep;
                                    $('#cbodepruc').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjdepruc = '';
                                    $('#cbodepruc').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                }
                                if (response.data.prov != undefined) {
                                    this.msjprovruc = response.data.prov;
                                    $('#cboprovruc').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjprovruc = '';
                                    $('#cboprovruc').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                }
                                if (response.data.dist != undefined) {
                                    this.msjdistruc = response.data.dist;
                                    $('#cbodistruc').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjdistruc = '';
                                    $('#cbodistruc').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                }
                            }


                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    getdistritoruc: function () {
                        var url = 'persona/distrito/' + this.cboprovruc;
                        axios.get(url).then(response => {
                            this.cbodistruc = 0;
                            this.distrito = response.data;
                        })
                    },
                    getprovinciaruc: function () {
                        var url = 'persona/provincia/' + this.cbodepruc;
                        axios.get(url).then(response => {
                            this.cboprovruc = 0;
                            this.provincia = response.data;
                            this.cbodistruc = 0;
                            this.distrito = [];
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
                    config: function (tab) {
                        $("#" + tab).DataTable().destroy();
                        this.tabla(tab);
                    },
                    cambiauser: function () {
                        if (this.cbousu != 0) {
                            this.verificarsesion();
                            this.getcliente();
                            this.getdepartamento();
                            this.getbanco();
                            $("#txtalumno").attr('disabled', true);
                            $("#txtmdesc").attr('disabled', true);
                        }
                    },
                    getbanco: function () {
                        axios.get('procesoprospectoadmin/mbanco').then(response => {
                            this.banco = response.data;
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    getusuario: function () {
                        axios.get('procesoprospectoadmin/musuario').then(response => {
                            this.usuario = response.data;
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    getArchivos(event) {
                        this.archivos = Array.from(event.target.files);
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
                        axios.get('procesoprospectoadmin/verificasesion?usu=' + this.cbousu).then(response => {
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
                                url: 'cliente/buscar?bus=' + palabra + "&tipo=" + this.cbotipocli,
                                type: 'GET',
                                success: function (data) {
                                    lista.find('li').remove();
                                    $(data).each(function (i, v) {
                                        lista.append('<li class="dropdown-item" onclick="setitemcliente(\'' + v.idcliente + '\',\'' + v.cliente + '\',\'' + v.idpem + '\',\'' + v.tipocli + '\')">' + v.cliente + '</li>');
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
                    siguiente1: function () {
                        if (this.txtclidesc != "") {
                            stepper.next();
                            this.getcomonto();
                        } else {
                            toastr.warning("Tiene que registrar un cliente");
                        }
                    },
                    finalizar: function () {
                        if (this.archivos.length == 0) {
                            toastr.warning("Seleccione un archivo");
                        } else {
                            if (this.cbotipodesc == "SI") {
                                if (this.txtmonto > this.txtmdesc && this.txtmdesc != 0) {
                                    this.guardarpp();
                                } else {
                                    toastr.warning("Ingrese el monto de descuento");
                                }
                            } else {
                                this.guardarpp();
                            }
                        }
                    },
                    guardarpp: function () {
                        var data = new FormData();
                        data.append('tip', this.cbotipomat);
                        data.append('detpro', this.iddetpros);
                        this.archivos.forEach(file => {
                            data.append('vau', file);
                        });
                        data.append('ban', this.cboban);
                        data.append('usu', this.cbousu);
                        data.append('descu', this.txtmdesc);
                        data.append('band', this.cbotipodesc);
                        axios.post('procesoprospectoadmin/finalizar', data).then(response => {
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
                        axios.post('cliente/dni/guardar', data).then(response => {
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
                        axios.get('procesoprospectoadmin/paquetecurso?idpaq=' + this.cbopaquete).then(response => {
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
                        axios.post('procesoprospectoadmin/eliminacomanda', data).then(response => {
                            this.getcomanda();
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    getcurso: function () {
                        axios.get('procesoprospectoadmin/mcurso').then(response => {
                            this.curso = response.data;
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    getcomanda: function () {
                        axios.get('procesoprospectoadmin/comanda?iddetpro=' + this.iddetpros + '&usu=' + this.cbousu).then(response => {
                            this.comanda = response.data;
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    getcomonto: function () {
                        axios.get('procesoprospectoadmin/montopre?iddetpro=' + this.iddetpros + '&usu=' + this.cbousu).then(response => {
                            this.montopagar = response.data;
                            this.txtmonto = this.montopagar;

                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    getpaquete: function () {
                        axios.get('procesoprospectoadmin/mpaquete').then(response => {
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
                        data.append('usu', this.cbousu);
                        data.append('tipo', this.cbotipo);
                        data.append('detpro', this.iddetpros);
                        axios.post('procesoprospectoadmin/guardar', data).then(response => {
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
                        $("#txtmdesc").attr('disabled', true);
                        this.txtmdesc = '0';
                        this.txtmonto = '';
                        this.cbotipodesc = 'NO';
                        $("#imagePreview").html("");
                        this.txtclidesc = "";

                        $("#txtidcliente").val("");
                        $("#txtcliente").val("");
                        $("#txtidpem").val("");
                        $("#txtalumno").val("");
                        this.txtclidesc = "";
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
                        this.selectindex = null;

                        this.msjcliente = '';
                        this.msjtipomat = '';
                        this.msjvau = '';
                        this.msjban = '';
                        this.cboban = 0;
                        $('#txtcliente').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $('#cbotipomat').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $('#cboban').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $('#txtvau').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $("#txtvau").val("");
                        this.archivos = [];
                    },
                    seleccionar: function (cli) {
                        this.iddetpros = cli.iddetalleprospecto;
                        this.getcomanda();
                    },
                    getcliente: function () {
                        axios.get('procesoprospectoadmin/mostrar?usu=' + this.cbousu).then(response => {
                            this.cliente = response.data;
                            this.config("tabdatos");
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    getclientever: function () {
                        axios.get('procesoprospectoadmin/mostrarver?usu=' + this.cbousu).then(response => {
                            this.clientever = response.data;
                            this.config("tabdato");
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    cambiarcal: function (cli) {
                        Swal.fire({
                            title: "Mensaje del Sistema",
                            text: "¿Desea cambiar a estado Caliente?",
                            icon: "warning",
                            showCancelButton: true,
                            confirmButtonColor: "#3085d6",
                            cancelButtonColor: "#d33",
                            confirmButtonText: "Si, Cambiar"
                        }).then((result) => {
                            if (result.isConfirmed) {
                                var data = new FormData();
                                data.append('esta', "CALIENTE");
                                data.append('idpro', cli.fkidprospecto);
                                data.append('iddetpro', cli.iddetalleprospecto);
                                axios.post('procesoprospectoadmin/actualizarestado', data).then(response => {
                                    this.getcliente();
                                }).catch(error => {
                                })
                            } else {
                                this.iddetpros = "";
                                this.selectindex = null;
                            }
                        });
                    },
                    cambiarti: function (cli) {
                        Swal.fire({
                            title: "Mensaje del Sistema",
                            text: "¿Desea cambiar a estado Tibio?",
                            icon: "warning",
                            showCancelButton: true,
                            confirmButtonColor: "#3085d6",
                            cancelButtonColor: "#d33",
                            confirmButtonText: "Si, Cambiar"
                        }).then((result) => {
                            if (result.isConfirmed) {
                                var data = new FormData();
                                data.append('esta', "TIBIO");
                                data.append('idpro', cli.fkidprospecto);
                                data.append('iddetpro', cli.iddetalleprospecto);
                                axios.post('procesoprospectoadmin/actualizarestado', data).then(response => {
                                    this.getcliente();
                                }).catch(error => {
                                })
                            } else {
                                this.iddetpros = "";
                                this.selectindex = null;
                            }
                        });
                    },
                    cambiarfri: function (cli) {
                        Swal.fire({
                            title: "Mensaje del Sistema",
                            text: "¿Desea cambiar a estado Frio?",
                            icon: "warning",
                            showCancelButton: true,
                            confirmButtonColor: "#3085d6",
                            cancelButtonColor: "#d33",
                            confirmButtonText: "Si, Cambiar"
                        }).then((result) => {
                            if (result.isConfirmed) {
                                var data = new FormData();
                                data.append('esta', "FRIO");
                                data.append('idpro', cli.fkidprospecto);
                                data.append('iddetpro', cli.iddetalleprospecto);
                                axios.post('procesoprospectoadmin/actualizarestado', data).then(response => {
                                    this.getcliente();
                                }).catch(error => {
                                })
                            } else {
                                this.iddetpros = "";
                                this.selectindex = null;
                            }
                        });
                    },
                },
            });
            function setitemcliente(id, cli, idpem, tip) {
                $("#txtidcliente").val(id);
                $("#txtcliente").val(cli);
                if (tip === "DNI") {
                    $("#txtidpem").val(idpem);
                    $("#txtalumno").val(cli);
                }
                $('#listacliente').hide();
            }
            function setitemalumno(id, cli) {
                $("#txtidpem").val(id);
                $("#txtalumno").val(cli);
                $('#listaalumno').hide();
            }
            const fileInput = document.getElementById('txtvau');
            const imagePreview = document.getElementById('imagePreview');

            function updateImagePreview() {
                // Clear previous previews
                imagePreview.innerHTML = '';

                const files = Array.from(fileInput.files);
                files.forEach(file => {
                    if (file.type.startsWith('image/')) {
                        const reader = new FileReader();

                        reader.onload = function (event) {
                            const img = document.createElement('img');
                            img.src = event.target.result;

                            const container = document.createElement('div');
                            container.classList.add('image-item');

                            const removeButton = document.createElement('button');
                            removeButton.textContent = '×';
                            removeButton.onclick = function () {
                                removeImage(file);
                            };

                            container.appendChild(img);
                            container.appendChild(removeButton);
                            imagePreview.appendChild(container);
                        };

                        reader.readAsDataURL(file);
                    }
                });
            }

            function removeImage(fileToRemove) {
                const files = Array.from(fileInput.files).filter(file => file !== fileToRemove);
                const dataTransfer = new DataTransfer();
                files.forEach(file => dataTransfer.items.add(file));
                fileInput.files = dataTransfer.files;
                updateImagePreview();
            }
            fileInput.addEventListener('change', updateImagePreview);

        </script>
    </body>
</html>


