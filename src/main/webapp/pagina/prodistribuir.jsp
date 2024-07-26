<%-- 
    Document   : prodistribuir
    Created on : 18 may 2024, 17:17:09
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
        <title>Distribuir Clientes</title>
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
                                <h1>Distribuir Clientes</h1>
                            </div>
                            <div class="col-sm-6">
                                <ol class="breadcrumb float-sm-right">

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
                                            Lista de usuarios
                                        </h3>
                                    </div>
                                    <div class="card-body">
                                        <div class="table-responsive">
                                            <table class="table table-striped table-bordered table-hover" id="tabdatos">
                                                <thead class="table-success">
                                                    <tr>
                                                        <th>DNI</th>
                                                        <th>Nombre</th>
                                                        <th>Rol</th>
                                                        <th>Clientes asignados</th>
                                                        <th>Acción</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr v-for="usu ,key in usuario">
                                                        <td width="10%">{{usu.dniper}}</td>
                                                        <td>{{usu.usuario}}</td>
                                                        <td width="10%">{{usu.role_name}}</td>
                                                        <td width="20%">{{usu.cliente}}</td>
                                                        <td width="10%">
                                                            <button title="Ver clientes"  class="btn btn-info btn-sm" @click="getcliente(usu.id)" data-toggle="modal" data-target="#mvercliente"><i class="fa fa-eye"></i></button>
                                                            <button title="Asignar clientes" @click="seleccionar(usu)" data-toggle="modal" data-target="#mdistribuir" class="btn btn-primary btn-sm"><i class="fa fa-plus"></i></button>
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
            <div class="modal fade" id="mvercliente" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg modal-dialog-scrollable">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color: #ff1a1a;color: #ffffff;">
                            <h5 class="modal-title" id="staticBackdropLabel">Ver cliente</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover">
                                    <thead class="table-success">
                                        <tr>
                                            <th>Nombre</th>
                                            <th>Celular</th>
                                            <th>Fecha de registro</th>
                                            <th>Estado</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr v-for="cli in cliente">
                                            <td>{{cli.nompros}}</td>
                                            <td>{{cli.celpros}}</td>
                                            <td>{{cli.fechorpros}}</td>
                                            <td>{{cli.estatimpros}}</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>                           
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal fade" id="mdistribuir" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color: #ff1a1a;color: #ffffff;">
                            <h5 class="modal-title" id="staticBackdropLabel">Asignar clientes</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close" @click="limpiar()">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label>Usuario</label>
                                <input type="text" class="form-control"  v-model="txtusu" readonly="true">
                            </div>
                            <div class="form-group">
                                <label>Información del cliente</label>
                                <textarea class="form-control" v-model="txtinfo" rows="3" readonly="true"></textarea>                                
                            </div>
                            <div class="form-group">
                                <label>Cantidad</label>
                                <input type="text" class="form-control" id="txtcant" v-model="txtcant" autocomplete="off">
                                <span class="invalid-feedback" role="alert">
                                    <strong>{{msjcant}}</strong>
                                </span>
                            </div>
                            <div class="form-group">
                                <label>Estado</label>
                                <select v-model="cboesta" id="cboesta" class="form-control">
                                    <option value="0">Seleccione</option>
                                    <option v-for="esta in estado" v-bind:value="esta.estatimpros">{{esta.estatimpros}}</option>
                                </select>
                                <span class="invalid-feedback" role="alert">
                                    <strong>{{msjesta}}</strong>
                                </span>
                            </div>
                            <center v-if="cenlod">
                                <div class="spinner-border" style="width: 5rem; height: 5rem;" role="status">
                                    <span class="sr-only">Loading...</span>
                                </div>
                            </center>
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
                    usuario: [],
                    cliente: [],
                    caliente: "",
                    tibio: "",
                    frio: "",
                    txtinfo: "",
                    estado: [],
                    cboesta: 0,
                    txtcant: "",
                    msjcant: "",
                    msjesta: "",
                    idusu: "",
                    cenlod: false,
                    txtusu: "",
                },
                mounted: function () {
                    this.getusuario();
                    this.getinfocliente();
                    this.getestado();
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
                    config: function () {
                        $("#tabdatos").DataTable().destroy();
                        this.tabla();
                    },
                    getusuario: function () {
                        axios.get('distribuircliente/musuario').then(response => {
                            this.usuario = response.data;
                            this.config();
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    getcliente: function (usu) {
                        axios.get('distribuircliente/mcliente?usu=' + usu).then(response => {
                            this.cliente = response.data;
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    getinfocliente: function () {
                        axios.get('distribuircliente/infocliente').then(response => {
                            this.caliente = response.data.caliente;
                            this.tibio = response.data.tibio;
                            this.frio = response.data.frio;
                            this.txtinfo = "- Hay " + this.caliente + " clientes con estado caliente\n- Hay " + this.tibio + " clientes con estado tibio\n- Hay " + this.frio + " clientes con estado frio";
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    getestado: function () {
                        axios.get('distribuircliente/mestado').then(response => {
                            this.estado = response.data;
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    seleccionar: function (usu) {
                        this.idusu = usu.id;
                        this.txtusu = usu.usuario;
                    },
                    limpiar: function () {
                        this.txtcant = "";
                        this.cboesta = 0;
                        $('#txtcant').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $('#cboesta').removeClass('form-control is-valid is-invalid').addClass('form-control');
                    },
                    guardar: function () {
                        this.cenlod = true;
                        var data = new FormData();
                        data.append('esta', this.cboesta);
                        data.append('usu', this.idusu);
                        data.append('cant', this.txtcant);
                        axios.post('distribuircliente/distribuir', data).then(response => {
                            if (response.data.resp == 'si') {
                                if (response.data.msj == 'si') {
                                    $('#cboesta').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                    $('#txtcant').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                    this.getinfocliente();
                                    this.getestado();
                                    this.limpiar();
                                    this.getusuario();
                                    $('#mdistribuir').modal('toggle');
                                    toastr.success("Los clientes se asignaron correctamente");
                                    this.cenlod = false;
                                } else {
                                    toastr.warning(response.data.msj);
                                    this.cenlod = false;
                                }
                                
                            } else {
                                this.cenlod = false;
                                if (response.data.cant != undefined) {
                                    this.msjcant = response.data.cant;
                                    $('#txtcant').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjcant = '';
                                    $('#txtcant').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                }
                                if (response.data.esta != undefined) {
                                    this.msjesta = response.data.esta;
                                    $('#cboesta').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjesta = '';
                                    $('#cboesta').removeClass('form-control is-invalid').addClass('form-control is-valid');
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

