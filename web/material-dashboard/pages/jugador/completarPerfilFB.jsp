<!doctype html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>FutPlay - Registro</title>
    <%@include file="../includes/importsCSS.jsp"%>
</head>

<body>
    <nav class="navbar navbar-primary navbar-transparent navbar-absolute">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navigation-example-2">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="/FutPlayFinal/index.html">FutPlay</a>
            </div>
            <div class="collapse navbar-collapse">
                <ul class="nav navbar-nav navbar-right">             
                    <li class="">
                        <a href="/FutPlayFinal/material-dashboard/pages/usuario/login.html">
                            <i class="material-icons">fingerprint</i> Inicia Sesión
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <div class="wrapper wrapper-full-page">
        <div class="full-page login-page" filter-color="black" data-image="/FutPlayFinal/GaiaTemplate/assets/img/bannerIndex.jpg">
            <!--   you can change the color of the filter page using: data-color="blue | purple | green | orange | red | rose " -->
            <div class="content">
                <div class="container-fluid">
                    <div class="col-sm-8 col-sm-offset-2">
                        <!--      Wizard container        -->
                        <div class="wizard-container">
                            <div class="card wizard-card" data-color="red" id="wizardProfile">
                                <form action="" method="post" novalidate="novalidate" id="frmJugadorFB">
                                    <!--        You can switch " data-color="purple" "  with one of the next bright colors: "green", "orange", "red", "blue"       -->
                                    <div class="wizard-header">
                                        <h3 class="wizard-title">
                                            Ingresa tu datos
                                        </h3>
                                        <h5>Completa la informacion de tu perfil.</h5>
                                    </div>
                                    <div class="wizard-navigation">
                                        <ul class="nav nav-pills">
                                            <li style="width: 33.3333%;">
                                                <a href="#perfil" data-toggle="tab">Perfil</a>
                                            </li>
                                            <li style="width: 33.3333%;">
                                                <a href="#preguntas" data-toggle="tab">Preguntas</a>
                                            </li>
                                        </ul>
                                    <div class="moving-tab" style="width: 142.49px; transform: translate3d(-8px, 0px, 0px); transition: transform 0s;">About</div></div>
                                    <div class="tab-content">
                                        <div class="tab-pane" id="preguntas">
                                            <div class="input-group">
                                                <span class="input-group-addon">
                                                    <i class="material-icons">question_answer</i>
                                                </span>
                                                <div class="form-group label-floating is-empty">
                                                    <label class="label-control">¿Eres capaz de patear el balon 30 veces sin dejarlo caer?
                                                        <small class="error"></small>
                                                    </label>
                                                    <select name="pregunta1FB" id="pregunta1FB" class="form-control">
                                                        <option disabled="" selected=""></option>
                                                        <option value="100"> Si </option>
                                                        <option value="0"> No </option>
                                                        <option value="50"> Tal vez </option>
                                                    </select>
                                                <span class="material-input"></span></div>
                                            </div>
                                            <div class="input-group">
                                                <span class="input-group-addon">
                                                    <i class="material-icons">question_answer</i>
                                                </span>
                                                <div class="form-group label-floating is-empty">
                                                    <label class="label-control">¿Que tan buena es tu condicion fisica?
                                                        <small class="error"></small>
                                                    </label>
                                                    <select name="pregunta2FB" id="pregunta2FB" class="form-control">
                                                        <option disabled="" selected=""></option>
                                                        <option value="100"> Buena </option>
                                                        <option value="0"> Mala </option>
                                                        <option value="50"> Regular </option>
                                                    </select>
                                                <span class="material-input"></span></div>
                                            </div>
                                            <div class="input-group">
                                                <span class="input-group-addon">
                                                    <i class="material-icons">question_answer</i>
                                                </span>
                                                <div class="form-group label-floating is-empty">
                                                    <label class="label-control">¿Con que frecuencia practicas este deporte?
                                                        <small class="error"></small>
                                                    </label>
                                                    <select name="pregunta3FB" id="pregunta3FB" class="form-control">
                                                        <option disabled="" selected=""></option>
                                                        <option value="100"> Todos los dias </option>
                                                        <option value="50"> Una vez por semana </option>
                                                        <option value="25"> Una vez por mes </option>
                                                        <option value="0"> No practico este deporte </option>
                                                    </select>
                                                <span class="material-input"></span></div>
                                            </div>
                                        </div>
                                        <div class="tab-pane" id="perfil">
                                            <div class="input-group">
                                                <span class="input-group-addon">
                                                    <i class="material-icons">account_circle</i>
                                                </span>
                                                <div class="form-group label-floating is-empty">
                                                    <label class="label-control">Alias
                                                        <small class="error"></small>
                                                    </label>
                                                    <input name="txtAliasJugadorFB" id="txtAliasJugadorFB" type="text" class="form-control">
                                                <span class="material-input"></span></div>
                                            </div>
                                            <div class="input-group">
                                                <span class="input-group-addon">
                                                    <i class="material-icons">question_answer</i>
                                                </span>
                                                <div class="form-group label-floating is-empty">
                                                    <label class="label-control">Posicion en la que juegas
                                                        <small class="error"></small>
                                                    </label>
                                                    <select class="form-control" id="cmbPosicionJugadorFB" name="cmbPosicionJugadorFB">
                                                        <option disabled="" selected=""></option>
                                                        <option value="Portero">Portero</option>
                                                        <option value="Defensor">Defensa</option>
                                                        <option value="Mediocampista">Mediocampista</option>
                                                        <option value="Delantero">Delantero</option>
                                                    </select>
                                                <span class="material-input"></span></div>
                                            </div>
                                            <div class="input-group">
                                                <span class="input-group-addon">
                                                    <i class="material-icons">question_answer</i>
                                                </span>
                                                <div class="form-group label-floating is-empty">
                                                    <label class="label-control">Pierna con la que juegas
                                                        <small class="error"></small>
                                                    </label>
                                                    <select name="cmbPiernaJugadorFB" id="cmbPiernaJugadorFB" class="form-control">
                                                        <option disabled="" selected=""></option>
                                                        <option value="Derecha">Derecha</option>
                                                        <option value="Izquierda">Izquierda</option>
                                                        <option value="Ambas">Ambas</option>
                                                    </select>
                                                <span class="material-input"></span></div>
                                            </div>
                                            <div class="input-group">
                                                <span class="input-group-addon">
                                                    <i class="material-icons">description</i>
                                                </span>
                                                <div class="form-group label-floating is-empty">
                                                    <label class="label-control">Descripcion
                                                        <small class="error"></small>
                                                    </label>
                                                    <input name="txtDescripcionJugadorFB" id="txtDescripcionJugadorFB" type="text" class="form-control">
                                                <span class="material-input"></span></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="wizard-footer">
                                        <div class="pull-right">
                                            <input type="button" class="btn btn-next btn-fill btn-danger btn-wd" name="next" value="Siguiente">
                                            <input type="submit" class="btn btn-finish btn-fill btn-danger btn-wd" name="finish" value="Finalizar" style="display: none;">
                                        </div>
                                        <div class="pull-left">
                                            <input type="button" class="btn btn-previous btn-fill btn-default btn-wd disabled" name="previous" value="Volver">
                                        </div>
                                        <div class="clearfix"></div>
                                    </div>
                                </form>
                            </div>
                        </div>
                        <!-- wizard container -->
                    </div>
                </div>
            </div>
            <footer class="footer">
                <div class="container">
                    <nav class="pull-left">
                        <ul>

                        </ul>
                    </nav>
                    <p class="copyright">
                        &copy;
                        <script>
                            document.write(new Date().getFullYear());
                        </script>
                        <a href="#">FutPlay Team</a><a class="pull-right">hecho con amor</a>
                    </p>
                </div>
            </footer>
        </div>
    </div>
    <style>
        .error{
            color:red;
            font-size:12px;
        }
    </style>
    <input type="text" hidden="" id="unombre"/>
    <input type="text" hidden="" id="uapellido"/>
    <input type="text" hidden="" id="ufecha"/>
    <input type="text" hidden="" id="utelefono"/>
    <input type="text" hidden="" id="ugenero"/>
    <input type="text" hidden="" id="ucorreo"/>
    <input type="text" hidden="" id="ucontrasenia"/>
    <input type="text" hidden="" id="uavatar"/>
    <%@include file="../includes/importsJS.jsp"%>
    <script type="text/javascript">
        var data = localStorage.getItem('JSONFacebook');
        var dt = JSON.parse(data);
        $("#unombre").val(dt.UNombre);
        $("#uapellido").val(dt.UApellido);
        $("#ufecha").val(dt.UFechaNacimiento);
        $("#utelefono").val(dt.UTelefono);
        $("#ugenero").val(dt.genero);
        $("#ucorreo").val(dt.UCorreo);
        $("#ucontrasenia").val(dt.UContrasenia);
        $("#uavatar").val(dt.UAvatar);
    </script>
</body>
</html>