<%-- 
    Document   : perfil
    Created on : 27 may 2024, 13:25:30
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
        <title>Perfil</title>
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
                                <h1>Perfil</h1>
                            </div>
                        </div>
                    </div>
                </div>
                <section class="content">
                    <div class="container-fluid">
                        <div class="row">

                            <div class="col-md-12">
                                <div class="card">
                                    <div class="card-header p-2">
                                        <ul class="nav nav-pills">
                                            <li class="nav-item"><a class="nav-link active" href="#perfil" data-toggle="tab">Editar perfil</a></li>
                                            <li class="nav-item"><a class="nav-link" href="#cambiar" data-toggle="tab">Cambiar contraseña</a></li>
                                        </ul>
                                    </div><!-- /.card-header -->
                                    <div class="card-body">
                                        <div class="tab-content">
                                            <div class="active tab-pane" id="perfil">
                                                <div class="form-horizontal">
                                                    <div class="form-group row">
                                                        <label for="txtape" class="col-sm-2 col-form-label">Apellido</label>
                                                        <div class="col-sm-10">
                                                            <input type="text" class="form-control" v-model="txtape" id="txtape" disabled="true">
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label for="txtnom" class="col-sm-2 col-form-label">Nombre</label>
                                                        <div class="col-sm-10">
                                                            <input type="text" class="form-control" v-model="txtnom" id="txtnom" disabled="true">
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label for="txtdni" class="col-sm-2 col-form-label">DNI</label>
                                                        <div class="col-sm-10">
                                                            <input type="text" class="form-control" v-model="txtdni" id="txtdni" disabled="true">
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label for="txtcor" class="col-sm-2 col-form-label">Correo</label>
                                                        <div class="col-sm-10">
                                                            <input type="text" class="form-control" v-model="txtcorreo" id="txtcorreo" disabled="true">
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label for="txtcel" class="col-sm-2 col-form-label">Celular</label>
                                                        <div class="col-sm-10">
                                                            <input type="text" class="form-control" v-model="txtcel" id="txtcel" autocomplete="off">
                                                            <span class="invalid-feedback" role="alert">
                                                                <strong>{{msjcel}}</strong>
                                                            </span>
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label for="txtdir" class="col-sm-2 col-form-label">Dirección</label>
                                                        <div class="col-sm-10">
                                                            <textarea id="txtdir" class="form-control" v-model="txtdir"></textarea>
                                                            <span class="invalid-feedback" role="alert">
                                                                <strong>{{msjdir}}</strong>
                                                            </span>
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <div class="offset-sm-2 col-sm-10">
                                                            <button type="button" class="btn btn-danger" @click="guardar()">Editar</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="tab-pane" id="cambiar">
                                                <div class="form-horizontal">
                                                    <div class="form-group row">
                                                        <label for="txtpassa" class="col-sm-3 col-form-label">Contraseña actual</label>
                                                        <div class="col-sm-9">
                                                            <input type="email" class="form-control" v-model="txtpassa" id="txtpassa" placeholder="Contraseña actual" autocomplete="off">
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label for="txtpassn" class="col-sm-3 col-form-label">Nueva contraseña</label>
                                                        <div class="col-sm-9">
                                                            <input type="email" class="form-control" v-model="txtpassn" id="txtpassn" placeholder="Nueva contraseña" autocomplete="off">
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <label for="txtpassnr" class="col-sm-3 col-form-label">Confirmar contraseña</label>
                                                        <div class="col-sm-9">
                                                            <input type="email" class="form-control" v-model="txtpassnr" id="txtpassnr" placeholder="Confirmar contraseña" autocomplete="off">
                                                        </div>
                                                    </div>
                                                    <div class="form-group row">
                                                        <div class="offset-sm-3 col-sm-9">
                                                            <button type="button" class="btn btn-danger" @click="cambiar()">Cambiar</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
            </div>
            <%@include file="footer.jsp" %>
        </div>
        <%@include file="scrip.jsp" %>
        <script>
            let app = new Vue({
                el: '#app',
                data: {
                    txtpassa: "",
                    txtpassn: "",
                    txtpassnr: "",
                    txtape: "",
                    txtnom: "",
                    txtdni: "",
                    txtcorreo: "",
                    txtcel: "",
                    txtdir: "",
                    msjcel: "",
                    msjdir: "",
                },
                mounted: function () {
                    this.getpersona();
                },
                methods: {
                    getpersona: function () {
                        axios.get('perfil/mostrar').then(response => {
                            this.txtape = response.data.apeper;
                            this.txtnom = response.data.nomper;
                            this.txtdni = response.data.dniper;
                            this.txtcorreo = response.data.correoper;
                            this.txtcel = response.data.celper;
                            this.txtdir = response.data.dirper;
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    cambiar: function () {
                        var data = new FormData();
                        data.append('passa', this.txtpassa);
                        data.append('passn', this.txtpassn);
                        data.append('passc', this.txtpassnr);
                        axios.post('perfil/change-password', data).then(response => {
                            if (response.data.resp == 'si') {
                                toastr.success("La contraseña se actualizó");
                                this.txtpassa = "";
                                this.txtpassn = "";
                                this.txtpassnr = "";
                            } else {
                                if (response.data.msj != undefined) {
                                    toastr.warning(response.data.msj);
                                }
                            }
                        }).catch(function (error) {
                            console.log(error);
                        });
                    },
                    guardar: function () {
                        var data = new FormData();
                        data.append('dir', this.txtdir);
                        data.append('cel', this.txtcel);
                        axios.post('perfil/editar', data).then(response => {
                            if (response.data.resp == 'si') {
                                $('#txtcel').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                $('#txtdir').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                this.getpersona();
                                $('#txtcel').removeClass('form-control is-valid is-invalid').addClass('form-control');
                                $('#txtdir').removeClass('form-control is-valid is-invalid').addClass('form-control');
                                toastr.success("Se actualizó los datos");
                            } else {
                                if (response.data.cel != undefined) {
                                    this.msjcel = response.data.cel;
                                    $('#txtcel').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjcel = '';
                                    $('#txtcel').removeClass('form-control is-invalid').addClass('form-control is-valid');
                                }
                                if (response.data.dir != undefined) {
                                    this.msjdir = response.data.dir;
                                    $('#txtdir').removeClass('form-control').addClass('form-control is-invalid');
                                } else {
                                    this.msjdir = '';
                                    $('#txtdir').removeClass('form-control is-invalid').addClass('form-control is-valid');
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

