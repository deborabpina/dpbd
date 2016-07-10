/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dpbd;

import java.sql.*;

/**
 *
 * @author Débora
 */

    
public class PrimeiraConsulta implements Runnable {
  public void rodar () throws ClassNotFoundException, SQLException {
    Class.forName("org.postgresql.Driver");
    Connection conexao1 = DriverManager.getConnection("jdbc:postgresql://localhost:5432/sitio1", "postgres", "123");
    Statement st = conexao1.createStatement();
    ResultSet rs = st.executeQuery("select ");

    while (rs.next()) {
    }
    rs.close();
    st.close();
    conexao1.close();
  }
}

public class SegundaConsulta {
  public void rodar () throws ClassNotFoundException, SQLException {
    Class.forName("org.postgresql.Driver");
    Connection conexao1 = DriverManager.getConnection("jdbc:postgresql://localhost:5432/sitio2", "postgres", "123");
    Statement st = conexao1.createStatement();
    ResultSet rs = st.executeQuery("select ");

    while (rs.next()) {
    }
    rs.close();
    st.close();
    conexao1.close();
  }
}      
    
public class Dpbd {
    public static void main(String[] args)  {
        PrimeiraConsulta primeiraConsulta = new PrimeiraConsulta();
        Thread threadPrimeiraConsulta = new Thread((Runnable) primeiraConsulta);
        threadPrimeiraConsulta.start();

        SegundaConsulta segundaConsulta = new SegundaConsulta();
        Thread threadSegundaConsulta = new Thread ((Runnable) segundaConsulta);
        threadSegundaConsulta.start();

    }

}
