<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="DB.DBConnection"%>
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
                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT database()");
                    if (rs.next()) {
                        int dbid = rs.getInt(1);
                        String dbName = rs.getString(2);
                        out.print("Connected to database: " + dbName + dbid + "<br>");
                    }
                    rs.close();
                    stmt.close();
                } 
        %>
    </body>
</html>
