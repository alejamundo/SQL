package config;

import java.sql.*;

public class Conexion {


    public static Connection getConexion(String user,String clave) {

        String conexionUrl = "jdbc:sqlserver://localhost:1433;" //el localhost es el nombre del servidor, y el 1433 el puerto
                + "database =Proyectocto_Nautas_Busos;"
                + "user ="+user+";" //Ingresa aquí el nombre del usuario creado
                + "password ="+clave+";" //la contrase{a
                + "loginTimeout =30;"
                + "encrypt=true;"
                + "trustServerCertificate=true";
        try {
            Connection con = DriverManager.getConnection(conexionUrl);
            System.out.println("Conectada");
            return con;

        } catch (SQLException ex) {
            System.out.println("Error: "+ex.toString());
            return null;
        }
    }
    public static Connection getConexion() {

        String conexionUrl = "jdbc:sqlserver://localhost:1433;" //el localhost es el nombre del servidor, y el 1433 el puerto
                + "database =Proyectocto_Nautas_Busos;"
                + "user =usuario;" //Ingresa aquí el nombre del usuario creado
                + "password =123;" //la contrase{a
                + "loginTimeout =30;"
                + "encrypt=true;"
                + "trustServerCertificate=true";
        try {
            Connection con = DriverManager.getConnection(conexionUrl);
            System.out.println("Conectada");
            return con;

        } catch (SQLException ex) {
            System.out.println("Error: "+ex.toString());
            return null;
        }
    }
    
}
