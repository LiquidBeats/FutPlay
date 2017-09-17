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
        <%@include file="../includes/importsCSS.jsp"%>
    </head>
    <body>
        <div class="wrapper">
            <%@include file="../includes/notificacionesPropietario.jsp" %>
            <%@include file="../includes/sidebarPropietario.jsp"%>
            <div class="main-panel">
                <%@include file="../includes/headerPropietario.jsp"%>
                <div class="content">
                    <div class="container-fluid">
                        <div class="col-md-8 col-md-offset-2">
                            <div class="card card-profile">
                                <div class="card-avatar">
                                    <a href="#">
                                        <%if(objPropietario.getPersona().getAvatar().length()>=100){%>
                                            <img class="img" src="<%=objPropietario.getPersona().getAvatar()%>">
                                        <%}else{%>
                                            <img class="img" src="/FutPlayFinal/material-dashboard/assets/img/avatares/<%=objPropietario.getPersona().getAvatar()%>">
                                        <%}%>
                                    </a>
                                </div>
                                <div class="card-content">
                                    <h6 class="category text-gray"><%=objPropietario.getPersona().getNombres()%></h6>
                                    <h4 class="card-title"><%=objPropietario.getPersona().getApellidos()%></h4>
                                    <p class="description"><%=objPropietario.getPersona().getCorreo()%></p>
                                    <p class="description"><%=objPropietario.getPersona().getTelefono()%></p>
                                    <a href="/FutPlayFinal/material-dashboard/pages/propietario/editarPerfilPropietario.jsp" class="btn btn-danger btn-round">Editar perfil</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%@include file="../includes/importsJS.jsp"%>
        <script type="text/javascript">
            $("#nombrepagina").text("Mi perfil");
            $("#verperfil").addClass("active");
            $("#opcionesPerfil").addClass("in");
            
            CargarNotificacionesPropietario();
        </script>
    </body>
</html>
<%        }
    }  
    catch(NullPointerException ex){
        response.sendRedirect("/FutPlayFinal/index.html");
    }
%>
