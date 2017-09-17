<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>FutPlay - Campos Sobresalientes</title>
        <%@include file="../includes/importsCSS.jsp"%>
        <% 
            //Jugador objJugadorVisto = (Jugador) request.getSession().getAttribute("JugadorVisto");
        %>
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
                                        <img src="/FutPlayFinal/Imagenes/campo.jpg" class="responsive-img">
                                        <!--<span class="card-title">Los mejores campos</span>-->
                                        
                                        <div class="ripple-container"></div>
                                        
                                    </div>
                                      
                                   <div class="card-content">
                                <div class="card-actions">
                                            <a class="btn btn-danger btn-simple fix-broken-card" rel="tooltip" data-placement="bottom" title="" data-original-title="Ver de nuevo">
                                                <i class="material-icons" style="font-size: 25px;">replay</i>
                                                <div class="ripple-container"></div>
                                            </a>
                                                     
                                           <a href="#" data-toggle="modal" data-target="#modalCampo" class="btn btn-info btn-simple" rel="tooltip" data-placement="bottom"  data-original-title="Buscar  Campos">
                                                <i class="material-icons " style="font-size: 25px;">search</i>
                                                <div class="ripple-container"></div>
                                            </a>
                                               <div class="modal fade" id="modalCampo" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                                    <div class="modal-dialog modal-notice">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="material-icons">clear</i></button>
                                                                <h5 class="modal-title" id="myModalLabel">Buscar Campo</h5>
                                                            </div>
                                                            <div class="modal-body">
                                                                <div class="row">
                                                                    <div class="col-md-10 col-md-offset-1">
                                                                        <div class="form-group label-floating is-empty">
                                                                            <label class="control-label">Nombre o Ciudad</label>
                                                                            <input type="text" class="form-control buscarCampo" id="buscarCampo">
                                                                            <span class="help-block"> Ingrese Nombre o Ciudad del campo que desea buscar</span>
                                                                            <span class="material-input"></span><br><br>
                                                                        </div>
                                                                        <div id="busquedaContainer" style="max-height: 300px;overflow-y: auto;">

                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        <div class="card-title">
                                            <h5><span>Campos Sobresalientes</span></h5>
                                        </div>
                         
                                        <div class="card-description">
                                            <div class="row" id="contenidoCampoSobresalientes">
                                                <div class="col-lg-4">
                                                    <div class="card card-pricing card-raised">
                                                        <div class="content">
                                                            
                                                      
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                                                                
                                                                                 
                                        <div class="modal fade" id="modalCampoCalificar" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                            <div class="modal-dialog modal-notice">
                                                <div class="modal-content">
                                                    <div class="modal-header ">
                                                       <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="material-icons">clear</i></button>
                                                        <h5 class="modal-title" id="myModalLabel">Calificar Campo</h5>
                
                                                    </div>
                                                    <div class="modal-body">
                                                        <div class="row">
                                                            <div class="col-md-10 col-md-offset-1">

                                                                <!--   <div id="CalificarContainer" style="max-height: 300px;overflow-y: auto;">
                                                                    <button class="dropdown-toggle btn btn-simple likeCampo" data-toggle="dropdown" rel="tooltip" data-placement="bottom" data-original-title="Like">
                                                                        <i class="material-icons" style="font-size: 50px; ">thumb_up</i>
                                                                    </button>
                                                                    <button class="dropdown-toggle btn btn-simple DislikeCampo" data-toggle="dropdown" rel="tooltip" data-placement="bottom" data-original-title="DisLike">
                                                                        <i class="material-icons" style="font-size: 50px; ">thumb_down</i>
                                                                    </button>
                                                                -->
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
            </div>
        
        <%@include file="../includes/importsJS.jsp" %>
        <script>
            $("#iniciojugador").addClass('active');
            CargarNotificaciones();
            mostrarCamposSobresalientes();
           
        </script>
        <div class="modal fade" id="mapModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                            <i class="material-icons">clear</i>
                        </button>
                        <h4 class="modal-title">Ubicación</h4>
                    </div>
                    <div class="modal-body">
                        <div style="width: 100%; height: 300px;" id="map-canvas"></div>
                    </div>
                    <div class="modal-footer">
                        
                    </div>
                </div>
            </div>
        </div> 
       
    </body>
</html>
