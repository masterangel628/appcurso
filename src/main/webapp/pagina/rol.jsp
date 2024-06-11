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
        <meta name="description" content="Sistema de Gestión Cursos - ISIPP">
	<meta name="author" content="Miguel Ángel Toledo Cordova">
        <title>Rol</title>
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
                                <h1>Gestión de roles</h1>
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
                                            Lista de roles
                                        </h3>
                                    </div>
                                    <div class="card-body">
                                        <div class="table-reponsive">
                                            <table class="table table-striped table-bordered table-hover">
                                                <thead class="table-success">
                                                    <tr>
                                                        <th>N° orden</th>
                                                        <th>Rol</th>
                                                        <th>Gestión</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr v-for="ro ,key in roles">
                                                        <td>{{key+1}}</td>
                                                        <td>{{ ro.role}}</td>
                                                        <td>
                                                            <button class="btn btn-primary btn-sm" title="Ver permisos" data-toggle="modal" data-target="#modverpermiso" @click="seleccionar(ro)"><i class="fa fa-eye"></i></button>
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
            <div class="modal fade" id="modverpermiso" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg modal-dialog-scrollable">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color: #ff1a1a; color: #ffffff">
                            <h5 class="modal-title" id="staticBackdropLabel">Gestión de permisos</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="table-reponsive">
                                        <h6>Lista de permisos</h6>
                                        <table class="table table-striped table-bordered table-hover">
                                            <thead class="table-success">
                                                <tr>
                                                    <th>N° orden</th>
                                                    <th>Rol</th>
                                                    <th>Gestión</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr v-for="per ,key in permiso">
                                                    <td>{{key+1}}</td>
                                                    <td>{{ per[1] }}</td>
                                                    <td>
                                                        <button class="btn btn-primary btn-sm" @click="asignar(per)">Asignar</button>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="table-reponsive">
                                        <h6>Permiso Asignado al Rol: {{txtrolsel}}</h6>
                                        <table class="table table-striped table-bordered table-hover">
                                            <thead class="table-success">
                                                <tr>
                                                    <th>N° orden</th>
                                                    <th>Rol</th>
                                                    <th>Gestión</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr v-for="rolperm ,key in permisorol">
                                                    <td>{{key+1}}</td>
                                                    <td>{{ rolperm[2] }}</td>
                                                    <td>
                                                        <button class="btn btn-primary btn-sm" @click="quitar(rolperm)">Quitar</button>
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
            </div>
            <%@include file="footer.jsp" %>
        </div>
        <%@include file="scrip.jsp" %>
        <script>
            let app = new Vue({
                el: '#app',
                data: {
                    roles: [],
                    txtrolsel: "",
                    permisorol: [],
                    permiso: [],
                    idrol: 0,
                },
                mounted: function () {
                    this.getrol();
                },
                methods: {
                    asignar: function (per) {
                        var data = new FormData();
                        data.append('rol', this.idrol);
                        data.append('per', per[0]);
                        axios.post('rol/asignarpermiso', data).then(response => {
                            this.getpermiso();
                            this.getpermisorol();
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    quitar: function (per) {
                        var data = new FormData();
                        data.append('rol', this.idrol);
                        data.append('per', per[1]);
                        axios.post('rol/quitarpermiso', data).then(response => {
                            this.getpermiso();
                            this.getpermisorol();
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    getpermiso: function () {
                        var ruta = 'rol/mpermiso?rol=' + this.idrol;
                        axios.get(ruta).then(response => {
                            this.permiso = response.data;
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    getpermisorol: function () {
                        var ruta = 'rol/mpermisorol?rol=' + this.idrol;
                        axios.get(ruta).then(response => {
                            this.permisorol = response.data;
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    getrol: function () {
                        axios.get('rol/mrol').then(response => {
                            this.roles = response.data;
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    seleccionar: function (ro) {
                        this.txtrolsel = ro.role;
                        this.idrol = ro.id;
                        this.getpermiso();
                        this.getpermisorol();
                    },
                },
            });
        </script>
    </body>
</html>
