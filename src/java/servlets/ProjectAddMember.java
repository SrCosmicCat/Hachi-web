package servlets;

import db.ConnectionDB;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.Project;
import models.User;

@WebServlet(name = "ProjectAddMember", urlPatterns = {"/ProjectAddMember"})
public class ProjectAddMember extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                ConnectionDB connection = new ConnectionDB();
                HttpSession session = request.getSession();
                
                User user = connection.getUserByUsernameEmail(request.getParameter("usernameEmail"));
                Project project = connection.getProjectById(Integer.parseInt(session.getAttribute("idProj").toString()));

                //Check if the user exists in db
                if (user == null) {
                    System.out.println("Invalid user");
                    //parameter="p=errorU";
                }
                else {
                    connection.insertUserProject(user,project);
                }
               
                //response.sendRedirect("home.jsp");
    }
}
