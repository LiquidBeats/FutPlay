package Modelo;

import java.util.ArrayList;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author Andres
 */
public class RecibirMensajes {
    
    public List<Mensaje> listarMensajes(String equipo){
        
        System.out.println("LISTANDO LOS MENSAJES -------------- =)   " + equipo);
        Session sesion = HibernateUtil.getSessionFactory().openSession();
        Query query = sesion.createQuery("FROM Mensaje WHERE Equipo="+equipo+"");
        List<Mensaje> listaMensajes = query.list();
    
        return listaMensajes;
    }
    public List<Mensaje> ListarUltimoMensaje(String equipo){
    
        String[] eq = equipo.split("~");
        System.out.println("LISTANDO ULTIMO MENSAJE -------------- =)   " + eq[2]);
        Session sesion = HibernateUtil.getSessionFactory().openSession();
        Query query = sesion.createQuery("FROM Mensaje WHERE Equipo="+eq[2]+"");
        List<Mensaje> listaMensajes = query.list();
        return listaMensajes;
    }
    public String ingresarMensaje(String equipo){
        
        System.out.println("INGRESANDO MENSAJES <------------------->");
        
        String [] datosMensajes = equipo.split("~");
        
        
        try{
            
            int hora, minutos, segundos; 
            java.util.Calendar calendario = new GregorianCalendar();
            hora = calendario.get(java.util.Calendar.HOUR);
            minutos = calendario.get(java.util.Calendar.MINUTE);
            
            Equipo objEquipo = new Equipo();
            objEquipo.setIdEquipo(Integer.parseInt(datosMensajes[2]));
            
            Jugador objJugador = new Jugador();
            objJugador.setIdJugador(Integer.parseInt(datosMensajes[1]));
            
            System.out.println("EQUIPO:    "+objEquipo + "JUGADOR:     "+objEquipo);
            
            Session sesion = HibernateUtil.getSessionFactory().openSession();
            Mensaje objMensaje = new Mensaje(datosMensajes[0], new Date(), String.valueOf(hora)+":"+String.valueOf(minutos), objJugador, objEquipo);
            sesion.beginTransaction();
            sesion.save(objMensaje);
            sesion.getTransaction().commit();
            sesion.close();

         }catch(HibernateException ex){

             System.err.println(ex);

         }
        
        
        return null;
    }
    
    
}
