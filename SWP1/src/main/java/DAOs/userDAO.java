package DAOs;

import DB.DBConnection;
import Model.User;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class userDAO {

    public List<User> getAll() {
        List<User> userList = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        ResultSet rs = null;
        Statement st = null;

        if (conn != null) {
            try {
                // Check if connected to the right database
                st = conn.createStatement();
                ResultSet dbCheckRs = st.executeQuery("SELECT DATABASE()");
                if (dbCheckRs.next()) {
                    String connectedDatabase = dbCheckRs.getString(1);
                    if (!"cardealership".equals(connectedDatabase)) {
                        System.err.println("Warning: Connected to the wrong database: " + connectedDatabase);
                        return userList; // Return empty list if connected to the wrong database
                    }
                }
                dbCheckRs.close(); // Close the result set for database check
                // Execute the query to get all users
                rs = st.executeQuery("SELECT * FROM cardealership.users");
                while (rs.next()) {
                    int userId = rs.getInt("user_id");
                    String username = rs.getString("username");
                    String password = rs.getString("password");
                    String email = rs.getString("email");
                    String fullName = rs.getString("full_name");
                    String phone = rs.getString("phone");
                    String address = rs.getString("address");
                    String role = rs.getString("role");
                    User user = new User(userId, username, password, email, fullName, phone, address, role);
                    userList.add(user);
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            } finally {
                try {
                    if (rs != null) {
                        rs.close();
                    }
                    if (st != null) {
                        st.close();
                    }
                    if (conn != null) {
                        conn.close();
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return userList;
    }
}
