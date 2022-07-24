package servlets;

import db.ConnectionDB;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.User;

@WebServlet(name = "UserRegister", urlPatterns = {"/UserRegister"})
public class UserRegister extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                ConnectionDB connection = new ConnectionDB();
                User u = new User();

                u.setName(request.getParameter("name"));
                u.setUsername(request.getParameter("username"));
                u.setEmail(request.getParameter("email"));
                u.setPassword(request.getParameter("password"));

                String parameter = "";

                //Check disponibility of username and email
                if (connection.existsInDB("USERH","username", u.getUsername())) {
                    System.out.println("Invalid user");
                    parameter="p=errorU";
                }
                else if (connection.existsInDB("USERH","email", u.getEmail())) {
                    System.out.println("Invalid email");
                    parameter="p=errorE";
                }
                else {
                    connection.insertUser(u);
                    System.out.println("Correct insertion");
                    parameter = "p=login";
                }
                response.sendRedirect("index.html?"+parameter);
    }
}
