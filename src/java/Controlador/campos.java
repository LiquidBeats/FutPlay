package Controlador;

import Modelo.Campos;
import Modelo.HibernateUtil;
import Modelo.Jugador;
import Modelo.Propietario;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.json.simple.JSONArray;

public class campos extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = request.getRequestURI();
        String params[]=url.split("/");
        if(params.length>=3){
            switch(params[3]){
                case "registrarcampo":
                    registrarCampo(request,response);
                    break;
                case "eliminar":
                    eliminarCampo(request,response);
                    break;
                case "actualizarcampo":
                    actualizarCampo(request,response);
                    break;
                case "getJSONCampo":
                    getJSONCampo(request,response);
                    break;
                case "checkCampos":
                    checkCampos(request,response);
                    break;
                case "camposSobresalientes":
                    camposSobresalientes(request,response);
                    break;  
                case "buscarCampo":
                    buscarCampo(request,response);
                    break;
//                case "likeCampo":
//                    likesCampo(request,response);
//                    break; 
//                case "dislikeCampo":
//                    dislikeCampo(request,response);
//                    break;    
            }    
        }       
    }
    
    protected void registrarCampo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try{
            Propietario prp = (Propietario)request.getSession().getAttribute("PropietarioIngresado");
            Propietario prop = new Propietario();
            prop.setIdPropietario(prp.getIdPropietario());
            String nombrecampo = request.getParameter("nombrecampo");
            String direccioncampo = request.getParameter("direccioncampo");
            String ubicacion = request.getParameter("ubicacion");
            String horarioapertura = request.getParameter("horarioapertura");
            String horariocierre = request.getParameter("horariocierre");
            String horario = horarioapertura+"/"+horariocierre;
            String foto = request.getParameter("fotocampo");
            if(foto.equals("")){
                foto="no_preview.jpg";
            }
            Session s = HibernateUtil.getSessionFactory().openSession();
            Campos cmp = new Campos(0,nombrecampo, direccioncampo, ubicacion, horario, foto, prop);
            try{
                s.beginTransaction();
                s.save(cmp);
                s.getTransaction().commit();
                s.close();
                response.getWriter().write("1");
            }
            catch(HibernateException ex){
                System.err.println(ex);
                response.getWriter().write("0");
            }    
        }
        catch(IOException | NumberFormatException | HibernateException ex){
            System.err.println(ex);
            response.getWriter().write("0");
        }
    }
    
    protected void eliminarCampo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try{
            int idcampo = Integer.valueOf(request.getParameter("idcampo"));
            Campos cmp = new Campos();
            cmp.setIdCampo(idcampo);
            Session s = HibernateUtil.getSessionFactory().openSession();
            try{
                s.beginTransaction();
                s.delete(cmp);
                s.getTransaction().commit();
                s.close();
                response.getWriter().write("1");
            }
            catch(IOException | HibernateException ex){
                response.getWriter().write("0");
            }
        }
        catch(NumberFormatException | HibernateException ex){
            response.getWriter().write("0");
        }
    }
    
    public List<Campos> getAll(HttpServletRequest request, HttpServletResponse response){
        List<Campos> listCampos = null;
        Propietario pr = (Propietario) request.getSession().getAttribute("PropietarioIngresado");
        try{
            Session s = HibernateUtil.getSessionFactory().openSession();   
            Query q = s.createQuery("FROM Campos WHERE Propietario = '"+pr.getIdPropietario()+"'");
            listCampos = q.list();
        }
        catch(Exception ex){
            System.out.println(ex);
        }
        return listCampos;
    }
    
    protected void actualizarCampo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try{
            int idcampo = (int) request.getSession().getAttribute("idcampoUP");
            String nombreUP = request.getParameter("nombrecampoUP");
            String direccionUP = request.getParameter("direccioncampoUP");
            String ubicacionUP = request.getParameter("ubicacionUP");
            String horarioabreUP = request.getParameter("horarioatencionabreUP");
            String horariocierreUP = request.getParameter("horarioatencioncierreUP");
            String horariosUP = horarioabreUP+"/"+horariocierreUP;
            String foto = request.getParameter("fotocampoUP");
            Propietario pr = new Propietario();
            Propietario prs = (Propietario) request.getSession().getAttribute("PropietarioIngresado");
            pr.setIdPropietario(prs.getIdPropietario());
            Campos cmp = new Campos(idcampo,nombreUP, direccionUP, ubicacionUP, horariosUP, foto, pr);
            Session s = HibernateUtil.getSessionFactory().openSession();
            try{
                s.beginTransaction();
                s.update(cmp);
                s.getTransaction().commit();
                s.close();
                response.getWriter().write("1");
            }
            catch(HibernateException ex){
                response.getWriter().write("0");
                System.out.println(ex);
            }
        }
        catch(IOException | NumberFormatException | HibernateException ex){
            response.getWriter().write("0");
            System.out.println(ex);
        }
    }
    
    protected void getJSONCampo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        JSONArray  campo = new JSONArray();
        int idcampo = Integer.valueOf(request.getParameter("idcampo"));
        Session s = HibernateUtil.getSessionFactory().openSession();
        Query q = s.createQuery("FROM Campos WHERE idCampo = '"+idcampo+"'");
        List<Campos> listCampo = q.list();
        
        for (Campos cm : listCampo) {
            campo.add(cm.getNombre());
            campo.add(cm.getDireccion());
            campo.add(cm.getHorario());
            campo.add(cm.getFoto());
        }
        response.setContentType("application/json");
        response.getWriter().write(campo.toJSONString());
        request.getSession().setAttribute("idcampoUP", idcampo);
    }
    
    protected void checkCampos(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idProp = request.getParameter("idPropietario");
        String rt="0";
        Session s = HibernateUtil.getSessionFactory().openSession();
        Query q = s.createQuery("FROM Campos WHERE Propietario ='"+idProp+"'");
        List<Campos> list = q.list();
        if(list.size()>0){
            rt="1";
        }
        response.getWriter().write(rt);
    }
    //////////////// SE RETORNAN TODOS LOS CAMPOS EXISTENTES ////////////////////////7
    public List<Campos> verCampos(){
    
        List<Campos>listaCampos = null;
        
        try{
            
            Session sesion = HibernateUtil.getSessionFactory().openSession();
            Query query = sesion.createQuery("FROM Campos");
            listaCampos = query.list();
            
        }catch(HibernateException ex){
        
            System.err.println(ex);
        }catch(Exception ex){
        
            System.err.println(ex);
        }
        return listaCampos;
    
    }
    protected void camposSobresalientes(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
           try{
               
           Session se= HibernateUtil.getSessionFactory().openSession();
           Query query = se.createQuery("FROM Campos");
            query.setMaxResults(10);
            List<Campos>listaCampos = query.list();
            for(Campos campos : listaCampos){

                 Query queryCapitan = se.createQuery("FROM Propietario WHERE idPropietario = "+campos.getPropietario()+"");
                    List<Propietario>listPropi = queryCapitan.list();
                        for(Propietario Prop : listPropi){
                           // String ubicacion = campos.getUbicacion();
                
                    response.getWriter().write("<div class='card-description'>"
                                                    +"<div class='col-lg-4'>"
                                                        +"<div class='card card-pricing card-raised'>"
                                                            +"<div class='content'>"
                                                                +"<h3 class='category'>"+campos.getNombre()+"</h3>"
                                                                +"<div class='icon icon-rose'>"
                                                                    +"<img class='avatar' src='/FutPlayFinal/Imagenes/"+campos.getFoto()+"' style='width: 120px;height: 120px;'>"
                                                                +"</div>"     
                                                                    +"<button class='btn btn-primary btn-simple btnMapCampo' rel='tooltip' data-placement='bottom' title='Ubicacion en Google maps' value="+campos.getUbicacion()+">"
                                                                        +"<i class='material-icons' style='font-size: 25px;'>location_on</i>"
                                                                    +"</button>"
                                                                        +"<p class='card-description'>"+campos.getDireccion()+"</p>"
                                                                        +"<p><i class='material-icons' style='font-size:20px;'>face</i> Propietario: "+Prop.getPersona().getNombres() +" "+Prop.getPersona().getApellidos()+"</p>"    
                                                                //+"<a class='btn btn-primary  btnCalificar' rel='tooltip' data-toggle='modal' data-target='#modalCampoCalificar' id='idCampo' value='"+campos.getIdCampo()+"'>Calificar</a>"
                                                            +"</div>"
                                                        +"</div>"
                                                    +"</div>"
                                                +"</div>");
                
                }
                
            }
            se.close();
           }catch(HibernateException ex){
               System.err.print(ex);
           }
            }
       
       protected void buscarCampo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            String valor = request.getParameter("Valor");
           
           try{    
               
                if (valor.equals("") || valor == null) {
                    
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write("0");
                    
                }else{
               Session sesion = HibernateUtil.getSessionFactory().openSession();
                    Query query = sesion.createQuery("FROM Campos WHERE Nombre like '%"+valor+"%' OR Direccion like '%"+valor+"%' OR Propietario like '%"+valor+"%'");
                    List<Campos>listCampo = query.list();

                    response.setCharacterEncoding("UTF-8");
                    for(Campos campo : listCampo){
                        
                        Query q = sesion.createQuery("FROM Propietario WHERE idPropietario = "+campo.getPropietario()+"");
                        List<Propietario> ListaPro = q.list();
                            for(Propietario propietario : ListaPro){
                    response.getWriter().write("<div class='card-description'>"
                                                    +"<div class='col-lg-6'>"
                                                        +"<div class='card card-pricing card-raised'>"
                                                            +"<div class='content'>"
                                                                +"<h3 class='category'>"+campo.getNombre()+"</h3>"
                                                                +"<div class='icon icon-rose'>"
                                                                    +"<img class='avatar' src='/FutPlayFinal/Imagenes/"+campo.getFoto()+"' style='width: 120px;height: 120px;'>"
                                                                +"</div>"     
                                                                    +"<button class='btn btn-primary btn-simple btnMapCampo' rel='tooltip' data-placement='bottom' title='Ubicacion en Google maps' value="+campo.getUbicacion()+">"
                                                                        +"<i class='material-icons' style='font-size: 25px;'>location_on</i>"
                                                                    +"</button>"
                                                                        +"<p class='card-description'>"+campo.getDireccion()+"</p>"
                                                                        +"<p><i class='material-icons' style='font-size:20px;'>face</i> Propietario: "+propietario.getPersona().getNombres() +" "+propietario.getPersona().getApellidos()+"</p>"    
                                                               // +"<a href='/FutPlayFinal/jugador/verCampo' class='btn btn-danger btn-round'>Calificar</a>"
                                                            +"</div>"
                                                        +"</div>"
                                                    +"</div>"
                                                +"</div>");
                    }

                    }
                    sesion.close();
                }
                }catch(HibernateException ex){
            
                System.err.println(ex);
            
            }
        }
