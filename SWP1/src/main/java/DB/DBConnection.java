package DB;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;

/**
 *
 * @author lhhuong
 */
public class DBConnection {

    private static final String URL = "jdbc:mysql://sql12.freesqldatabase.com:3306/sql12729992";
    private static final String USER = "sql12729992";
    private static final String PASSWORD = "arZj9WcH26";

    public static Connection getConnection() {
        Connection conn = null;
        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(URL, USER, PASSWORD);

            // Print out the name of the connected database
            if (conn != null) {
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT DATABASE()");
                if (rs.next()) {
                    System.out.println("Connected to database: " + rs.getString(1));
                }
                rs.close();
                stmt.close();
            }

        } catch (ClassNotFoundException e) {
            // Log the exception
            System.err.println("JDBC Driver not found: " + e.getMessage());
        } catch (SQLException e) {
            // Log the exception
            System.err.println("Error establishing connection: " + e.getMessage());
        }
        return conn;
    }

    // Utility method to close the connection
    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                System.err.println("Error closing connection: " + e.getMessage());
            }
        }
    }
}
