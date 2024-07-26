<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <meta name="description" content="Sistema de Gestión Cursos - ISIPP">
	<meta name="author" content="Miguel Ángel Toledo Cordova">
        <title>Recuperar contraseña</title>
        <link href="public/dist/img/icono.png" rel="icon">
        <!-- Google Font: Source Sans Pro -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="<%= request.getContextPath()%>/public/plugins/fontawesome-free/css/all.min.css">
        <!-- icheck bootstrap -->
        <link rel="stylesheet" href="<%= request.getContextPath()%>/public/plugins/icheck-bootstrap/icheck-bootstrap.min.css">
        <!-- Theme style -->
        <link rel="stylesheet" href="<%= request.getContextPath()%>/public/dist/css/adminlte.min.css">
    </head>
    <body class="hold-transition login-page">
        <div class="login-box" id="app">
            <div class="card card-outline card-primary">
                <div class="card-header text-center">
                    <a href="login" class="h1"><b>ISI</b>PP</a>
                </div>
                <div class="card-body">
                    <p class="login-box-msg">Estás a sólo un paso de tu nueva contraseña, recupera tu contraseña ahora.</p>
                    <div class="row" v-if="divwar">
                        <div class="col-md-12">
                            <div class="alert alert-warning alert-dismissible fade show" role="alert">
                                <strong>Mensaje:</strong> {{msj}}
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="row" v-if="divsuc">
                        <div class="col-md-12">
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                <strong>Mensaje:</strong> {{msj}}
                                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                        </div>
                    </div>
                    <input type="hidden" id="token" value="${token}">
                    <div class="input-group mb-3">
                        <input type="password" v-model="txtpass" id="txtpass" class="form-control" placeholder="Contraseña">
                        <div class="input-group-append">
                            <div class="input-group-text">
                                <span class="fas fa-lock"></span>
                            </div>
                        </div>
                        <span class="invalid-feedback" role="alert">
                            <strong>{{msjpass}}</strong>
                        </span>
                    </div>
                    <div class="input-group mb-3">
                        <input type="password" v-model="txtpassc" id="txtpassc" class="form-control" placeholder="Confirmar Contraseña">
                        <div class="input-group-append">
                            <div class="input-group-text">
                                <span class="fas fa-lock"></span>
                            </div>
                        </div>
                        <span class="invalid-feedback" role="alert">
                            <strong>{{msjpassc}}</strong>
                        </span>
                    </div>
                    <div class="row">
                        <div class="col-12">
                            <button type="submit" class="btn btn-primary btn-block" @click="cambiar()">Cambiar contraseña</button>
                        </div>
                    </div>
                    <p class="mt-3 mb-1">
                        <a href="<%= request.getContextPath()%>/login">Login</a>
                    </p>
                </div>
            </div>
        </div>
        <!-- jQuery -->
        <script src="<%= request.getContextPath()%>/public/plugins/jquery/jquery.min.js"></script>
        <!-- Bootstrap 4 -->
        <script src="<%= request.getContextPath()%>/public/plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
        <!-- AdminLTE App -->
        <script src="<%= request.getContextPath()%>/public/dist/js/adminlte.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/vue@2.5.16/dist/vue.js"></script>
        <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
        <script>
let app = new Vue({
    el: '#app',
    data: {
        txtpass: "",
        txtpassc: "",

        divwar: false,
        divsuc: false,
        msj: "",

        msjpass: "",
        msjpassc: "",
    },
    methods: {
        cambiar: function () {
            var data = new FormData();
            data.append('token', $("#token").val());
            data.append('pass', this.txtpass);
            data.append('passc', this.txtpassc);
            axios.post('reset-password/change-password', data).then(response => {
                if (response.data.resp == "si") {
                    $('#txtpass').removeClass('form-control is-invalid').addClass('form-control is-valid');
                    $('#txtpassc').removeClass('form-control is-invalid').addClass('form-control is-valid');
                    if (response.data.band == "si") {
                        this.msj = response.data.msj;
                        this.divwar = false;
                        this.divsuc = true;
                        $('#txtpass').removeClass('form-control is-valid is-invalid').addClass('form-control');
                        $('#txtpassc').removeClass('form-control is-valid is-invalid').addClass('form-control');
                    }else{
                        this.msj = response.data.msj;
                        this.divwar = true;
                        this.divsuc = false;
                    }
                } else {
                    if (response.data.pass != undefined) {
                        this.msjpass = response.data.pass;
                        $('#txtpass').removeClass('form-control').addClass('form-control is-invalid');
                    } else {
                        this.msjpass = '';
                        $('#txtpass').removeClass('form-control is-invalid').addClass('form-control is-valid');
                    }
                    if (response.data.passc != undefined) {
                        this.msjpassc = response.data.passc;
                        $('#txtpassc').removeClass('form-control').addClass('form-control is-invalid');
                    } else {
                        this.msjpassc = '';
                        $('#txtpassc').removeClass('form-control is-invalid').addClass('form-control is-valid');
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
