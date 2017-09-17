<%@page import="Modelo.Equipo"%>
<%@page import="Modelo.Notificacion"%>
<%@page import="Controlador.notificacion"%>
<%@page import="Modelo.Canchas"%>
<%@page import="Modelo.Canchas"%>
<%@page import="Controlador.canchas"%>
<%@page import="java.util.List"%>
<%@page import="Controlador.campos"%>
<%@page import="Modelo.Campos"%>
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
                        <div id="external-events">
                            <%
                               campos cmp = new campos();
                               List<Campos> listCmp = cmp.getAll(request, response);
                            %>  
                            <div class="col-lg-3">
                                <select name="cmbCampos" id="cmbCampos" class="form-control">
                                    <option disabled="" selected="">Selecciona tu campo</option>
                                    <%for (Campos cp : listCmp) {%>       
                                        <option value="<%=cp.getIdCampo()%>"><%=cp.getNombre()%></option>
                                    <%}%>
                                </select>

                                <div class="card">
                                    <div class="card-title">
                                        <h4 class="text-center" style="padding: 15px; font-size:23px;">CANCHAS</h4>   
                                    </div>
                                    <div class="card-content" id="cardEvents">
                                        
                                    </div>
                                </div>
                                <div class="text-center">
                                    <button class="btn btn-danger btn-lg btn-round btnGuardarCambios">Confirmar encuentros</button>
                                </div>
                            </div>
                            <div class="col-lg-9">
                                <div class="card card-calendar">
                                    <div class="card-content" class="ps-child">
                                        <div id="calendar"></div>
                                    </div>
                                </div>
                            </div>                    
                        </div>                         
                   </div>
                </div>
            </div>
        </div>
        <!-- MODAL PARA AGREGAR UN JUGADOR -->
        <div class="modal fade" id="modalEncuentro" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
            <div class="modal-dialog modal-notice">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="material-icons">clear</i></button>
                        <h5 class="modal-title" id="myModalLabel">Encuentros pendientes</h5>
                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group label-floating is-empty">

                                    <div class="modal-body col-md-12">
                                        <%
                                            notificacion ntf = new notificacion();
                                            List<Notificacion> listNtf = ntf.listarEncuentroPendientes(objPropietario.getIdPropietario());
                                            List<Equipo> listEquipo1 = ntf.listEquipo1(objPropietario.getIdPropietario());
                                            List<Equipo> listEquipo2 = ntf.listEquipo2(objPropietario.getIdPropietario());

                                        %>
                                        <%for (Notificacion nf : listNtf) {

                                            String NombreEquipo1 = "", NombreEquipo2 = "";
                                            String Contenido[] = nf.getDatosAdicionales().split("/");

                                            for (Equipo equipo1 : listEquipo1) {

                                                if (equipo1.getIdEquipo()==Integer.valueOf(Contenido[1])) {

                                                    NombreEquipo1 = equipo1.getNombre();

                                                }

                                            }
                                            for (Equipo equipo2 : listEquipo2) {

                                                if (String.valueOf(equipo2.getIdEquipo()).equals(Contenido[2])) {

                                                    NombreEquipo2 = equipo2.getNombre();

                                                }

                                            }
                                        %>
                                        <div class="row">
                                            <div class="material-datatables">
                                                <table class="table table-responsive">
                                                    <thead>
                                                        <th>Equipo A</th>
                                                        <th>Equipo B</th>
                                                        <th>Tipo</th>
                                                        <th>Fecha</th>
                                                        <th>Hora</th>
                                                        <th>Acciones</th>
                                                    </thead>
                                                    <tbody>
                                                        <tr>
                                                            <td><%=NombreEquipo1%></td>
                                                            <td><%=NombreEquipo2%></td>
                                                            <td><%=Contenido[0]%></td>
                                                            <td><input id="fechaEncuentro" type="text" class="datepicker form-control"></td>
                                                            <td><input id="horaEncuentro" type="text" class="timepicker form-control"></td>
                                                            <td><button class="btn btn-success btn-simple btnAceptarEncuentro" value="<%=nf.getIdNotificacion()%>" rel="tooltip" title="Aceptar solicitud" data-placement="bottom"><i class="material-icons">check</i></button></td>
                                                        </tr>
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                        <%}%>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <style>
            .fc h2{
                font-size:20px;
                text-transform: uppercase;
            }
        </style>
        <%@include file="../includes/importsJS.jsp"%> 
        <script src="../../assets/lang/es.js"></script>          		
        <script src="../../assets/js/canchasCalendar.js"></script>
        <script type="text/javascript">
            $("#nombrepagina").text("Cronograma");
            $("#cronograma").addClass("active");
            
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
