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
                        <div class="col-sm-10 col-sm-offset-1">
                            <!--      Wizard container        -->
                            <div class="wizard-container">
                                <div class="card wizard-card" data-color="red" id="wizardProfile">
                                    <form novalidate="novalidate">
                                        <!--        You can switch " data-color="purple" "  with one of the next bright colors: "green", "orange", "red", "blue"       -->
                                        <div class="wizard-header">
                                            <h3 class="wizard-title">
                                                Programar tu encuentro
                                            </h3>

                                        </div>
                                        <div class="wizard-navigation">
                                            <ul class="nav nav-pills">
                                                <li style="width: 33.3333%;" class="active">
                                                    <a href="#about" data-toggle="tab" aria-expanded="true">Tipo</a>
                                                </li>
                                                <li style="width: 33.3333%;">
                                                    <a href="#account" data-toggle="tab">Equipos</a>
                                                </li>
                                                <li style="width: 33.3333%;">
                                                    <a href="#address" data-toggle="tab">Campos</a>
                                                </li>
                                            </ul>
                                        <div class="moving-tab" style="width: 142.49px; transform: translate3d(-8px, 0px, 0px); transition: transform 0s;">About</div></div>
                                        <div class="tab-content">
                                            <div class="tab-pane active" id="about">
                                                <div class="row">
                                                    <h4 class="info-text"> Selecciona el tipo de encuentro</h4>
                                                    <div class="col-sm-4">
                                                        <div class="choice" onclick="tipoSeleccionado(5)" data-toggle="wizard-radio">
                                                            <input type="radio">
                                                            <div class="icon text-center">
                                                                <h1>5</h1>
                                                            </div>
                                                            <h6>Futbol 5</h6>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-4">
                                                        <div class="choice" onclick="tipoSeleccionado(8)" data-toggle="wizard-radio">
                                                            <input type="radio">
                                                            <div class="icon text-center">
                                                                <h1>8</h1>
                                                            </div>
                                                            <h6>Futbol 8</h6>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-4">
                                                        <div class="choice" onclick="tipoSeleccionado(12)" data-toggle="wizard-radio">
                                                            <input type="radio">
                                                            <div class="icon text-center">
                                                                <h1>12</h1>
                                                            </div>
                                                            <h6>Futbol 12</h6>
                                                        </div>
                                                    </div>
                                                        
                                                </div>
                                            </div>
                                            <div class="tab-pane" id="account">
                                                <h4 class="info-text">Elige el equipo con el que deseas jugar</h4>
                                                <div class="row">
                                                    <div class="col-lg-10 col-lg-offset-1">
                                                        
                                                        <%  equipo equipos = new equipo();
                                                            List<Equipo> list = equipos.getAllE(request,response);
                                                            if (list.equals(null)) {%>
                                                                <h2> No hay Campos para Mostrar</h2>     
                                                        <%  }else{ %>

                                                             <%for (Equipo LEquipo : list) {%>   

                                                                <div class="card-description">
                                                                    <div class="col-lg-4">
                                                                        <div class="card card-pricing card-raised">
                                                                            <div class="content">
                                                                                <h6 class="category"><%=LEquipo.getNombre()%></h6>
                                                                                <!--<div class="icon icon-rose">
                                                                                    <img class="avatar" src="../../assets/img/jugadorimg/Manchester-City-stats1.png" style="width: 120px;height: 120px;">
                                                                                </div>-->
                                                                                <h3 class="card-title"><%=LEquipo.getCiudad()%></h3>
                                                                                <div class="radio">
                                                                                  <label>
                                                                                      <input id="equipoEncuentro" name="equipo" type="radio" onclick="equipoSeleccionado(this)" value="<%=LEquipo.getIdEquipo()%>"/>
                                                                                      <span class="circle"></span>
                                                                                      <span class="check"></span> Selecionar
                                                                                  </label>
                                                                              </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <%}
                                                            }%> 
                                                
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="tab-pane" id="address">
                                                <h4 class="info-text">Selecciona el campo el el que deseas jugar</h4>
                                                <div class="row">
                                                    <div class="col-lg-10 col-lg-offset-1">
                                                        
                                                        <%  campos campo = new campos();
                                                            List<Campos> lista = campo.verCampos();
                                                            if (list==null) {
                                                        %>
                                                                     <h2> No hay Campos para Mostrar</h2>     
                                                               <% } %>

                                                           <%for (Campos LCampo : lista) {

                                                           %>   

                                                        <div class="card-description">
                                                            <div class="col-lg-4">
                                                                <div class="card card-pricing card-raised">
                                                                    <div class="content">
                                                                        <h6 class="category"><%=LCampo.getNombre()%></h6>
                                                                        <div class="icon icon-rose">
                                                                            <img class="avatar" src="/FutPlayFinal/Imagenes/<%=LCampo.getFoto()%>" style="width: 120px;height: 120px;">
                                                                        </div>
                                                                            <a href="#mapModal" class="btn btn-primary btn-simple " rel="tooltip" data-placement="bottom" title="" onclick="verUbicacionCampos('<%=LCampo.getUbicacion()%>')" value="<%=LCampo.getUbicacion()%>" data-original-title="Ubicacion en Google maps">
                                                                            <i class="material-icons" style="font-size: 25px;">location_on</i>
                                                                            <div class="ripple-container"></div>
                                                                        </a>
                                                                        <p class="card-description"><%=LCampo.getDireccion()%></p>
                                                                        <div class="radio">
                                                                            <label>
                                                                                <input id="campoEncuentro" name="campo" type="radio" onclick="campoSeleccionado(this)" value="<%=LCampo.getIdCampo()%>">
                                                                                <span class="circle"></span>
                                                                                <span class="check"></span> Selecionar
                                                                            </label>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                         <%}%>
                                                  
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="wizard-footer">
                                            <div class="pull-right">
                                                <input type="button" class="btnTipo btn btn-next btn-fill btn-danger btn-wd" name="next" value="Siguiente">
                                                <input type="button" class="btn btn-finish btn-fill btn-danger btn-wd ingresarEncuentro" name="finish" value="Finalizar" style="display: none;">
                                            </div>
                                            <div class="pull-left">
                                                <input type="button" class=" btn btn-previous btn-fill btn-default btn-wd disabled" name="previous" value="Volver">
                                            </div>
                                            <div class="clearfix"></div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                            <!-- wizard container -->
                        </div>
                        <%}%>
                    </div>
                </div>
            </div><%}%>
        </div>
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
                        <div style="width: 100%; height: 300px; position: relative; overflow: hidden;" id="map-canvas" class="loading"><div style="height: 100%; width: 100%; position: absolute; top: 0px; left: 0px; background-color: rgb(229, 227, 223);"><div class="gm-style" style="position: absolute; z-index: 0; left: 0px; top: 0px; height: 100%; width: 100%; padding: 0px; border-width: 0px; margin: 0px;"><div tabindex="0" style="position: absolute; z-index: 0; left: 0px; top: 0px; height: 100%; width: 100%; padding: 0px; border-width: 0px; margin: 0px; cursor: url(&quot;https://maps.gstatic.com/mapfiles/openhand_8_8.cur&quot;) 8 8, default;"><div style="z-index: 1; position: absolute; top: 0px; left: 0px; width: 100%; transform-origin: 0px 0px 0px; transform: matrix(1, 0, 0, 1, 0, 0);"><div style="position: absolute; left: 0px; top: 0px; z-index: 100; width: 100%;"><div style="position: absolute; left: 0px; top: 0px; z-index: 0;"><div aria-hidden="true" style="position: absolute; left: 0px; top: 0px; z-index: 1; visibility: inherit;"><div style="width: 256px; height: 256px; position: absolute; left: -75px; top: -176px;"></div></div></div></div><div style="position: absolute; left: 0px; top: 0px; z-index: 101; width: 100%;"></div><div style="position: absolute; left: 0px; top: 0px; z-index: 102; width: 100%;"></div><div style="position: absolute; left: 0px; top: 0px; z-index: 103; width: 100%;"><div style="position: absolute; left: 0px; top: 0px; z-index: -1;"><div aria-hidden="true" style="position: absolute; left: 0px; top: 0px; z-index: 1; visibility: inherit;"><div style="width: 256px; height: 256px; overflow: hidden; position: absolute; left: -75px; top: -176px;"><canvas draggable="false" height="256" width="256" style="user-select: none; position: absolute; left: 0px; top: 0px; height: 256px; width: 256px;"></canvas></div></div></div></div><div style="position: absolute; z-index: 0; left: 0px; top: 0px;"><div style="overflow: hidden;"></div></div><div style="position: absolute; left: 0px; top: 0px; z-index: 0;"><div aria-hidden="true" style="position: absolute; left: 0px; top: 0px; z-index: 1; visibility: inherit;"></div></div></div><div class="gm-style-pbc" style="z-index: 2; position: absolute; height: 100%; width: 100%; padding: 0px; border-width: 0px; margin: 0px; left: 0px; top: 0px; opacity: 0;"><p class="gm-style-pbt"></p></div><div style="z-index: 3; position: absolute; height: 100%; width: 100%; padding: 0px; border-width: 0px; margin: 0px; left: 0px; top: 0px;"><div style="z-index: 1; position: absolute; height: 100%; width: 100%; padding: 0px; border-width: 0px; margin: 0px; left: 0px; top: 0px;"></div></div><div style="z-index: 4; position: absolute; top: 0px; left: 0px; width: 100%; transform-origin: 0px 0px 0px; transform: matrix(1, 0, 0, 1, 0, 0);"><div style="position: absolute; left: 0px; top: 0px; z-index: 104; width: 100%;"></div><div style="position: absolute; left: 0px; top: 0px; z-index: 105; width: 100%;"></div><div style="position: absolute; left: 0px; top: 0px; z-index: 106; width: 100%;"></div><div style="position: absolute; left: 0px; top: 0px; z-index: 107; width: 100%;"></div></div></div><div style="margin-left: 5px; margin-right: 5px; z-index: 1000000; position: absolute; left: 0px; bottom: 0px;"><a target="_blank" href="https://maps.google.com/maps?ll=5.716085,-72.931129&amp;z=16&amp;t=m&amp;hl=es-ES&amp;gl=US&amp;mapclient=apiv3" title="Haz clic aquí para visualizar esta zona en Google Maps" style="position: static; overflow: visible; float: none; display: inline;"><div style="width: 66px; height: 26px; cursor: pointer;"><img src="https://maps.gstatic.com/mapfiles/api-3/images/google_white5.png" draggable="false" style="position: absolute; left: 0px; top: 0px; width: 66px; height: 26px; user-select: none; border: 0px; padding: 0px; margin: 0px;"></div></a></div><div style="background-color: white; padding: 15px 21px; border: 1px solid rgb(171, 171, 171); font-family: Roboto, Arial, sans-serif; color: rgb(34, 34, 34); box-shadow: rgba(0, 0, 0, 0.2) 0px 4px 16px; z-index: 10000002; display: none; width: 0px; height: 0px; position: absolute; left: 5px; top: 5px;"><div style="padding: 0px 0px 10px; font-size: 16px;">Datos de mapas</div><div style="font-size: 13px;"></div><div style="width: 13px; height: 13px; overflow: hidden; position: absolute; opacity: 0.7; right: 12px; top: 12px; z-index: 10000; cursor: pointer;"><img src="https://maps.gstatic.com/mapfiles/api-3/images/mapcnt6.png" draggable="false" style="position: absolute; left: -2px; top: -336px; width: 59px; height: 492px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none;"></div></div><div class="gmnoprint" style="z-index: 1000001; position: absolute; right: 0px; bottom: 0px; width: 12px;"><div draggable="false" class="gm-style-cc" style="user-select: none; height: 14px; line-height: 14px;"><div style="opacity: 0.7; width: 100%; height: 100%; position: absolute;"><div style="width: 1px;"></div><div style="background-color: rgb(245, 245, 245); width: auto; height: 100%; margin-left: 1px;"></div></div><div style="position: relative; padding-right: 6px; padding-left: 6px; font-family: Roboto, Arial, sans-serif; font-size: 10px; color: rgb(68, 68, 68); white-space: nowrap; direction: ltr; text-align: right; vertical-align: middle; display: inline-block;"><a style="color: rgb(68, 68, 68); text-decoration: none; cursor: pointer; display: none;">Datos de mapas</a><span style="display: none;"></span></div></div></div><div class="gmnoscreen" style="position: absolute; right: 0px; bottom: 0px;"><div style="font-family: Roboto, Arial, sans-serif; font-size: 11px; color: rgb(68, 68, 68); direction: ltr; text-align: right; background-color: rgb(245, 245, 245);"></div></div><div class="gmnoprint gm-style-cc" draggable="false" style="z-index: 1000001; user-select: none; height: 14px; line-height: 14px; position: absolute; right: 0px; bottom: 0px;"><div style="opacity: 0.7; width: 100%; height: 100%; position: absolute;"><div style="width: 1px;"></div><div style="background-color: rgb(245, 245, 245); width: auto; height: 100%; margin-left: 1px;"></div></div><div style="position: relative; padding-right: 6px; padding-left: 6px; font-family: Roboto, Arial, sans-serif; font-size: 10px; color: rgb(68, 68, 68); white-space: nowrap; direction: ltr; text-align: right; vertical-align: middle; display: inline-block;"><a href="https://www.google.com/intl/es-ES_US/help/terms_maps.html" target="_blank" style="text-decoration: none; cursor: pointer; color: rgb(68, 68, 68);">Términos de uso</a></div></div><div style="cursor: pointer; width: 25px; height: 25px; overflow: hidden; margin: 10px 14px; position: absolute; top: 0px; right: 0px;"><img src="https://maps.gstatic.com/mapfiles/api-3/images/sv9.png" draggable="false" class="gm-fullscreen-control" style="position: absolute; left: -52px; top: -86px; width: 164px; height: 175px; user-select: none; border: 0px; padding: 0px; margin: 0px;"></div><div draggable="false" class="gm-style-cc" style="user-select: none; height: 14px; line-height: 14px; display: none; position: absolute; right: 0px; bottom: 0px;"><div style="opacity: 0.7; width: 100%; height: 100%; position: absolute;"><div style="width: 1px;"></div><div style="background-color: rgb(245, 245, 245); width: auto; height: 100%; margin-left: 1px;"></div></div><div style="position: relative; padding-right: 6px; padding-left: 6px; font-family: Roboto, Arial, sans-serif; font-size: 10px; color: rgb(68, 68, 68); white-space: nowrap; direction: ltr; text-align: right; vertical-align: middle; display: inline-block;"><a target="_new" title="Informar a Google acerca de errores en las imágenes o en el mapa de carreteras" href="https://www.google.com/maps/@5.7160848,-72.9311289,16z/data=!10m1!1e1!12b1?source=apiv3&amp;rapsrc=apiv3" style="font-family: Roboto, Arial, sans-serif; font-size: 10px; color: rgb(68, 68, 68); text-decoration: none; position: relative;">Informar de un error de Maps</a></div></div><div class="gmnoprint gm-bundled-control gm-bundled-control-on-bottom" draggable="false" controlwidth="0" controlheight="0" style="margin: 10px; user-select: none; position: absolute; display: none; bottom: 0px; right: 0px;"><div class="gmnoprint" style="display: none; position: absolute;"><div draggable="false" style="user-select: none; box-shadow: rgba(0, 0, 0, 0.3) 0px 1px 4px -1px; border-radius: 2px; cursor: pointer; background-color: rgb(255, 255, 255);"><div title="Acerca la imagen" aria-label="Acerca la imagen" tabindex="0" style="position: relative;"><div style="overflow: hidden; position: absolute;"><img src="https://maps.gstatic.com/mapfiles/api-3/images/tmapctrl.png" draggable="false" style="position: absolute; left: 0px; top: 0px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none; width: 120px; height: 54px;"></div></div><div style="position: relative; overflow: hidden; width: 67%; height: 1px; left: 16%; background-color: rgb(230, 230, 230);"></div><div title="Aleja la imagen" aria-label="Aleja la imagen" tabindex="0" style="position: relative;"><div style="overflow: hidden; position: absolute;"><img src="https://maps.gstatic.com/mapfiles/api-3/images/tmapctrl.png" draggable="false" style="position: absolute; left: 0px; top: 0px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none; width: 120px; height: 54px;"></div></div></div></div><div class="gm-svpc" controlwidth="28" controlheight="28" style="background-color: rgb(255, 255, 255); box-shadow: rgba(0, 0, 0, 0.3) 0px 1px 4px -1px; border-radius: 2px; width: 28px; height: 28px; cursor: url(&quot;https://maps.gstatic.com/mapfiles/openhand_8_8.cur&quot;) 8 8, default; display: none; position: absolute;"><div style="position: absolute; left: 1px; top: 1px;"></div></div><div class="gmnoprint" controlwidth="28" controlheight="0" style="display: none; position: absolute;"><div title="Girar el mapa 90 grados" style="width: 28px; height: 28px; overflow: hidden; position: absolute; border-radius: 2px; box-shadow: rgba(0, 0, 0, 0.3) 0px 1px 4px -1px; cursor: pointer; background-color: rgb(255, 255, 255); display: none;"><img src="https://maps.gstatic.com/mapfiles/api-3/images/tmapctrl4.png" draggable="false" style="position: absolute; left: -141px; top: 6px; width: 170px; height: 54px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none;"></div><div class="gm-tilt" style="width: 0px; height: 0px; overflow: hidden; position: absolute; border-radius: 2px; box-shadow: rgba(0, 0, 0, 0.3) 0px 1px 4px -1px; top: 0px; cursor: pointer; background-color: rgb(255, 255, 255);"><img src="https://maps.gstatic.com/mapfiles/api-3/images/tmapctrl4.png" draggable="false" style="position: absolute; left: 0px; top: 0px; width: 170px; height: 54px; user-select: none; border: 0px; padding: 0px; margin: 0px; max-width: none;"></div></div></div></div></div></div>
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