<div class="preloader flex-column justify-content-center align-items-center">
    <img class="animation__shake" src="public/dist/img/loader.png" alt="logofarma" height="128" width="128">
</div>
<nav class="main-header navbar navbar-expand navbar-white navbar-light" style="background-color: #ff1a1a;">
    <ul class="navbar-nav">
        <li class="nav-item">
            <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars" style="color: #ffffff;"></i></a>
        </li>
    </ul>
    <ul class="navbar-nav ml-auto">
        <li class="nav-item dropdown user-menu">
            <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                <span class="d-none d-md-inline" style="color: #ffffff;">
                    ${ape} ${nom}
                </span>
            </a>
            <ul class="dropdown-menu dropdown-menu-lg dropdown-menu-right" style="left: inherit; right: 0px;">
                <li class="user-header bg-danger">                    
                    <p class="" >
                        ${ape} ${nom}
                    </p>
                </li>
                <li class="user-footer">
                    <a href="editarperfil" class="btn btn-default btn-flat">
                        <i class="fa fa-fw fa-user text-lightblue"></i>
                        Perfil
                    </a>
                    <a class="btn btn-default btn-flat float-right" href="logout">
                        <i class="fa fa-fw fa-power-off text-red"></i>
                        Salir
                    </a>
                </li>
            </ul>
        </li>
    </ul>
</nav>