//protected void likesCampo(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//     try{
//            String finalCalf = "";
//            int tipoDeCalificacion = 0;
//            
//            Jugador objSesion = (Jugador) request.getSession().getAttribute("JugadorIngresado");
//            Campos campo=new Campos();
//            Session sesion = HibernateUtil.getSessionFactory().openSession();
//            if (!"".equals(campo.getLike())) {
//                
//                String likesCampos = campo.getLike();
//                String calificados[] = likesCampos.split("/");
//                if (calificados.length >= 1) {
//                    
//                    for (int i = 0; i < calificados.length; i++) {
//                        
//                        String campos[] = calificados[i].split("~");
//                        
//                        if (campos[0].equals(String.valueOf(objSesion.getIdJugador())) & campos[1].equals("1")) {
//                            
//                            response.getWriter().write("1");
//                            //////////// INDICA QUE YA ESTA CALIFICADO //////////
//                            System.out.println("EL CAMPO YA TIENE UN LIKE..");
//                            
//                        }else{
//                            System.out.println("    no tiene lo que quire hacer");
//                            if (campos[0].equals(String.valueOf(objSesion.getIdJugador())) & campos[1].equals("0")) {
//                                
//                                String contenedor = "";
//                               
//                                /////////// HAY QUE DESARMAR Y VOLVER A ARMAR EL STRING ////////
//                                for (int j = 0; j < calificados.length; j++) {
//                                    
//                                    String desarmar[] = calificados[j].split("~"); 
//                                    
//                                    if (desarmar[0].equals(String.valueOf(objSesion.getIdJugador()))) {
//                                        
//                                        contenedor += ""+String.valueOf(objSesion.getIdJugador())+"~1/";
//                                        System.out.println("CONTENECOR 1---> "+contenedor);
//                                    }else{
//                                    
//                                        contenedor += calificados[j]+"/";
//                                        System.out.println("CONTENEDOR 2----> "+contenedor);
//                                    }
//                                    
//                                }
//                                System.out.println("ESTE EL EL ERROR MAS GAY ---> " + contenedor);
//                                System.out.println("cacacacacacacacacacacacacacacacacacacca....cacacac...caca...ca");
//                                
//                                finalCalf = "";
//                                finalCalf = contenedor;
//                                
//                                System.out.println("ESTE EL EL FINAL CALF ---> " +finalCalf);
//                                
//                                tipoDeCalificacion = 1;
//                                
//                            }else{
//                                ////// HAY QUE AGREGAR LA NUEVA CALIFICACION ///////////
//                                finalCalf = ""+campo.getLike()+String.valueOf(objSesion.getIdJugador())+"~1/";
//                                System.out.println("olpoopopo ---> " +i);
//                                if (i+1 == calificados.length) {
//                                
//                                    tipoDeCalificacion = 2;
//                                }
//                            
//                            }
//                        }
//                        
//                    }
//                    
//                    if (tipoDeCalificacion == 1) {
//                        
//                        System.out.println("HACIENDO EL INSERT %%%%%%%%%%% -->  " + finalCalf);
//                        
//                        ////// SE EJECUTA LA ACTUALIZACION O EL INGRESO DE LA CALIFICACION ////
//                        Query UpdateCampo = sesion.createSQLQuery("UPDATE Campos SET Likee='"+finalCalf+"'");
//                        sesion.beginTransaction();
//                        UpdateCampo.executeUpdate();
//                        sesion.getTransaction().commit();
//
//                        
//
//                        response.getWriter().write("2");
//                        
//                    }else if (tipoDeCalificacion == 2) {
//                        
//                        System.out.println("TIPO DE CALIFICACION #2 -----<>");
//                        ////// SE EJECUTA LA ACTUALIZACION O EL INGRESO DE LA CALIFICACION ////
//                        Query updateCampo = sesion.createSQLQuery("UPDATE Campos SET Likee='"+finalCalf+"'");
//                        sesion.beginTransaction();
//                        updateCampo.executeUpdate();
//                        sesion.getTransaction().commit();
//
//                        
//                        response.getWriter().write("2");
//                        
//                    }
//                    
//                }
//                
//            }else{
//            
//                finalCalf = ""+String.valueOf(objSesion.getIdJugador())+"~1/";
//                Query actCampo = sesion.createSQLQuery("UPDATE Campos SET Likee='"+finalCalf+"'");
//                sesion.beginTransaction();
//                actCampo.executeUpdate();
//                sesion.getTransaction().commit();
//                           
//                response.getWriter().write("2");
//                
//            }
//        
//            sesion.close();
//            
//            
//        }catch(HibernateException ex){
//        
//            System.err.println(ex);
//        }catch(Exception ex){
//        
//            System.err.println(ex);
//        }
//        
//
//}
//protected void dislikeCampo(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//    
//        try{
//                   
//            String finalCalf = "";
//            int tipoDeCalificacion = 0;
//            
//            Jugador objJugadorSesion = (Jugador) request.getSession().getAttribute("JugadorIngresado");
//              Campos campo=new Campos();
//            
//            Session sesion = HibernateUtil.getSessionFactory().openSession();
//            if (!"".equals(campo.getDislike())) {
//                
//                String dislikeCampo = campo.getDislike();
//                String calificados[] = dislikeCampo.split("/");
//                System.out.println("LLLLLOOOOOOOOOLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL"+calificados[0]);
//                if (calificados.length >= 1) {
//                    
//                    for (int i = 0; i < calificados.length; i++) {
//                        
//                        String usuario[] = calificados[i].split("~");
//                        
//                        if (usuario[0].equals(String.valueOf(objJugadorSesion.getIdJugador())) & usuario[1].equals("0")) {
//                            
//                            response.getWriter().write("1");
//                            //////////// INDICA QUE YA ESTA CALIFICADO //////////
//                            System.out.println("EL JUGADOR YA TIENE UN DISLIKE..");
//                            
//                        }else{
//                            System.out.println("    no tiene lo que quire hacer");
//                            if (usuario[0].equals(String.valueOf(objJugadorSesion.getIdJugador())) & usuario[1].equals("1")) {
//                                
//                                String contenedor = "";
//                                System.out.println("HAY QUE CAMBIAR DE LIKE A DISLIKE. lol");
//                                /////////// HAY QUE DESARMAR Y VOLVER A ARMAR EL STRING ////////
//                                for (int j = 0; j < calificados.length; j++) {
//                                    
//                                    String desarmar[] = calificados[j].split("~"); 
//                                    
//                                    if (desarmar[0].equals(String.valueOf(objJugadorSesion.getIdJugador()))) {
//                                        
//                                        contenedor += ""+String.valueOf(objJugadorSesion.getIdJugador())+"~0/";
//                                    }else{
//                                    
//                                        contenedor += calificados[j]+"/";
//                                    }
//                                    System.out.println("ESTE EL EL ERROR MAS GAY ---> " + contenedor);
//                                    System.out.println("cke");
//                                    finalCalf = contenedor;
//                                    tipoDeCalificacion = 1;
//                                    
//                                }
//                            }else{
//                                ////// HAY QUE AGREGAR LA NUEVA CALIFICACION ///////////
//                                finalCalf = ""+campo.getDislike()+String.valueOf(objJugadorSesion.getIdJugador())+"~0/";
//                                System.out.println("olpoopopo ---> " +i);
//                                if (i+1 == calificados.length) {
//                                
//                                    tipoDeCalificacion = 2;
//                                }
//                            
//                            }
//                        }
//                        
//                    }
//                    
//                    if (tipoDeCalificacion == 1) {
//                        
//                        ////// SE EJECUTA LA ACTUALIZACION O EL INGRESO DE LA CALIFICACION ////
//                        Query actuCampo = sesion.createSQLQuery("UPDATE Campos SET Dislike='"+finalCalf+"'");
//                        sesion.beginTransaction();
//                        actuCampo.executeUpdate();
//                        sesion.getTransaction().commit();
//
//                        
//                        response.getWriter().write("2");
//                        
//                    }else if (tipoDeCalificacion == 2) {
//                        
//                        
//                        ////// SE EJECUTA LA ACTUALIZACION O EL INGRESO DE LA CALIFICACION ////
//                        Query actualizarCampo = sesion.createSQLQuery("UPDATE Campos SET Dislike='"+finalCalf+"'");
//                        sesion.beginTransaction();
//                        actualizarCampo.executeUpdate();
//                        sesion.getTransaction().commit();
//
//                    
//                        response.getWriter().write("2");
//                        
//                    }
//                    
//                }
//                
//            }else{
//            
//                finalCalf = ""+String.valueOf(objJugadorSesion.getIdJugador())+"~0/";
//                Query actualizarCampo = sesion.createSQLQuery("UPDATE Campos SET Dislike='"+finalCalf+"'");
//                sesion.beginTransaction();
//                actualizarCampo.executeUpdate();
//                sesion.getTransaction().commit();
//            
//                
//                response.getWriter().write("2");
//                
//            }
//        
//            sesion.close();
//            
//        }catch(HibernateException ex){
//        
//            System.err.println(ex);
//            
//        }catch(Exception ex){
//        
//            System.err.println(ex);
//        }
//}        

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
