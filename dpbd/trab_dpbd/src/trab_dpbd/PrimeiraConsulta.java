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
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Débora
 */
public class PrimeiraConsulta implements Runnable {
    @Override
    public void run(){
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(PrimeiraConsulta.class.getName()).log(Level.SEVERE, null, ex);
        }
        Connection conexao1 = null;
        try {
            conexao1 = DriverManager.getConnection("jdbc:postgresql://localhost:5432/sitio1", "postgres", "123");
        } catch (SQLException ex) {
            Logger.getLogger(PrimeiraConsulta.class.getName()).log(Level.SEVERE, null, ex);
        }
        Statement st = null;
        try {
            st = conexao1.createStatement();
        } catch (SQLException ex) {
            Logger.getLogger(PrimeiraConsulta.class.getName()).log(Level.SEVERE, null, ex);
        }
        ResultSet rs = null;
        try {
            rs = st.executeQuery("select * from \"scc2-edgecfd\".dl_pre;");
        } catch (SQLException ex) {
            Logger.getLogger(PrimeiraConsulta.class.getName()).log(Level.SEVERE, null, ex);
        }

        try {
            while (rs.next()) {
                System.out.println("Runnable consulta 1 running");
                System.out.println(rs.getString("rid"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(PrimeiraConsulta.class.getName()).log(Level.SEVERE, null, ex);
        }
        try {
            rs.close();
        } catch (SQLException ex) {
            Logger.getLogger(PrimeiraConsulta.class.getName()).log(Level.SEVERE, null, ex);
        }
        try {
            st.close();
        } catch (SQLException ex) {
            Logger.getLogger(PrimeiraConsulta.class.getName()).log(Level.SEVERE, null, ex);
        }
        try {        
            conexao1.close();
        } catch (SQLException ex) {
            Logger.getLogger(PrimeiraConsulta.class.getName()).log(Level.SEVERE, null, ex);
        }      
    }
}
