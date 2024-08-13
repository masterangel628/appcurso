<%-- 
    Document   : menu
    Created on : 28 sept. 2022, 10:18:15
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
                                            <table class="table table-striped table-bordered table-hover" id="tabdatos">
                                                <thead class="table-success">
                                                    <tr>
                                                        <th>Número</th>
                                                        <th>Cliente</th>
                                                        <th>Monto</th>
                                                        <th>Grupo</th>
                                                        <th>Asesor</th>
                                                        <th>Fecha</th>
                                                        <th>Acción</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr v-for="mat in matricula">
                                                        <td width="15%">{{mat.nummat}}</td>
                                                        <td>{{mat.documento}} - {{mat.nombre}}</td>
                                                        <td width="15%">{{mat.montomat}}</td> 
                                                        <td width="15%">{{mat.grupomat}}</td>
                                                        <td width="15%">{{mat.nomusu}}</td>
                                                        <td width="15%">{{mat.fecmat}}</td>
                                                        <td width="15%">
                                                            <button title="Ver Váucher" data-toggle="modal" @click="getvaucher(mat)" data-target="#mvervaucher" class="btn btn-info btn-sm"><i class="fa fa-eye"></i></button>
                                                            <button title="Verificar Váucher" @click="selectmatricula(mat)" data-toggle="modal" data-target="#mvervecom"  class="btn btn-success btn-sm"><i class="fas fa-check"></i></button>
                                                            <button title="Anular Matricula" data-toggle="modal" @click="seleccionar(mat)" data-target="#mregvaucher" class="btn btn-danger btn-sm"><i class="fas fa-window-close"></i></button>
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

            <div class="modal fade" id="mregvaucher" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-scrollable">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color: #ff1a1a;color: #ffffff;">
                            <h5 class="modal-title" id="staticBackdropLabel">Anular Matrícula</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close" @click="limpiar()">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="form-group">
                                <label>Cliente</label>
                                <input type="text" v-model="txtcliente" class="form-control" disabled="true">
                            </div>
                            <div class="form-group">
                                <label>Descripción</label>
                                <textarea id="txtdesc" v-model="txtdesc" class="form-control"></textarea> 
                                <span class="invalid-feedback" role="alert">
                                    <strong>{{msjdes}}</strong>
                                </span>
                            </div>
                            <div class="form-group">
                                <label>Váucher</label>
                                <input type="file" id="txtvau" multiple  @change="getArchivos" accept=".png,.jpg,.jpeg" class="form-control" autocomplete="off">
                                <span class="invalid-feedback" role="alert">
                                    <strong>{{msjvau}}</strong>
                                </span>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-info" type="button" @click="cancelar()">Anular</button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="mvervaucher" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg modal-dialog-scrollable">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color: #ff1a1a;color: #ffffff;">
                            <h5 class="modal-title" id="staticBackdropLabel">Ver Váucher</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close" @click="limpiar()">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="form-group col-md-6">
                                    <label>Cliente</label>
                                    <input type="text" v-model="txtcliente" class="form-control" disabled="true">
                                </div>
                                <div class="form-group col-md-6">
                                    <label>Banco</label>
                                    <input type="text" v-model="txtbanco" class="form-control" disabled="true">
                                </div>
                            </div>


                            <div class="row">
                                <div class="col-md-6" v-for="vau in vaucher">
                                    <div class="card mb-2 bg-gradient-dark">
                                        <img class="card-img-top" v-bind:src="'matricula/images/'+vau.nomvau" alt="Dist Photo 1">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="mvervecom" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg modal-dialog-scrollable">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color: #ff1a1a;color: #ffffff;">
                            <h5 class="modal-title" id="staticBackdropLabel">Verificar matrícula y enviar comprobante</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="form-group col-md-6">
                                    <label>Comprobante a emitir</label>
                                    <select v-model="cbotipcom" class="form-control" disabled="true">
                                        <option value="0">Seleccione</option>
                                        <option v-for="tc in tipocomp" v-bind:value="tc.idtipocomprobante">{{tc.nomtipcom}}</option>
                                    </select>
                                </div>
                                <div class="form-group  col-md-6">
                                    <label>Número</label>
                                    <div class="input-group">
                                        <input type="text" v-model="txtnum" class="form-control" readonly="true">
                                        <div class="input-group-append">
                                            <button class="btn btn-primary" @click="getnumero()" title="Cargar número"><i class="fas fa-sync-alt"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                 <label>Opción</label>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="rad" id="radgv" value="1" v-model="radoption">
                                    <label class="form-check-label" for="radgv">Validar la matrícula</label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="rad" id="rades" value="2" v-model="radoption">
                                    <label class="form-check-label" for="rades">Validar la matrícula y enviar comprobante a Sunat</label>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancelar</button>
                            <button class="btn btn-info" type="button" @click="verificar()">Guardar</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal fade" id="modcomprobante" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header bg-info">
                            <h5 class="modal-title" id="staticBackdropLabel">Visualizar Comprobante</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="table-responsive">
                                <iframe v-bind:src="compurl" style="width: 100%; height: 500px;"></iframe>
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
                    cbotipcom: 0,
                    txtnum: "",
                    tipocomp: [],
                    radoption: 1,

                    archivos: [],
                    txtdesc: "",
                    msjdes: "",
                    msjvau: "",
                    matricula: [],
                    idmat: "",
                    txtcliente: "",
                    vaucher: [],
                    compurl: "",
                    txtbanco: '',
                    
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
                    pdf: function (com) {
                        var data = new FormData();
                        data.append('com', com);
                        axios.post('comprobante/pdf', data, {responseType: 'blob'}).then(response => {
                            const blob = new Blob([response.data], {type: 'application/pdf'});
                            this.compurl = URL.createObjectURL(blob);
                            $('#modcomprobante').modal('toggle');
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    getmatricula: function () {
                        axios.get('matricula/mmatricula').then(response => {
                            this.matricula = response.data;
                            this.config();
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    selectmatricula: function (mat) {
                        this.idmat = mat.idmatricula;
                        this.gettipocomprobante();
                        if (mat.tipocli == "RUC") {
                            this.cbotipcom = "1";
                            this.getnumero();
                        }
                        if (mat.tipocli == "DNI") {
                            this.cbotipcom = "2";
                            this.getnumero();
                        }
                    },
                    gettipocomprobante: function () {
                        axios.get('matricula/mtipocomprobante').then(response => {
                            this.tipocomp = response.data;
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    getnumero: function () {
                        if (this.cbotipcom != 0) {
                            axios.get('matricula/mnumero?tipo=' + this.cbotipcom).then(response => {
                                this.txtnum = response.data[0].getnum;
                            }).catch(function (error) {
                                console.log(error);
                            });
                        }
                    },
                    getvaucher: function (mat) {
                        this.txtcliente = mat.documento + " - " + mat.nombre;
                        this.txtbanco = mat.nomban;
                        axios.get('matricula/mvaucher/' + mat.idmatricula).then(response => {
                            this.vaucher = response.data;
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    getArchivos(event) {
                        this.archivos = Array.from(event.target.files);
                    },
                    verificar: function () {
                        var data = new FormData();
                        data.append('mat', this.idmat);
                        data.append('tip', this.cbotipcom);
                        data.append('num', this.txtnum);
                       
                        data.append('ev', this.radoption);
                        
                        axios.post('matricula/verificar', data).then(response => {
                            this.getmatricula();
                            $('#mvervecom').modal('toggle');
                            if (response.data.envio == "si") {
                                this.pdf(response.data.resp);
                            } else {
                                toastr.success(response.data.resp);
                            }
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    seleccionar: function (mat) {
                        this.idmat = mat.idmatricula;
                        this.txtcliente = mat.documento + " - " + mat.nombre;
                    },
                    limpiar: function () {
                        this.txtdesc = "";
                        this.txtvau = "";

                        $('#txtdesc').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $('#txtvau').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        this.archivos = [];
                        this.idmat = "";
                    },
                    cancelar: function () {
                        var url = "";
                        var data = new FormData();
                        data.append('mat', this.idmat);
                        data.append('des', this.txtdesc);
                        if (this.archivos.length > 0) {
                            url = "matricula/cancelarall";
                            this.archivos.forEach(file => {
                                data.append('files', file);
                            });
                        } else {
                            url = "matricula/cancelar";
                        }
                        axios.post(url, data).then(response => {
                            if (response.data.resp == 'si') {
                                $('#txtdesc').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#txtvau').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#mregvaucher').modal('toggle');
                                this.getmatricula();
                                this.limpiar();
                            } else {
                                if (response.data.des != undefined) {
                                    this.msjdes = response.data.des;
                                    $('#txtdesc').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjdes = '';
                                    $('#txtdesc').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                }
                                if (response.data.vau != undefined) {
                                    this.msjvau = response.data.vau;
                                    $('#txtvau').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjvau = '';
                                    $('#txtvau').removeClass('form-control is-invalid').addClass('form-control is-valid');
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
