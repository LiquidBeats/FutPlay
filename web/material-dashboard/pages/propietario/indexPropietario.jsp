<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    response.setHeader("Cache-Control","no-cache"); //Forces caches to obtain a new copy of the page from the origin server
    response.setHeader("Cache-Control","no-store"); //Directs caches not to store the page under any circumstance
    response.setDateHeader("Expires", 0); //Causes the proxy cache to see the page as "stale"
    response.setHeader("Pragma","no-cache"); //HTTP 1.0 backward compatibility
    try{      
        if(session.getAttribute("PropietarioIngresado").equals("")){
            response.sendRedirect("/FutPlayFinal/index.html");
        }
        else{
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>FutPlay</title>
        <%@include file="../includes/importsCSS.jsp" %>
    </head>
    <body>
        <div class="wrapper">
            <%@include file="../includes/notificacionesPropietario.jsp" %>
            <%@include file="../includes/sidebarPropietario.jsp" %>
            <div class="main-panel">
                <%@include file="../includes/headerPropietario.jsp" %>
                <div class="content">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-lg-6">
                              <div class="card card-product">
                                <div class="card-image" data-header-animation="true">
                                    <img src="/FutPlayFinal/material-dashboard/assets/img/corner.JPG">
                                    <span class="card-title">Campos</span>
                                </div>
                                <div class="card-content">
                                    <div class="card-actions">
                                        <a href="/FutPlayFinal/material-dashboard/pages/campo/registrarCampo.jsp" type="button" class="btn btn-info btn-simple" rel="tooltip" data-placement="bottom" title="Añadir campo">
                                             <i class="material-icons" style="font-size: 30px;">add</i>
                                        </a>
                                        <button type="button" class="btn btn-danger btn-simple fix-broken-card" rel="tooltip" data-placement="bottom" title="Ver de nuevo">
                                          <i class="material-icons" style="font-size: 25px;">loop</i>
                                        </button>
                                    </div>
                                  <p>Añade tus campos y canchas, comienza a conectarte con jugadores y planea encuentos</p>
                                </div>
                                  <div class="card-footer">
                                      <button class="btn btn-danger btnVerCampos" value="<%=objPropietario.getIdPropietario()%>">Administrar campos</button>
                                  </div>
                              </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="card card-product">
                                  <div class="card-image" data-header-animation="true">
                                    <img src="/FutPlayFinal/material-dashboard/assets/img/cronograma.jpg">
                                    <span class="card-title">Cronograma de encuentros</span>
                                  </div>
                                  <div class="card-content">
                                    <div class="card-actions">
                                      <button type="button" class="btn btn-danger btn-simple fix-broken-card" rel="tooltip" title="Ver de nuevo">
                                          <i class="material-icons">loop</i>
                                      </button>
                                    </div>
                                    <p>Lleva un control especifico y organizado de tus canchas dia a dia</p>
                                  </div>
                                    <div class="card-footer">
                                        <button class="btn btn-danger btnVerCanchas">Administrar canchas</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%@include file="../includes/importsJS.jsp" %>
        <script type="text/javascript">
            $("#nombrepagina").text("Inicio");
            $("#inicio").addClass("active");
            window.onload = function (){
                
                CargarNotificacionesPropietario();
                
            };
        </script>
    </body>
</html>
<%        }
    }  
    catch(NullPointerException ex){
        response.sendRedirect("/FutPlayFinal/index.html");
    }
%>
