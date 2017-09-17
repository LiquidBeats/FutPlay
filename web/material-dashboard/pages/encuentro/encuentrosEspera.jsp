<%@page import="Controlador.encuentros"%>
<%@page import="java.util.List"%>
<%@page import="Modelo.Encuentros"%>
<%@page import="Modelo.Encuentros"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="../includes/importsCSS.jsp"%>
        <title>FutPlay</title>
    </head>
    <body>
        <div class="wrapper">
            <%@include file="../includes/notificacionesPropietario.jsp" %>
            <%@include file="../includes/sidebarPropietario.jsp"%>
            <div class="main-panel">
                <%@include file="../includes/headerPropietario.jsp"%>
                <div class="content">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="card card-product">
                                    <div class="card-image" data-header-animation="false">
                                        <img src="../../assets/img/encuentrosvs.jpg" class="responsive-img">
                                        <span class="card-title">Encuentros</span>
                                        <div class="ripple-container"></div>
                                    </div>
                                    <div class="card-content">
                                        <div class="card-actions">
                                            <a class="btn btn-danger btn-simple fix-broken-card" rel="tooltip" data-placement="bottom" title="" data-original-title="Ver de nuevo">
                                                <i class="material-icons" style="font-size:30px;">replay</i>
                                                <div class="ripple-container"></div>
                                            </a>
                                            <a href="#" data-toggle="modal" data-target="#noticeModal" class="btn btn-info btn-simple" rel="tooltip" data-placement="bottom" title="" data-original-title="Agregar nuevo jugador">
                                                <i class="material-icons" style="font-size:30px;">add_circle</i>
                                                <div class="ripple-container"></div>
                                            </a>
                                            
                                        </div>
                                        <div class="card-title">
                                            <span>Encuentros en espera</span>
                                        </div>
                                        <%
                                            encuentros enc = new encuentros();
                                            List<Encuentros> listEncuentros = enc.getEncuentrosEspera();
                                        %>
                                        <%for (Encuentros en: listEncuentros){%>
                                            <div class="card-description" id="EncuentrosVer">
                                                <div class="col-lg-4">
                                                    <div class="card card-pricing card-raised">
                                                        <div class="content">
                                                            <h6 class="category">Futbol <%=en.getTipo()%></h6>
                                                            <div class="icon icon-rose">
                                                                <h6 class="text-primary">Estado: <%=en.getEstado()%></h6>
                                                            </div>
                                                                <h3 class="card-title"><%=en.getEquipo_A().getNombre()%> <br>VS<br> <%=en.getEquipo_B().getNombre()%></h3>
                                                            <button class="btn btn-danger btn-round btnFinalizarEncuentro">Finalizar</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="modal fade" id="modalEncuentro" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                                <div class="modal-dialog modal-notice">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><i class="material-icons">clear</i></button>
                                                            <h5 class="modal-title" id="myModalLabel">Marcador Final</h5>
                                                        </div>
                                                        <div class="modal-body">
                                                            <div class="row">
                                                                <div class="col-lg-6">
                                                                    <input hidden value="<%=en.getTipo()%>" id="tipo">
                                                                    <%=en.getEquipo_A().getNombre()%>
                                                                    <input hidden value="<%=en.getEquipo_A().getIdEquipo()%>" id="idA">
                                                                    <input class="form-control" name="marcadorA" id="marcadorA" required type="number"/>
                                                                </div>
                                                                <div class="col-lg-6">
                                                                    <%=en.getEquipo_B().getNombre()%>
                                                                    <input hidden value="<%=en.getEquipo_A().getIdEquipo()%>" id="idB">
                                                                    <input class="form-control" name="marcadorB" id="marcadorB" required type="number"/>
                                                                </div>
                                                                    <input hidden type="text" value="<%=en.getIdEncuantro()%>" id="idEncuentro"/>
                                                            </div>
                                                        </div>
                                                        <div class="modal-footer">
                                                            <button class="btn btn-danger btnFinalizarEnc">Finalizar</button>
                                                        </div>
                                                    </div>
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
        <%@include file="../includes/importsJS.jsp"%> 
        <script type="text/javascript">
            $("#nombrepagina").text("Encuentros en espera");
            $("#encuentros").addClass("active");
            
            CargarNotificacionesPropietario();
        </script>
        <script type="text/javascript">
            $(".btnFinalizarEncuentro").on("click",function(){
                $("#modalEncuentro").modal("show");
            });
            $(".btnFinalizarEnc").on("click",function(){
                var idA=$("#marcadorA").val();
                var idB=$("#marcadorB").val();
                var mA=$("#marcadorA").val();
                var mB=$("#marcadorB").val();
                var iden=$("#idEncuentro").val();
                var tipo = $("#tipo").val();
                $.ajax({
                   url:"/FutPlayFinal/encuentros/finalizarEncuentro",
                   method:"post",
                   dataType:"json",
                   data:{iden:iden,mA:mA,mB:mB,idA:idA,idB:idB,tipo:tipo}
                }).done(function(data){
                    if(data>"0"){
                        $.notify({
                            icon: "mood",
                            message: "Encuentro finalizado exitosamente"
                        },{
                            type: 'success',
                            timer: 2500,
                            placement: {
                                from: 'bottom',
                                align: 'right'
                            }
                        });
                        $("#marcadorA").val();
                        $("#marcadorB").val();
                    }
                    else{
                        $.notify({
                            icon: "sentiment_satisfied",
                            message: "Ocurrio un error!"
                        },{
                            type: 'danger',
                            timer: 2500,
                            placement: {
                                from: 'bottom',
                                align: 'right'
                            }
                        });
                    }
                });
            });
        </script>
    </body>
</html>
