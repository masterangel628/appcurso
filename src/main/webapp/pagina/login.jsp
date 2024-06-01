<%-- 
    Document   : login
    Created on : 15 abr 2024, 11:36:52
    Author     : Asus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Login</title>
        <%@include file="estilocss.jsp" %>
    </head>
    <body class="hold-transition login-page">
        <div id="app">
            <div class="login-box">
                <!-- /.login-logo -->
                <div class="card card-outline card-primary">
                    <div class="card-header text-center">
                        <a href="login" class="h1"><b>ISI</b>PP</a>
                    </div>
                    <div class="card-body">
                        <p class="login-box-msg">Iniciar Sessión</p>

                        <form  action="<%= request.getContextPath()%>/login" method="post">
                            <div class="input-group mb-3">
                                <input type="text" id="username" name="username" v-model="txtuser" class="form-control" placeholder="USERNAME" autocomplete="off">

                                <div class="input-group-append">
                                    <div class="input-group-text">
                                        <span class="fas fa-envelope"></span>
                                    </div>
                                </div>
                            </div>
                            <div class="input-group mb-3">
                                <input  type="password" Class="form-control" v-model="txtpass" id="password" name="password" placeholder="PASSWORD" autocomplete="off">

                                <div class="input-group-append">
                                    <div class="input-group-text">
                                        <span class="fas fa-lock"></span>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-8">
                                    
                                </div>
                                <!-- /.col -->
                                <div class="col-4">
                                    <button type="submit" class="btn btn-primary btn-block">Acceder</button>
                                </div>
                                <!-- /.col -->
                            </div>
                        </form>

                       

                        <p class="mb-1">
                            <a href="forgot-password">Olvidé mi contraseña
                            </a>
                        </p>
                    </div>
                    <!-- /.card-body -->
                </div>
                <!-- /.card -->
            </div>
            <!-- /.login-box -->
        </div>
        <%@include file="scrip.jsp" %>
    </body>
</html>

