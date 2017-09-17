<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>FutPlay - Equipos Sobresalientes</title>
        <%@include file="../includes/importsCSS.jsp"%>
    </head>
    <body>
        <div class="wrapper">
            <%@include file="../includes/notificaciones.jsp" %>
            <%@include file="../includes/sidebarJugador.jsp" %>
            <div class="main-panel">
                <%@include file="../includes/header.jsp" %>
                <div class="content">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="card card-product">
                                    <div class="card-image" data-header-animation="true">
                                        <img src="/FutPlayFinal/material-dashboard/assets/img/jugadorimg/Pirlo-redimensionado.jpg" class="responsive-img">
                                        <!--<span class="card-title">Los mejores campos</span>-->
                                        <div class="ripple-container"></div>
                                    </div>
                                    <div class="card-content">
                                        <div class="card-actions">
                                            <a class="btn btn-danger btn-simple fix-broken-card" rel="tooltip" data-placement="bottom" title="" data-original-title="Ver de nuevo">
                                                <i class="material-icons" style="font-size: 25px;">replay</i>
                                                <div class="ripple-container"></div>
                                            </a>
                                            <a href="#" data-toggle="modal" data-target="#noticeModal" class="btn btn-default btn-simple btn-success" rel="tooltip" data-placement="bottom" title="" data-original-title="Buscar Equipo">
                                                <i class="material-icons" style="font-size: 25px;">search</i>
                                                <div class="ripple-container"></div>
                                            </a>
                                            
                                        </div>
                                        <div class="card-title">
                                            <h5><span>Equipos Sobresalientes</span></h5>
                                        </div>
                                        <!-- NO OLVIDAR HACER EL BUSCADOR°°°°°°°°°°°°°°°°°° -->
                                        <div class="card-description">
                                            <div class="row" id="contenidoEquipoSobresalientes">
                                                <div class="col-lg-4">
                                                    <div class="card card-pricing card-raised">
                                                        <div class="content">
                                                            <h6 class="category">asdadasdada</h6>
                                                            <div class="icon icon-rose">
                                                                <!--<div style="height: 100px; margin-left: 185px; color: white; position: relative; background-color: #999999; width: 100px; border-radius: 50%;">
                                                                    <h1 style="padding-top: 10px;">5</h1>
                                                                </div>
                                                                <h6>Futbol 5</h6>-->
                                                                <div class="col-sm-4">
                                                                    <div class="choice" data-toggle="wizard-radio">
                                                                        <!--<input type="radio">-->
                                                                        <div class="icon text-center">
                                                                            <h1 style="color: #999999;">8</h1>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <h3 class="card-title">Delantero</h3>
                                                            <i class="material-icons" style="font-size: 25px; color: #d8bb21">stars</i>
                                                            <i class="material-icons" style="font-size: 25px; color: #d8bb21">stars</i>
                                                            <i class="material-icons" style="font-size: 25px; color: #d8bb21">stars</i>
                                                            <i class="material-icons" style="font-size: 25px; color: #999999">stars</i>
                                                            <i class="material-icons" style="font-size: 25px; color: #999999">stars</i>
                                                            <br>
                                                            <a href="/FutPlayFinal/jugador/verjugador/1" class="btn btn-danger btn-round">Ver perfil</a>
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
                </div>
            </div>
        </div>
        <!-- °°° MODAL PARA REALIZAR LA BUSQUEDA DE LOS EQUIPOS °°° -->
        <div class="modal fade" id="noticeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
            <div class="modal-dialog modal-notice">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="material-icons">clear</i></button>
                        <h5 class="modal-title" id="myModalLabel">Buscar Equipo</h5>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-10 col-md-offset-1">
                                <div class="form-group label-floating">
                                    <label class="control-label">Equipo</label>
                                    <input type="text" class="form-control buscarEquipo" id="txtBuscarEquipo">
                                    <span class="help-block">Ingresa el nombre o la ciudad del eqipo.</span>
                                    <span class="material-input"></span><br><br>
                                <span class="material-input"></span></div>
                                <div style="max-height: 300px;overflow-y: auto;">
                                    <div class="row" id="busquedaContainer">
                                        
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%@include file="../includes/importsJS.jsp" %>
        <script>
            $("#iniciojugador").addClass('active');
            CargarNotificaciones();
            mostrarEquiposSobresaliente();
        </script>
    </body>
</html>
