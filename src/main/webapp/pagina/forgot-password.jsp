<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <meta name="description" content="Sistema de Gestión Cursos - ISIPP">
	<meta name="author" content="Miguel Ángel Toledo Cordova">
        <title>Has olvidado tu contraseña</title>
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
                    <p class="login-box-msg">¿Olvidaste tu contraseña? Aquí puede recuperar fácilmente una nueva contraseña.</p>
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
                    <div class="input-group mb-3">
                        <input type="email" v-model="txtemail" id="txtemail" class="form-control" placeholder="Email">
                        <div class="input-group-append">
                            <div class="input-group-text">
                                <span class="fas fa-envelope"></span>
                            </div>
                        </div>
                        <span class="invalid-feedback" role="alert">
                            <strong>{{msjcor}}</strong>
                        </span>
                    </div>
                    <center v-if="cenlod">
                        <div class="spinner-border" style="width: 3rem; height: 3rem;" role="status">
                            <span class="sr-only">Loading...</span>
                        </div>
                    </center>
                    <div class="row">
                        <div class="col-12">
                            <button type="button" @click="enviartoken()" class="btn btn-primary btn-block">Pide nueva contraseña</button>
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
        txtemail: "",
        divsuc: false,
        msj: "",
        msjcor: "",
        cenlod: false,
    },
    methods: {
        enviartoken: function () {
             this.cenlod=true;
            var data = new FormData();
            data.append('email', this.txtemail);
            axios.post('forgot-password/send-token', data).then(response => {
                if (response.data.resp == "si") {
                    $('#txtemail').removeClass('form-control is-invalid').addClass('form-control is-valid');
                    this.msj = response.data.msj;
                    this.divsuc = true;
                    $('#txtemail').removeClass('form-control is-valid is-invalid').addClass('form-control');
                     this.cenlod=false;
                } else {
                    if (response.data.cor != undefined) {
                        this.msjcor = response.data.cor;
                        $('#txtemail').removeClass('form-control').addClass('form-control is-invalid');
                    } else {
                        this.msjcor = '';
                        $('#txtemail').removeClass('form-control is-invalid').addClass('form-control is-valid');
                    }
                    this.cenlod=false;
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
