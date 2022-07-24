package servlets;

import db.ConnectionDB;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.User;

@WebServlet(name = "Login", urlPatterns = {"/Login"})
public class Login extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                ConnectionDB connection = new ConnectionDB();

                String parameter = "";

                //Check if the given data already exists in the db
                if (connection.checkLogin(request.getParameter("emailUsernameLogin"),request.getParameter("passwordLogin"))) {
                    System.out.println("Login success");
                    
                    User u = connection.getUserByUsernameEmail(request.getParameter("emailUsernameLogin"));
                    
                    HttpSession session = request.getSession();
                    session.setAttribute("idUser", u.getId());
                    session.setAttribute("username", u.getUsername());
                    
                    System.out.println("ID session: "+session.getAttribute("idUser"));
                    System.out.println("username session: "+session.getAttribute("username"));
                    
                    response.sendRedirect("home.jsp");
                }
                else {
                    System.out.println("Login error");
                    System.out.println(request.getParameter("emailUsernameLogin"));
                    System.out.println(request.getParameter("passwordLogin"));
                    parameter = "p=errorL";
                    response.sendRedirect("index.html?"+parameter);
                }
    }
}
