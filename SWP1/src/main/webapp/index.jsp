<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="DB.DBConnection"%>
<%@page import="DAOs.userDAO"%>
<%@page import="Model.User"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>User List</title>
        <style>
            table {
                width: 100%;
                border-collapse: collapse;
            }
            table, th, td {
                border: 1px solid black;
            }
            th, td {
                padding: 10px;
                text-align: left;
            }
            th {
                background-color: #f2f2f2;
            }
        </style>
    </head>
    <body>
        <h2>User List</h2>
        <%
            // Get the database connection
            Connection conn = DBConnection.getConnection();

            if (conn == null) {
                out.print("Connection failed");
            } else {
                out.print("Connection succeeded !<br>");

                // Retrieve and print the database name
                try {
                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT DATABASE()");
                    if (rs.next()) {
                        String dbName = rs.getString(1);
                        out.print("Connected to database: " + dbName + "<br>");
                    }
                    rs.close();
                    stmt.close();
                } catch (SQLException e) {
                    out.print("Error retrieving database name: " + e.getMessage());
                }
        %>
        <%
            // Instantiate userDAO and get the list of users
            userDAO userDAO = new userDAO();
            List<User> userList = userDAO.getAll();

            if (userList != null && !userList.isEmpty()) {
        %>
        <table>
            <thead>
                <tr>
                    <th>User ID</th>
                    <th>Username</th>
                    <th>Password</th>
                    <th>Email</th>
                    <th>Full Name</th>
                    <th>Phone</th>
                    <th>Address</th>
                    <th>Role</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for (User user : userList) {
                %>
                <tr>
                    <td><%= user.getUserId()%></td>
                    <td><%= user.getUsername()%></td>
                    <td><%= user.getPassword()%></td>
                    <td><%= user.getEmail()%></td>
                    <td><%= user.getFullName()%></td>
                    <td><%= user.getPhone()%></td>
                    <td><%= user.getAddress()%></td>
                    <td><%= user.getRole()%></td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
        <%
        } else {
        %>
        <p>No users found.</p>
        <%
                }
            }
        %>
    </body>
</html>
