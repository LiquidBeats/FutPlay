<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>FutPlay - Ajustes de cuenta</title>
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
                        <div class="col-md-10 col-md-offset-1">
                            <div class="card">
                                <div class="card-header card-header-icon" data-background-color="red">
                                    <i class="material-icons">perm_identity</i>
                                </div>
                                <div class="card-content">
                                    <h4 class="card-title">Ajustes -
                                        <small class="category">Completa tu informacion personal</small>
                                    </h4>
                                    <div class="col-md-12">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label class="control-label active">Nombre</label>
                                                    <input type="text" id="txtNombreEditarUsuario" value="<%=objPersona.getNombres()%>" class="form-control">
                                                    <span class="material-input"></span>
                                                </div>
                                            </div>
                                            <div class="col-md-6 col-md-6">
                                                <div class="form-group">
                                                    <label class="control-label active">Apellido</label>
                                                    <input type="text" id="txtApellidoEditarUsuario" value="<%=objPersona.getApellidos()%>" class="form-control">
                                                    <span class="material-input"></span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label class="control-label active">Telefono</label>
                                                    <input type="text" id="txtTelefonoEditarUsuario" value="<%=objPersona.getTelefono()%>" class="form-control">
                                                    <span class="material-input"></span>
                                                </div>
                                            </div>
                                            <div class="col-md-6 col-md-6">
                                                <div class="form-group">
                                                    <label class="control-label active">Genero</label>
                                                    <select class="form-control" id="cmbGeneroEditarUsuario">
                                                        <%if (objPersona.getGenero().equals("Masculino")) {%>
                                                            <option value="Masculino">Masculino</option>
                                                            <option value="Femenino">Femenino</option>
                                                        <%}else{%>
                                                            <option value="Femenino">Femenino</option>
                                                            <option value="Masculino">Masculino</option>
                                                        <%}%>
                                                    </select>
                                                    <span class="material-input"></span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="form-group">
                                                    <label class="control-label">Correo</label>
                                                    <input disabled value="<%=objPersona.getCorreo()%>" class="form-control">
                                                    <span class="material-input"></span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row col-md-12">
                                        <div class="col-md-offset-9">
                                            <button type="submit" class="btn btn-danger editarUsuario">Actualizar Datos</button>
                                            <div class="clearfix"></div><br>
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
        </script>
    </body>
</html>
