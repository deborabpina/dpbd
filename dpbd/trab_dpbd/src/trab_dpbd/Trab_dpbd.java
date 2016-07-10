/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package trab_dpbd;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author Débora
 */
public class Trab_dpbd {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) throws ClassNotFoundException, SQLException {
        Thread thread = new Thread(new PrimeiraConsulta());
        thread.start();
        Thread thread2 = new Thread(new SegundaConsulta());
        thread2.start();
        
        //let all threads finish execution before finishing main thread
        try {
            thread.join();
            thread2.join();
        } catch (InterruptedException e) {
            System.out.println(e.getMessage());
        }
        
        System.out.println("All threads are dead, exiting main thread");
        
        Class.forName("org.postgresql.Driver");
        Connection conexao1 = DriverManager.getConnection("jdbc:postgresql://localhost:5432/", "postgres", "123");
//        Statement st = conexao1.createStatement();
//        ResultSet rs = st.executeQuery("resultado da thread 1 UNION resultado da thread 2");
        System.out.println("resultado da thread 1 UNION resultado da thread 2");

//        while (rs.next()) {
//            System.out.println("Juntando os resultados!");
//        }
//        rs.close();
//        st.close();
//        conexao1.close(); 
        } 
}
