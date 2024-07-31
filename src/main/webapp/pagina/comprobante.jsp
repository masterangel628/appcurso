<%-- 
    Document   : menu
    Created on : 28 sept. 2022, 10:18:15
    Author     : Asus
--%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <meta name="description" content="Sistema de Gestión Cursos - ISIPP">
        <meta name="author" content="Miguel Ángel Toledo Cordova">
        <title>Ver comprobante</title>
        <link href="public/dist/img/icono.png" rel="icon">
        <%@include file="estilocss.jsp" %>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.3.1/styles/default.min.css" rel="stylesheet">
        <style>
            pre {
                height: 50vh; 
                overflow: auto; 
                white-space: pre-wrap; 
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
                                <h1>Comprobantes</h1>
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
                                            Lista de Comprobantes
                                        </h3>
                                    </div>
                                    <div class="card-body">

                                        <div class="table-responsive">
                                            <table class="table table-striped table-bordered table-hover" id="tabdatos">
                                                <thead class="table-success">
                                                    <tr>
                                                        <th>Comprobante</th>
                                                        <th>Número</th>
                                                        <th>Cliente</th>
                                                        <th>Monto</th>
                                                        <th>Fecha</th>
                                                        <th>Descripción</th>
                                                        <th>Ver</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr v-for="com in comprobante">
                                                        <td>{{com.nomtipcom}}</td>
                                                        <td>{{com.numero}}</td>
                                                        <td>{{com.nombre}}</td>
                                                        <td>{{com.mcigv_ven}}</td>
                                                        <td>{{com.fecmat}} {{com.horamat}}</td>
                                                        <td>{{com.desccomp}}</td>
                                                        <td>
                                                            <button class="btn btn-info btn-sm" @click="pdf(com)">PDF</button>
                                                            <button class="btn btn-info btn-sm" @click="xml(com)">XML</button>
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
            <div class="modal fade" id="modxml" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header bg-info">
                            <h5 class="modal-title" id="staticBackdropLabel">Visualizar Comprobante</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <pre><code ref="xmlCode" class="xml">{{ txtxml }}</code></pre>
                        </div>
                    </div>
                </div>
            </div>
            <%@include file="footer.jsp" %>
        </div>
        <%@include file="scrip.jsp" %>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.3.1/highlight.min.js"></script>
        <script>
let app = new Vue({
    el: '#app',
    data: {
        comprobante: [],
        compurl: "",
        txtxml: "",
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

        getbanco: function () {
            axios.get('comprobante/mcomprobante').then(response => {
                this.comprobante = response.data;
                this.config();
            }).catch(function (error) {
                console.log(error);
            });
        },
        pdf: function (com) {
            var data = new FormData();
            data.append('com', com.idcomprobante);
            axios.post('comprobante/pdf', data, {responseType: 'blob'}).then(response => {
                const blob = new Blob([response.data], {type: 'application/pdf'});
                this.compurl = URL.createObjectURL(blob);
                $('#modcomprobante').modal('toggle');
            }).catch(function (error) {
                console.log(error);
            });
        },
        xml: function (com) {
            var data = new FormData();
            data.append('com', com.idcomprobante);
            axios.post('comprobante/xml', data).then(response => {
                this.txtxml = response.data;
                $('#modxml').modal('toggle');
                this.$nextTick(() => {
                    this.highlightXml();
                });

            }).catch(function (error) {
                console.log(error);
            });
        },
        highlightXml() {
            if (this.$refs.xmlCode) {
                hljs.highlightBlock(this.$refs.xmlCode);
            }
        },
    },
});
        </script>
    </body>
</html>