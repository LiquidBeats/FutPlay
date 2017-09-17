<%@page import="Modelo.Persona"%>
<%@page import="Modelo.Jugador"%>
<%  
    Jugador objJugador = (Jugador) request.getSession().getAttribute("JugadorIngresado");
    Persona objPersona = (Persona) request.getSession().getAttribute("UsuarioIngresado");
    
    response.setHeader("Cache-Control","no-cache"); //Forces caches to obtain a new copy of the page from the origin server
    response.setHeader("Cache-Control","no-store"); //Directs caches not to store the page under any circumstance
    response.setDateHeader("Expires", 0); //Causes the proxy cache to see the page as "stale"
    response.setHeader("Pragma","no-cache"); //HTTP 1.0 backward compatibility
    try{      
        if(session.getAttribute("JugadorIngresado").equals(null)){
            response.sendRedirect("/FutPlayFinal/index.html");
        }else{%>
        
            <%
                System.out.println("EEEEEEEEESTA CONTINUANDO 000000000000000000000000000000000");
                
            %>
            <div class="sidebar" data-active-color="red" data-background-color="black" data-image="/FutPlayFinal/material-dashboard/assets/img/jugadorimg/football-field-night.jpg">
                <div class="logo">
                    <a href="/FutPlayFinal/material-dashboard/pages/jugador/indexJugador.jsp" class="simple-text">
                        FutPlay
                    </a>
                </div>
                <div class="logo logo-mini">
                    <a href="/FutPlayFinal/material-dashboard/pages/jugador/indexJugador.jsp" class="simple-text">
                        <img src="../../assets/img/favicon.png" style="width:35px;height: 35px;"/>
                    </a>
                </div>
                <div class="sidebar-wrapper">
                    <div class="user">
                        <div class="photo">
                            <%if(objJugador.getPersona().getAvatar().length()>=100){%>
                                <img class="img" src="<%=objJugador.getPersona().getAvatar()%>">
                            <%}else{%>
                                <img class="img" src="/FutPlayFinal/material-dashboard/assets/img/avatares/<%=objJugador.getPersona().getAvatar()%>">
                            <%}%>
                        </div>
                        <div class="info">
                            <a data-toggle="collapse" href="#collapseExample" class="collapsed">
                                <%= objJugador.getAlias()%>
                                <b class="caret"></b>
                            </a>
                            <div class="collapse" id="collapseExample">
                                <ul class="nav">
                                    <li>
                                        <a href="../jugador/verPerfilJugador.jsp">Ver perfil</a>
                                    </li>
                                    <li>
                                        <a href="../jugador/editarPerfilJugador.jsp">Editar perfil</a>
                                    </li>
                                    <li>
                                        <a href="../usuario/ajustesdecuenta.jsp">Ajustes</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <ul class="nav">
                        <li id="iniciojugador">
                            <a href="../jugador/indexJugador.jsp">
                                <i class="material-icons">dashboard</i>
                                <p>Inicio</p>
                            </a>
                        </li>
                        <li id="equipo">
                            <a href="../equipo/verEquipo.jsp">
                                <i class="material-icons">people</i>
                                <p>Mi equipo</p>
                            </a>
                        </li>
                        <li id="jugadores">
                            <a href="../jugador/verJugadores.jsp">
                                <i class="material-icons">person</i>
                                <p>Jugadores</p>
                            </a>
                        </li>
                        <li id="charla">
                            <a href="../mensaje/charlaSockets.jsp">
                                <i class="material-icons">message</i>
                                <p>Charla tecnica</p>
                            </a>
                        </li>
                        <li id="encuentro">
                            <a href="../encuentro/verEncuentros.jsp">
                                <i class="material-icons">flash_on</i>
                                <p>Encuentros</p>
                            </a>
                        </li>
                    </ul>
                </div>
                </div>
        <%}     
    }  
    catch(Exception ex){
        response.sendRedirect("/FutPlayFinal/index.html");
    }
%>
