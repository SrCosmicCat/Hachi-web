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

@WebServlet(name = "ProjectRegister", urlPatterns = {"/ProjectRegister"})
public class ProjectRegister extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                ConnectionDB connection = new ConnectionDB();
                Project p = new Project();
                HttpSession session = request.getSession();
                User u = connection.getUserById(Integer.parseInt(session.getAttribute("idUser").toString()));

                p.setName(request.getParameter("projectName"));
                p.setDescription(request.getParameter("projectDescription"));

                String parameter = "";
                
                connection.insertProject(p,u);
                
                response.sendRedirect("home.jsp?"+parameter);
    }
}
