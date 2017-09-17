/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controlador;

import Modelo.Calendar;
import Modelo.Campos;
import Modelo.Canchas;
import Modelo.Encuentros;
import Modelo.Equipo;
import Modelo.HibernateUtil;
import Modelo.Jugador;
import Modelo.Notificacion;
import Modelo.Propietario;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author Andres
 */
public class encuentros extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String url = request.getRequestURI();
        String params[]=url.split("/");
        if(params.length>=3){
            switch(params[3]){
                case "ingresarencuentro":
                    registrarEncuentro(request,response);
                    break;
                case "aceptarencuentro":
                    aceptarEncuentro(request,response);
                    break;
                case "crearencuentro":
                    crearEncuentro(request,response);
                    break;
                case "encuentrosrealizados":
                    encuentrosRealizados(request, response);
                    break;
                case "estadisticas":
                    estadisticasEncuentro(request, response);
                    break;
                case "finalizarEncuentro":
                    finalizarEncuentro(request, response);
                    break;
            }    
        }
    }
    protected void finalizarEncuentro(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try{
            String ma = request.getParameter("mA");
            String mb = request.getParameter("mB");
            String ida = request.getParameter("idA");
            String idb = request.getParameter("idB");
            String tipo = request.getParameter("tipo");
            String marcador=ma+"/"+mb;
            String iden = request.getParameter("iden");
            Session s = HibernateUtil.getSessionFactory().openSession();
            /*Equipo eq1 = new Equipo();
            Equipo eq2 = new Equipo();
            Encuentros en = new Encuentros();
            en.setIdEncuantro(Integer.valueOf(iden));
            en.setMarcador(marcador);
            en.setEstado("Finalizado");
            en.setTipo(tipo);
            eq1.setIdEquipo(Integer.valueOf(ida));
            eq2.setIdEquipo(Integer.valueOf(idb));
            en.setEquipo_A(eq1);
            en.setEquipo_B(eq2);
            en.setFecha_Hora(new Date());
            s.beginTransaction();
            s.update(en);
            s.getTransaction().commit();*/
            Query query = s.createSQLQuery("UPDATE Encuentro SET Estado='Finalizado', Marcador='"+marcador+"' WHERE idEncuentro="+iden+"");
            query.executeUpdate();
            s.beginTransaction().commit();
            s.close();
            response.getWriter().write("1");
        }
        catch(HibernateException | NumberFormatException | IOException ex){
            response.getWriter().write("0");
            System.err.println(ex);
        }
    }
    
    public List<Encuentros> getEncuentrosEspera(){
        List<Encuentros>listen=null;
        Session s = HibernateUtil.getSessionFactory().openSession();
        Query q = s.createQuery("FROM Encuentros");
        listen = q.list();
        return listen;
    }
    protected void registrarEncuentro(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try{
        
            Jugador objJugador = (Jugador) request.getSession().getAttribute("JugadorIngresado");
            
            int sePuede = 0;
            
            int tipo = Integer.parseInt(request.getParameter("tipo"));
            String equipo = request.getParameter("equipo");
            String campo = request.getParameter("campo");
            
            
            Session sesion = HibernateUtil.getSessionFactory().openSession();
            
            Query EquipoJugadorSesion = sesion.createQuery("FROM Jugador WHERE Equipo = "+objJugador.getEquipo()+"");
            List<Jugador>listaJugadorSesion = EquipoJugadorSesion.list();
            if (listaJugadorSesion.size() >= tipo) {
            
                Query query = sesion.createQuery("FROM Jugador WHERE Equipo = "+equipo+"");
                List<Jugador>listaJugador = query.list();


                if (listaJugador.size() >= tipo) {

                    Notificacion objNotificacion = new Notificacion(new Date(), "07:45", "SolicitarEncuentro", "", 0, 0, 0, 0, campo+"/"+String.valueOf(tipo), Integer.parseInt(String.valueOf(objJugador.getEquipo())), Integer.parseInt(equipo));
                    sesion.beginTransaction();
                    sesion.save(objNotificacion);
                    sesion.getTransaction().commit();

                    response.getWriter().write("1");

                }else{

                    response.getWriter().write("2");

                }
                
            }else{
            
                response.getWriter().write("3");
            }
            
            sesion.close();
            
        }catch(HibernateException ex){
            System.err.println(ex);
        }catch(Exception ex){
            System.err.println(ex);
        }
    }
    protected void aceptarEncuentro(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try{
            
            Jugador objJugador = (Jugador) request.getSession().getAttribute("JugadorIngresado");
        
            String equipo = request.getParameter("equipo");
            String campo = request.getParameter("campo");
            String tipo = request.getParameter("tipo");
            
            
            Session sesion = HibernateUtil.getSessionFactory().openSession();
            
            Query queryEncuentro = sesion.createQuery("FROM Encuentros WHERE Equipo_A = "+equipo+" or Equipo_A = "+objJugador.getEquipo()+" AND Equipo_B = "+equipo+" or Equipo_B = "+objJugador.getEquipo()+" AND Estado = 'En espera'");
            List<Encuentros>listaEncuentro = queryEncuentro.list();
            if (listaEncuentro.size() == 0) {
            
                Query queryCampo = sesion.createQuery("FROM Campos WHERE idCampo = "+campo+"");
                List<Campos>listaCampo = queryCampo.list();
                for (Campos campos : listaCampo) {

                    System.out.println(campos.getPropietario());

                    Notificacion objNotificacion = new Notificacion(new Date(), "01:28 P.M", "ConfirmarEncuentro", "", 0, 0, 0, Integer.parseInt(String.valueOf(campos.getPropietario())), tipo+"/"+equipo+"/"+objJugador.getEquipo(), Integer.parseInt(equipo), 0);
                    sesion.beginTransaction();
                    sesion.save(objNotificacion);
                    sesion.getTransaction().commit();

                    response.getWriter().write("1");
                }

            }else{
            
                response.getWriter().write("2");
            }
            
            sesion.close();
            
        }catch(HibernateException ex){
            System.err.println(ex);
        }catch(Exception ex){
            System.err.println(ex);
        }
        
    }
    protected void crearEncuentro(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try{
            Propietario objPropietario = (Propietario) request.getSession().getAttribute("PropietarioIngresado");
            
            int notificacion1 = Integer.parseInt(request.getParameter("idNotificacion"));
            String Fecha = request.getParameter("fecha");
            String Hora = request.getParameter("hora");
            
            String horaf[] = Hora.split(":");
            int hora2 = Integer.parseInt(horaf[0]);
            
            int fechaFinalFinal = hora2 + 1;
            
            System.out.println(Fecha + "   --> " + fechaFinalFinal);
            
            Session sesion = HibernateUtil.getSessionFactory().openSession();
            Query query = sesion.createQuery("FROM Notificacion WHERE idNotificacion = "+notificacion1+"");
            List<Notificacion>listaNotificacion = query.list();
            for (Notificacion notificacion : listaNotificacion) {
                
                System.out.println("-----------------------> ESTOY EN EL FOREACH EN EL CONTROLADOR ENCUENTROS");
                
                String datos[] = notificacion.getDatosAdicionales().split("/");
                /*Calendar objCalendar = new Calendar();
                objCalendar.setTitle("Encuentro");
                objCalendar.setStart(Hora);
                objCalendar.setEnd(Hora);
                objCalendar.setColor("");*/
                
                //Canchas objCancha = new Canchas();
                //objCancha.setIdCancha(0);
                
                //System.out.println(""+objCancha);
                
                Equipo objEquipo1 = new Equipo();
                objEquipo1.setIdEquipo(Integer.parseInt(datos[1]));
                
                Equipo objequipo2 = new Equipo();
                objequipo2.setIdEquipo(Integer.parseInt(datos[2]));
                
                System.out.println("------------------> CRANDO EL ENCUENTRO.......||.|..|.|.|.|..|.|");
                
                Encuentros objEncuentro = new Encuentros(datos[0], new Date(), "", "En espera", objEquipo1, objequipo2);
                sesion.beginTransaction();
                sesion.save(objEncuentro);
                sesion.getTransaction().commit();
                
                
                
                System.out.println("---------------------> GENERANDO LAS NOTIFICACIONES °°°°°°°°°°°°°°°°°°°°°°°°°°|");
                ////////////////////////////// NOTIFICACIONES DE CONFIRMACION DEL ENCUENTRO ////////////////////
                Session sesionNotificacion1 = HibernateUtil.getSessionFactory().openSession();
                Notificacion objNotificacionEquipo1 = new Notificacion(new Date(), "07:35 P.M", "EncuentroConfirmado", "", 0, 0, objPropietario.getIdPropietario(), 0, "", 0, Integer.parseInt(datos[1]));
                sesionNotificacion1.beginTransaction();
                sesionNotificacion1.save(objNotificacionEquipo1);
                sesionNotificacion1.getTransaction().commit();
                sesionNotificacion1.close();
                
                Session sesionNotificacion2 = HibernateUtil.getSessionFactory().openSession();
                Notificacion objNotificacionEquipo2 = new Notificacion(new Date(), "07:35 P.M", "EncuentroConfirmado", "", 0, 0, objPropietario.getIdPropietario(), 0, "", 0, Integer.parseInt(datos[2]));
                sesionNotificacion2.beginTransaction();
                sesionNotificacion2.save(objNotificacionEquipo2);
                sesionNotificacion2.getTransaction().commit();
                sesionNotificacion2.close();
                
                
                response.getWriter().write("1");
            }
            
            sesion.close();
        
        }catch(HibernateException ex){
            System.err.println(ex);
        }catch(Exception ex){
            System.err.println(ex);
        }
    
    }
    protected void encuentrosRealizados(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    
        try{
        
            Jugador objJugador = (Jugador) request.getSession().getAttribute("JugadorIngresado");
            
            if (!"1".equals(objJugador.getEquipo().toString())) {
                
                Session sesion = HibernateUtil.getSessionFactory().openSession();
                Query queryEncuentros = sesion.createQuery("FROM Encuentros WHERE Equipo_A="+objJugador.getEquipo()+" OR Equipo_B="+objJugador.getEquipo()+" AND Marcador != '' OR Marcador != null AND Estado='Finalizado'");
                List<Encuentros>listaEncuentros = queryEncuentros.list();
                if (listaEncuentros.size() > 0) {
                
                    for(Encuentros encuentro : listaEncuentros){
                        String estado = "";
                        String resultado [] = encuentro.getMarcador().split("/");

                        Query buscarEquipo_A = sesion.createQuery("FROM Equipo WHERE idEquipo="+encuentro.getEquipo_A()+"");
                        List<Equipo>listaEquipo_A = buscarEquipo_A.list();

                        Query buscarEquipo_B = sesion.createQuery("FROM Equipo WHERE idEquipo="+encuentro.getEquipo_B()+"");
                        List<Equipo>listaEquipo_B = buscarEquipo_B.list();


                        for(Equipo equipo_A : listaEquipo_A){

                            for (Equipo equipo_B : listaEquipo_B){

                                if (String.valueOf(objJugador.getEquipo()).equals(String.valueOf(equipo_A.getIdEquipo())) & Integer.parseInt(resultado[0]) > Integer.parseInt(resultado[1])) {
                                    estado = "¡GANASTE!";
                                }else if (String.valueOf(objJugador.getEquipo()).equals(String.valueOf(equipo_B.getIdEquipo())) & Integer.parseInt(resultado[0]) < Integer.parseInt(resultado[1])) {
                                    estado = "¡GANASTE!";
                                }else if (String.valueOf(objJugador.getEquipo()).equals(String.valueOf(equipo_A.getIdEquipo())) & Integer.parseInt(resultado[0]) < Integer.parseInt(resultado[1])) {
                                    estado = "PERDISTE";
                                }else if (String.valueOf(objJugador.getEquipo()).equals(String.valueOf(equipo_B.getIdEquipo())) & Integer.parseInt(resultado[0]) > Integer.parseInt(resultado[1])) {
                                    estado = "PERDISTE";
                                }else{

                                    estado = "EMPATE";
                                }

                                response.getWriter().write("<div class='col-lg-4'>"
                                                        +"<div class='card card-pricing card-raised'>"
                                                            +"<div class='content'>"
                                                                +"<h4 class='card-title'>"+equipo_A.getNombre()+"  <strong>VS</strong>  "+equipo_B.getNombre()+"</h4>"
                                                                +"<div class='icon icon-rose'>"
                                                                    +"<h2>"+resultado[0]+" - "+resultado[1]+"</h2>"
                                                                +"</div>"
                                                                +"<h3><strong>"+estado+"</strong></h3>"
                                                            +"</div>"
                                                        +"</div>"
                                                  +"</div>");

                            }

                        }

                    }
                }else{
                
                    response.getWriter().write("2");
                }
                
                sesion.close();
                
            }
            
        }catch(HibernateException ex){
            System.err.println(ex);
            response.getWriter().write("1");
        }catch(Exception ex){
            System.err.println(ex);
            response.getWriter().write("1");
        }
        
    }
    protected void estadisticasEncuentro(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try{
            int eneG=0,febG=0,marG=0,abrG=0,mayG=0,junG=0,julG=0,agoG=0,sepG=0,octG=0,novG=0,dicG=0;
            int eneP=0,febP=0,marP=0,abrP=0,mayP=0,junP=0,julP=0,agoP=0,sepP=0,octP=0,novP=0,dicP=0;
            int eneE=0,febE=0,marE=0,abrE=0,mayE=0,junE=0,julE=0,agoE=0,sepE=0,octE=0,novE=0,dicE=0;
            int eneF=0,febF=0,marF=0,abrF=0,mayF=0,junF=0,julF=0,agoF=0,sepF=0,octF=0,novF=0,dicF=0;

            
            Jugador objJugador = (Jugador) request.getSession().getAttribute("JugadorIngresado");
        
            Session sesion = HibernateUtil.getSessionFactory().openSession();
            Query encuentrosEquipo = sesion.createQuery("FROM Encuentros WHERE Equipo_A = "+objJugador.getEquipo()+" OR Equipo_B = "+objJugador.getEquipo()+" AND Estado = 'Finalizado'");
            List<Encuentros>listaEncuentros = encuentrosEquipo.list();
            
            for(Encuentros encuentro : listaEncuentros){
            
                String resultado [] = encuentro.getMarcador().split("/");
                int estado = 0;

                if (String.valueOf(objJugador.getEquipo()).equals(String.valueOf(encuentro.getEquipo_A())) & Integer.parseInt(resultado[0]) > Integer.parseInt(resultado[1])) {
                    estado = 1;
                }else if (String.valueOf(objJugador.getEquipo()).equals(String.valueOf(encuentro.getEquipo_B())) & Integer.parseInt(resultado[0]) < Integer.parseInt(resultado[1])) {
                    estado = 1;
                }else if (String.valueOf(objJugador.getEquipo()).equals(String.valueOf(encuentro.getEquipo_A())) & Integer.parseInt(resultado[0]) < Integer.parseInt(resultado[1])) {
                    estado = 0;
                }else if (String.valueOf(objJugador.getEquipo()).equals(String.valueOf(encuentro.getEquipo_B())) & Integer.parseInt(resultado[0]) > Integer.parseInt(resultado[1])) {
                    estado = 0;
                }else{

                    estado = 2;
                }
                
                
                String mes [] = String.valueOf(encuentro.getFecha_Hora()).split("-");
                
                switch (mes[1]){
                    case "01":
                        if (estado == 0) {
                            eneP++;
                        }else if (estado == 1) {
                            eneG++;
                        }else if (estado == 2) {
                            eneE++;
                        }
                        
                    break;
                    case "02":
                        if (estado == 0) {
                            febP++;
                        }else if (estado == 1) {
                            febG++;
                        }else if (estado == 2) {
                            febP++;
                        }
                    break;
                    case "03":
                        if (estado == 0) {
                            marP++;
                        }else if (estado == 1) {
                            marG++;
                        }else if (estado == 2) {
                            marE++;
                        }
                    break;
                    case "04":
                        if (estado == 0) {
                            abrP++;
                        }else if (estado == 1) {
                            abrG++;
                        }else if (estado == 2) {
                            abrE++;
                        }
                    break;
                    case "05":
                        if (estado == 0) {
                            mayP++;
                        }else if (estado == 1) {
                            mayG++;
                        }else if (estado == 2) {
                            mayE++;
                        }
                    break;
                    case "06":
                        if (estado == 0) {
                            junP++;
                        }else if (estado == 1) {
                            junG++;
                        }else if (estado == 2) {
                            junE++;
                        }
                    break;
                    case "07":
                        if (estado == 0) {
                            julP++;
                        }else if (estado == 1) {
                            julG++;
                        }else if (estado == 2) {
                            julE++;
                        }
                    break;
                    case "08":
                        if (estado == 0) {
                            agoP++;
                        }else if (estado == 1) {
                            agoG++;
                        }else if (estado == 2) {
                            agoE++;
                        }
                    break;
                    case "09":
                        if (estado == 0) {
                            sepP++;
                        }else if (estado == 1) {
                            sepG++;
                        }else if (estado == 2) {
                            sepE++;
                        }
                    break;
                    case "10":
                        if (estado == 0) {
                            octP++;
                        }else if (estado == 1) {
                            octG++;
                        }else if (estado == 2) {
                            octE++;
                        }
                    break;
                    case "11":
                        if (estado == 0) {
                            novP++;
                        }else if (estado == 1) {
                            novG++;
                        }else if (estado == 2) {
                            novE++;
                        }
                    break;
                    case "12":
                        if (estado == 0) {
                            dicP++;
                        }else if (estado == 1) {
                            dicG++;
                        }else if (estado == 2) {
                            dicE++;
                        }
                    break;
                
                }
                
            }
            if (eneG > eneP) {
                
                eneF = 65;
            }else if (eneG < eneP){
                eneF = 25;
            }
            if (febG > febP) {
                febF = 80;
            }else if (febG < febP) {
                febF = 15;
            }
            if (marG > marP) {
                marF = 76;
            }else if (marG < marP) {
                marF = 28;
            }
            if (abrG > abrP) {
                abrF = 77;
            }else if (abrG < abrP) {
                abrF = 30;
            }
            if (mayG > mayP) {
                mayF = 90;
            }else if (mayG < mayP) {
                mayF = 40;
            }
            if (junG > junP) {
                junF = 65;
            }else if (junG < junP) {
                junF = 45;
            }
            if (julG > julP) {
                julF = 55;
            }else if (julG < julP) {
                julF = 20;
            }
            if (agoG > agoP) {
                agoF = 80;
            }else if (agoG < agoP) {
                agoF = 35;
            }
            if (sepG > sepP) {
                sepF = 75;
            }else if (sepG < sepP) {
                sepF = 24;
            }
            if (octG > octP) {
                octF = 77;
            }else if (octG < octP) {
                octF = 40;
            }
            if (novG > novP) {
                novF = 98;
            }else if (novG < novP) {
                novF = 23;
            }
            if (dicG > dicP) {
                dicF = 100;
            }else if (dicG < dicP) {
                dicF = 0;
            }
            
            response.getWriter().write(""+eneF+","+febF+","+marF+","+abrF+","+mayF+","+junF+","+julF+","+agoF+","+sepF+","+octF+","+novF+","+dicF+"");
            sesion.close();
        }catch(HibernateException ex){
            System.err.println(ex);
        }catch(Exception ex){
            System.err.println(ex);
        }
    }
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
