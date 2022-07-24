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

@WebServlet(name = "UserDelete", urlPatterns = {"/UserDelete"})
public class UserDelete extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                ConnectionDB connection = new ConnectionDB();
                HttpSession session = request.getSession();
                User actualUser = connection.getUserById(Integer.parseInt(session.getAttribute("idUser").toString()));
                User deleteUser = new User();

                deleteUser.setEmail(request.getParameter("inputDeleteEmail"));
                deleteUser.setPassword(request.getParameter("inputDeletePass"));


                if ( actualUser.getEmail().equals(deleteUser.getEmail()) && actualUser.getPassword().equals(deleteUser.getPassword()) ) {
                    connection.deleteUser(actualUser);
                    response.sendRedirect("index.html");
                }
                else {
                    response.sendRedirect("my-profile.jsp");
                }
    }
}
