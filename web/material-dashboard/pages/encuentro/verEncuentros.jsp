<%@page import="Modelo.Campos"%>
<%@page import="Controlador.campos"%>
<%@page import="Modelo.Equipo"%>
<%@page import="java.util.List"%>
<%@page import="Controlador.equipo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>FutPlay - Ingresar Encuentro</title>
        <%@include file="../includes/importsCSS.jsp" %>
    </head>
    <body>
        <div class="wrapper">
            <%@include file="../includes/notificaciones.jsp" %>
            <%@include file="../includes/sidebarJugador.jsp" %>
            <%if(objJugador != null & objPersona != null){%>
            <div class="main-panel">
                <%@include file="../includes/header.jsp" %>
                <div class="content">
                    <div class="container-fluid">
                        <%if (objJugador.getEquipo().toString().equals("1")) {%>
                        <div class="col-md-8 col-md-offset-2">
                            <div class='card card-profile'>
                                <div class='card-header card-header-icon' data-background-color='red'>
                                    <i class="material-icons">speaker_notes_off</i>
                                </div>
                                <div class="card-content">
                                    <div class="clearfix"></div>
                                    <h6 class="category text-gray">¿No tienes encuentros?</h6>
                                    <h4 class="card-title">FutPlay te informa</h4>
                                    <p class="description">
                                        Hola, por el momento no haces parte de un equipo. Nos gustaria que crearass tu propio equipo con el que podras competir en los torneo, on en su defecto pidele a un amigo que te agregue su equipo :).
                                    </p>
                                    <a href="/FutPlayFinal/material-dashboard/pages/equipo/verEquipo.jsp" class="btn btn-rose btn-round">Ir a crear equipo</a>
                                </div>
                            </div>
                        </div>
                        <p id="noEncuentros">no</p>
                        <%}else{%>
                            <div class="row">
                                <div class="col-md-12">
                                    <div class="card card-product">
                                        <div class="card-image" data-header-animation="true">
                                            <img src="../../assets/img/jugadorimg/encuentro-iloveimg-cropped.jpg" class="responsive-img">
                                            <!--<span class="card-title">Los mejores campos</span>-->
                                            <div class="ripple-container"></div>
                                        </div>
                                        <div class="card-content">
                                            <div class="card-actions">
                                                <a class="btn btn-danger btn-simple fix-broken-card" rel="tooltip" data-placement="bottom" title="" data-original-title="Ver de nuevo">
                                                    <i class="material-icons" style="font-size: 25px;">replay</i>
                                                    <div class="ripple-container"></div>
                                                </a>
                                                <a href="../encuentro/registroEncuentro.jsp" class="btn btn-default btn-simple btn-warning" rel="tooltip" data-placement="bottom" title="" data-original-title="Crear encuentro">
                                                    <i class="material-icons" style="font-size: 25px;">flash_on</i>
                                                    <div class="ripple-container"></div>
                                                </a>

                                            </div>
                                            <div class="card-description">
                                                <div class="row">
                                                    <div class="col-md-12">
                                                        <div class="card">
                                                            <!--<div class="card-header card-header-icon" data-background-color="blue">
                                                                <i class="material-icons">timeline</i>
                                                            </div>-->
                                                            <div class="card-content">
                                                                <h4 class="card-title">Estadisticas de mi equipo
                                                                    <!--<small> - Este año</small>-->
                                                                </h4>
                                                            </div>
                                                            <div id="chartEquipo" class="ct-chart"></div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="card-title">
                                                    <h4>Encuentros realizados</h4>
                                                </div>
                                                <div class="row" id="encuentrosRealizados">
                                                    <!--<div class="col-lg-4">
                                                        <div class="card card-pricing card-raised">
                                                            <div class="content">
                                                                <h4 class="card-title">Toposchos  <strong>VS</strong>  trixyTeam</h4>
                                                                <div class="icon icon-rose">
                                                                    <h2>5 - 0</h2>
                                                                </div>
                                                                <h3><strong>¡GANASTE!</strong></h3>
                                                                <br>
                                                            </div>
                                                        </div>
                                                    </div>-->
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        <%}%>
                    </div>
                </div>
            </div><%}%>
        </div>
        <!-- MODAL PARA MOSRAR LA UBICACION DEL CAMPO EN EL QUE SE REALIZO EL ENCUENTRO  -->
        <div class="modal fade" id="mapModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                            <i class="material-icons">clear</i>
                        </button>
                        <h4 class="modal-title">Ubicación</h4>
                    </div>
                    <div class="modal-body">
                        <div style="width: 100%; height: 300px; position: relative; overflow: hidden;" id="map-canvas" class="loading"><div style="height: 100%; width: 100%; position: absolute; top: 0px; left: 0px; background-color: rgb(229, 227, 223);"><div class="gm-style" style="position: absolute; z-index: 0; left: 0px; top: 0px; height: 100%; width: 100%; padding: 0px; border-width: 0px; margin: 0px;"><div tabindex="0" style="position: absolute; z-index: 0; left: 0px; top: 0px; height: 100%; width: 100%; padding: 0px; border-width: 0px; margin: 0px; cursor: url(&quot;https://maps.gstatic.com/mapfiles/openhand_8_8.cur&quot;) 8 8, default;"><div style="z-index: 1; position: absolute; top: 0px; left: 0px; width: 100%; transform-origin: 0px 0px 0px; transform: matrix(1, 0, 0, 1, 0, 0);"><div style="position: absolute; left: 0px; top: 0px; z-index: 100; width: 100%;"><div style="position: absolute; left: 0px; top: 0px; z-index: 0;"><div aria-hidden="true" style="position: absolute; left: 0px; top: 0px; z-index: 1; visibility: inherit;"><div style="width: 256px; height: 256px; position: absolute; left: -112px; top: -100px;"></div><div style="width: 256px; height: 256px; position: absolute; left: 144px; top: -100px;"></div><div style="width: 256px; height: 256px; position: absolute; left: 144px; top: 156px;"></div><div style="width: 256px; height: 256px; position: absolute; left: -112px; top: 156px;"></div><div style="width: 256px; height: 256px; position: absolute; left: 400px; top: -100px;"></div><div style="width: 256px; height: 256px; position: absolute; left: 400px; top: 156px;"></div></div></div></div><div style="position: absolute; left: 0px; top: 0px; z-index: 101; width: 100%;"></div><div style="position: absolute; left: 0px; top: 0px; z-index: 102; width: 100%;"></div><div style="position: absolute; left: 0px; top: 0px; z-index: 103; width: 100%;"><div style="position: absolute; left: 0px; top: 0px; z-index: -1;"><div aria-hidden="true" style="position: absolute; left: 0px; top: 0px; z-index: 1; visibility: inherit;"><div style="width: 256px; height: 256px; overflow: hidden; position: absolute; left: -112px; top: -100px;"><canvas draggable="false" height="256" width="256" style="user-select: none; position: absolute; left: 0px; top: 0px; height: 256px; width: 256px;"></canvas></div><div style="width: 256px; height: 256px; overflow: hidden; position: absolute; left: 144px; top: -100px;"></div><div style="width: 256px; height: 256px; overflow: hidden; position: absolute; left: 144px; top: 156px;"></div><div style="width: 256px; height: 256px; overflow: hidden; position: absolute; left: -112px; top: 156px;"></div><div style="width: 256px; height: 256px; overflow: hidden; position: absolute; left: 400px; top: -100px;"></div><div style="width: 256px; height: 256px; overflow: hidden; position: absolute; left: 400px; top: 156px;"></div></div></div></div><div style="position: absolute; z-index: 0; left: 0px; top: 0px;"><div style="overflow: hidden;"></div></div><div style="position: absolute; left: 0px; top: 0px; z-index: 0;"><div aria-hidden="true" style="position: absolute; left: 0px; top: 0px; z-index: 1; visibility: inherit;"><div style="position: absolute; left: -112px; top: -100px; transition: opacity 200ms ease-out;"><img draggable="false" alt="" src="https://maps.googleapis.com/maps/vt?pb=!1m5!1m4!1i16!2i19495!3i31718!4i256!2m3!1e0!2sm!3i389086160!3m14!2ses-419!3sUS!5e18!12m1!1e68!12m3!1e37!2m1!1ssmartmaps!12m4!1e26!2m2!1sstyles!2zcy50OjgyfHMuZTpnLmZ8cC52Om9ufHAuYzojZmZlMGVmZWYscy50OjJ8cy5lOmcuZnxwLnY6b258cC5oOiMxOTAwZmZ8cC5jOiNmZmMwZThlOCxzLnQ6M3xzLmU6Z3xwLmw6MTAwfHAudjpzaW1wbGlmaWVkLHMudDozfHMuZTpsfHAudjpvZmYscy50OjY1fHMuZTpnfHAudjpvbnxwLmw6NzAwLHMudDo2fHAuYzojZmY3ZGNkY2Q!4e0&amp;token=26301" style="width: 256px; height: 256px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none;"></div><div style="position: absolute; left: 144px; top: -100px; transition: opacity 200ms ease-out;"><img draggable="false" alt="" src="https://maps.googleapis.com/maps/vt?pb=!1m5!1m4!1i16!2i19496!3i31718!4i256!2m3!1e0!2sm!3i389085740!3m14!2ses-419!3sUS!5e18!12m1!1e68!12m3!1e37!2m1!1ssmartmaps!12m4!1e26!2m2!1sstyles!2zcy50OjgyfHMuZTpnLmZ8cC52Om9ufHAuYzojZmZlMGVmZWYscy50OjJ8cy5lOmcuZnxwLnY6b258cC5oOiMxOTAwZmZ8cC5jOiNmZmMwZThlOCxzLnQ6M3xzLmU6Z3xwLmw6MTAwfHAudjpzaW1wbGlmaWVkLHMudDozfHMuZTpsfHAudjpvZmYscy50OjY1fHMuZTpnfHAudjpvbnxwLmw6NzAwLHMudDo2fHAuYzojZmY3ZGNkY2Q!4e0&amp;token=34501" style="width: 256px; height: 256px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none;"></div><div style="position: absolute; left: 144px; top: 156px; transition: opacity 200ms ease-out;"><img draggable="false" alt="" src="https://maps.googleapis.com/maps/vt?pb=!1m5!1m4!1i16!2i19496!3i31719!4i256!2m3!1e0!2sm!3i389085740!3m14!2ses-419!3sUS!5e18!12m1!1e68!12m3!1e37!2m1!1ssmartmaps!12m4!1e26!2m2!1sstyles!2zcy50OjgyfHMuZTpnLmZ8cC52Om9ufHAuYzojZmZlMGVmZWYscy50OjJ8cy5lOmcuZnxwLnY6b258cC5oOiMxOTAwZmZ8cC5jOiNmZmMwZThlOCxzLnQ6M3xzLmU6Z3xwLmw6MTAwfHAudjpzaW1wbGlmaWVkLHMudDozfHMuZTpsfHAudjpvZmYscy50OjY1fHMuZTpnfHAudjpvbnxwLmw6NzAwLHMudDo2fHAuYzojZmY3ZGNkY2Q!4e0&amp;token=63044" style="width: 256px; height: 256px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none;"></div><div style="position: absolute; left: -112px; top: 156px; transition: opacity 200ms ease-out;"><img draggable="false" alt="" src="https://maps.googleapis.com/maps/vt?pb=!1m5!1m4!1i16!2i19495!3i31719!4i256!2m3!1e0!2sm!3i389086160!3m14!2ses-419!3sUS!5e18!12m1!1e68!12m3!1e37!2m1!1ssmartmaps!12m4!1e26!2m2!1sstyles!2zcy50OjgyfHMuZTpnLmZ8cC52Om9ufHAuYzojZmZlMGVmZWYscy50OjJ8cy5lOmcuZnxwLnY6b258cC5oOiMxOTAwZmZ8cC5jOiNmZmMwZThlOCxzLnQ6M3xzLmU6Z3xwLmw6MTAwfHAudjpzaW1wbGlmaWVkLHMudDozfHMuZTpsfHAudjpvZmYscy50OjY1fHMuZTpnfHAudjpvbnxwLmw6NzAwLHMudDo2fHAuYzojZmY3ZGNkY2Q!4e0&amp;token=54844" style="width: 256px; height: 256px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none;"></div><div style="position: absolute; left: 400px; top: -100px; transition: opacity 200ms ease-out;"><img draggable="false" alt="" src="https://maps.googleapis.com/maps/vt?pb=!1m5!1m4!1i16!2i19497!3i31718!4i256!2m3!1e0!2sm!3i389085740!3m14!2ses-419!3sUS!5e18!12m1!1e68!12m3!1e37!2m1!1ssmartmaps!12m4!1e26!2m2!1sstyles!2zcy50OjgyfHMuZTpnLmZ8cC52Om9ufHAuYzojZmZlMGVmZWYscy50OjJ8cy5lOmcuZnxwLnY6b258cC5oOiMxOTAwZmZ8cC5jOiNmZmMwZThlOCxzLnQ6M3xzLmU6Z3xwLmw6MTAwfHAudjpzaW1wbGlmaWVkLHMudDozfHMuZTpsfHAudjpvZmYscy50OjY1fHMuZTpnfHAudjpvbnxwLmw6NzAwLHMudDo2fHAuYzojZmY3ZGNkY2Q!4e0&amp;token=102149" style="width: 256px; height: 256px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none;"></div><div style="position: absolute; left: 400px; top: 156px; transition: opacity 200ms ease-out;"><img draggable="false" alt="" src="https://maps.googleapis.com/maps/vt?pb=!1m5!1m4!1i16!2i19497!3i31719!4i256!2m3!1e0!2sm!3i389085740!3m14!2ses-419!3sUS!5e18!12m1!1e68!12m3!1e37!2m1!1ssmartmaps!12m4!1e26!2m2!1sstyles!2zcy50OjgyfHMuZTpnLmZ8cC52Om9ufHAuYzojZmZlMGVmZWYscy50OjJ8cy5lOmcuZnxwLnY6b258cC5oOiMxOTAwZmZ8cC5jOiNmZmMwZThlOCxzLnQ6M3xzLmU6Z3xwLmw6MTAwfHAudjpzaW1wbGlmaWVkLHMudDozfHMuZTpsfHAudjpvZmYscy50OjY1fHMuZTpnfHAudjpvbnxwLmw6NzAwLHMudDo2fHAuYzojZmY3ZGNkY2Q!4e0&amp;token=130692" style="width: 256px; height: 256px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none;"></div></div></div></div><div class="gm-style-pbc" style="z-index: 2; position: absolute; height: 100%; width: 100%; padding: 0px; border-width: 0px; margin: 0px; left: 0px; top: 0px; opacity: 0;"><p class="gm-style-pbt"></p></div><div style="z-index: 3; position: absolute; height: 100%; width: 100%; padding: 0px; border-width: 0px; margin: 0px; left: 0px; top: 0px;"><div style="z-index: 1; position: absolute; height: 100%; width: 100%; padding: 0px; border-width: 0px; margin: 0px; left: 0px; top: 0px;"></div></div><div style="z-index: 4; position: absolute; top: 0px; left: 0px; width: 100%; transform-origin: 0px 0px 0px; transform: matrix(1, 0, 0, 1, 0, 0);"><div style="position: absolute; left: 0px; top: 0px; z-index: 104; width: 100%;"></div><div style="position: absolute; left: 0px; top: 0px; z-index: 105; width: 100%;"></div><div style="position: absolute; left: 0px; top: 0px; z-index: 106; width: 100%;"></div><div style="position: absolute; left: 0px; top: 0px; z-index: 107; width: 100%;"></div></div></div><div style="margin-left: 5px; margin-right: 5px; z-index: 1000000; position: absolute; left: 0px; bottom: 0px;"><a target="_blank" href="https://maps.google.com/maps?ll=5.752765,-72.902448&amp;z=16&amp;t=m&amp;hl=es-419&amp;gl=US&amp;mapclient=apiv3" title="Haz clic para ver esta área en Google Maps" style="position: static; overflow: visible; float: none; display: inline;"><div style="width: 66px; height: 26px; cursor: pointer;"><img src="https://maps.gstatic.com/mapfiles/api-3/images/google_white5.png" draggable="false" style="position: absolute; left: 0px; top: 0px; width: 66px; height: 26px; user-select: none; border: 0px; padding: 0px; margin: 0px;"></div></a></div><div style="background-color: white; padding: 15px 21px; border: 1px solid rgb(171, 171, 171); font-family: Roboto, Arial, sans-serif; color: rgb(34, 34, 34); box-shadow: rgba(0, 0, 0, 0.2) 0px 4px 16px; z-index: 10000002; display: none; width: 256px; height: 148px; position: absolute; left: 126px; top: 60px;"><div style="padding: 0px 0px 10px; font-size: 16px;">Datos del mapa</div><div style="font-size: 13px;">Datos del mapa ©2017 Google</div><div style="width: 13px; height: 13px; overflow: hidden; position: absolute; opacity: 0.7; right: 12px; top: 12px; z-index: 10000; cursor: pointer;"><img src="https://maps.gstatic.com/mapfiles/api-3/images/mapcnt6.png" draggable="false" style="position: absolute; left: -2px; top: -336px; width: 59px; height: 492px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none;"></div></div><div class="gmnoprint" style="z-index: 1000001; position: absolute; right: 259px; bottom: 0px; width: 148px;"><div draggable="false" class="gm-style-cc" style="user-select: none; height: 14px; line-height: 14px;"><div style="opacity: 0.7; width: 100%; height: 100%; position: absolute;"><div style="width: 1px;"></div><div style="background-color: rgb(245, 245, 245); width: auto; height: 100%; margin-left: 1px;"></div></div><div style="position: relative; padding-right: 6px; padding-left: 6px; font-family: Roboto, Arial, sans-serif; font-size: 10px; color: rgb(68, 68, 68); white-space: nowrap; direction: ltr; text-align: right; vertical-align: middle; display: inline-block;"><a style="color: rgb(68, 68, 68); text-decoration: none; cursor: pointer; display: none;">Datos del mapa</a><span style="">Datos del mapa ©2017 Google</span></div></div></div><div class="gmnoscreen" style="position: absolute; right: 0px; bottom: 0px;"><div style="font-family: Roboto, Arial, sans-serif; font-size: 11px; color: rgb(68, 68, 68); direction: ltr; text-align: right; background-color: rgb(245, 245, 245);">Datos del mapa ©2017 Google</div></div><div class="gmnoprint gm-style-cc" draggable="false" style="z-index: 1000001; user-select: none; height: 14px; line-height: 14px; position: absolute; right: 139px; bottom: 0px;"><div style="opacity: 0.7; width: 100%; height: 100%; position: absolute;"><div style="width: 1px;"></div><div style="background-color: rgb(245, 245, 245); width: auto; height: 100%; margin-left: 1px;"></div></div><div style="position: relative; padding-right: 6px; padding-left: 6px; font-family: Roboto, Arial, sans-serif; font-size: 10px; color: rgb(68, 68, 68); white-space: nowrap; direction: ltr; text-align: right; vertical-align: middle; display: inline-block;"><a href="https://www.google.com/intl/es-419_US/help/terms_maps.html" target="_blank" style="text-decoration: none; cursor: pointer; color: rgb(68, 68, 68);">Condiciones del servicio</a></div></div><div style="cursor: pointer; width: 25px; height: 25px; overflow: hidden; margin: 10px 14px; position: absolute; top: 0px; right: 0px;"><img src="https://maps.gstatic.com/mapfiles/api-3/images/sv9.png" draggable="false" class="gm-fullscreen-control" style="position: absolute; left: -52px; top: -86px; width: 164px; height: 175px; user-select: none; border: 0px; padding: 0px; margin: 0px;"></div><div draggable="false" class="gm-style-cc" style="user-select: none; height: 14px; line-height: 14px; position: absolute; right: 0px; bottom: 0px;"><div style="opacity: 0.7; width: 100%; height: 100%; position: absolute;"><div style="width: 1px;"></div><div style="background-color: rgb(245, 245, 245); width: auto; height: 100%; margin-left: 1px;"></div></div><div style="position: relative; padding-right: 6px; padding-left: 6px; font-family: Roboto, Arial, sans-serif; font-size: 10px; color: rgb(68, 68, 68); white-space: nowrap; direction: ltr; text-align: right; vertical-align: middle; display: inline-block;"><a target="_new" title="Informar a Google errores en las imágenes o el mapa de carreteras." href="https://www.google.com/maps/@5.7527655,-72.902448,16z/data=!10m1!1e1!12b1?source=apiv3&amp;rapsrc=apiv3" style="font-family: Roboto, Arial, sans-serif; font-size: 10px; color: rgb(68, 68, 68); text-decoration: none; position: relative;">Informar un error en el mapa</a></div></div><div class="gmnoprint gm-bundled-control gm-bundled-control-on-bottom" draggable="false" controlwidth="28" controlheight="93" style="margin: 10px; user-select: none; position: absolute; bottom: 107px; right: 28px;"><div class="gmnoprint" style="position: absolute; left: 0px; top: 38px;" controlwidth="28" controlheight="55"><div draggable="false" style="user-select: none; box-shadow: rgba(0, 0, 0, 0.3) 0px 1px 4px -1px; border-radius: 2px; cursor: pointer; background-color: rgb(255, 255, 255); width: 28px; height: 55px;"><div title="Acercar" aria-label="Acercar" tabindex="0" style="position: relative; width: 28px; height: 27px; left: 0px; top: 0px;"><div style="overflow: hidden; position: absolute; width: 15px; height: 15px; left: 7px; top: 6px;"><img src="https://maps.gstatic.com/mapfiles/api-3/images/tmapctrl.png" draggable="false" style="position: absolute; left: 0px; top: 0px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none; width: 120px; height: 54px;"></div></div><div style="position: relative; overflow: hidden; width: 67%; height: 1px; left: 16%; background-color: rgb(230, 230, 230); top: 0px;"></div><div title="Alejar" aria-label="Alejar" tabindex="0" style="position: relative; width: 28px; height: 27px; left: 0px; top: 0px;"><div style="overflow: hidden; position: absolute; width: 15px; height: 15px; left: 7px; top: 6px;"><img src="https://maps.gstatic.com/mapfiles/api-3/images/tmapctrl.png" draggable="false" style="position: absolute; left: 0px; top: -15px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none; width: 120px; height: 54px;"></div></div></div></div><div class="gm-svpc" controlwidth="28" controlheight="28" style="background-color: rgb(255, 255, 255); box-shadow: rgba(0, 0, 0, 0.3) 0px 1px 4px -1px; border-radius: 2px; width: 28px; height: 28px; cursor: url(&quot;https://maps.gstatic.com/mapfiles/openhand_8_8.cur&quot;) 8 8, default; position: absolute; left: 0px; top: 0px;"><div style="position: absolute; left: 1px; top: 1px;"></div><div style="position: absolute; left: 1px; top: 1px;"><div aria-label="Control del hombrecito naranja en Street View" style="width: 26px; height: 26px; overflow: hidden; position: absolute; left: 0px; top: 0px;"><img src="https://maps.gstatic.com/mapfiles/api-3/images/cb_scout5.png" draggable="false" style="position: absolute; left: -147px; top: -26px; width: 215px; height: 835px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none;"></div><div aria-label="El hombrecito naranja está en la parte superior del mapa." style="width: 26px; height: 26px; overflow: hidden; position: absolute; left: 0px; top: 0px; visibility: hidden;"><img src="https://maps.gstatic.com/mapfiles/api-3/images/cb_scout5.png" draggable="false" style="position: absolute; left: -147px; top: -52px; width: 215px; height: 835px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none;"></div><div aria-label="Control del hombrecito naranja en Street View" style="width: 26px; height: 26px; overflow: hidden; position: absolute; left: 0px; top: 0px; visibility: hidden;"><img src="https://maps.gstatic.com/mapfiles/api-3/images/cb_scout5.png" draggable="false" style="position: absolute; left: -147px; top: -78px; width: 215px; height: 835px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none;"></div></div></div><div class="gmnoprint" controlwidth="28" controlheight="0" style="display: none; position: absolute;"><div title="Rotar mapa 90 grados" style="width: 28px; height: 28px; overflow: hidden; position: absolute; border-radius: 2px; box-shadow: rgba(0, 0, 0, 0.3) 0px 1px 4px -1px; cursor: pointer; background-color: rgb(255, 255, 255); display: none;"><img src="https://maps.gstatic.com/mapfiles/api-3/images/tmapctrl4.png" draggable="false" style="position: absolute; left: -141px; top: 6px; width: 170px; height: 54px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none;"></div><div class="gm-tilt" style="width: 28px; height: 28px; overflow: hidden; position: absolute; border-radius: 2px; box-shadow: rgba(0, 0, 0, 0.3) 0px 1px 4px -1px; top: 0px; cursor: pointer; background-color: rgb(255, 255, 255);"><img src="https://maps.gstatic.com/mapfiles/api-3/images/tmapctrl4.png" draggable="false" style="position: absolute; left: -141px; top: -13px; width: 170px; height: 54px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none;"></div></div></div></div></div></div>
                    </div>
                    <div class="modal-footer">
                        
                    </div>
                </div>
            </div>
        </div>
        <%@include file="../includes/importsJS.jsp" %>
        <script>
            $("#encuentro").addClass('active');
            CargarNotificaciones();
            mostrarEncuentrosRealizados();
            cargarEstadisticas();
            if($("#noEncuentros").text() == "no"){
                
                $.notify({
                    icon: "perm_identity",
                    message: "Podras administrar tus encuentros cuando hagas parte de un equipo."

                },{
                    type: 'warning',
                    timer: 2500,
                    placement: {
                        from: 'bottom',
                        align: 'right'
                    }
                });
            }
            
        </script>
    </body>
</html>
