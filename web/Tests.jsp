<%-- 
    Document   : Tests
    Created on : 8 jul. 2022, 00:48:13
    Author     : gatit
--%>
<%@page import="models.User;"%>
<%@page import="db.ConnectionDB;"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <%
            ConnectionDB connection = new ConnectionDB();
            
            System.out.println(connection.mostrarUsuario()[0]);
            
        %>
    </body>
</html>
