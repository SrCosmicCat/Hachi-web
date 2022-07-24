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

@WebServlet(name = "UserUpdate", urlPatterns = {"/UserUpdate"})
public class UserUpdate extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                ConnectionDB connection = new ConnectionDB();
                HttpSession session = request.getSession();
                User actualUser = connection.getUserById(Integer.parseInt(session.getAttribute("idUser").toString()));
                User newUser = new User();
                
                newUser.setName(request.getParameter("inputShowName"));
                newUser.setUsername(request.getParameter("inputShowUsername"));
                newUser.setEmail(request.getParameter("inputShowEmail"));
                newUser.setPassword(request.getParameter("inputShowPassword"));
                
                if( ((connection.existsInDB("USERH", "username", newUser.getUsername()) && actualUser.getUsername().equals(newUser.getUsername())) || (!connection.existsInDB("USERH", "username", newUser.getUsername()) && !actualUser.getUsername().equals(newUser.getUsername())) ) ) {
                    if ( connection.existsInDB("USERH", "email", newUser.getEmail()) && actualUser.getEmail().equals(newUser.getEmail()) || (!connection.existsInDB("USERH", "email", newUser.getEmail()) && !actualUser.getEmail().equals(newUser.getEmail()) ) ){
                        connection.updateUser(actualUser, newUser);
                        System.out.println("User update success");
                    }
                    else {
                        System.out.println("The email exists in db");
                    }
                }
                else {
                    System.out.println("The username exists in db");
                }
        response.sendRedirect("my-profile.jsp");
    }
}
