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

@WebServlet(name = "ProjectJoin", urlPatterns = {"/ProjectJoin"})
public class ProjectJoin extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                ConnectionDB connection = new ConnectionDB();
                HttpSession session = request.getSession();
                
                User actualUser = connection.getUserById(Integer.parseInt(session.getAttribute("idUser").toString()));
                Project project = connection.getProjectByCode(request.getParameter("inputAccessCode"));
                
                String parameter = "";
                

                //Check if the code exists in db
                if (project == null) {
                    System.out.println("Invalid code");
                    //parameter="p=errorU";
                }
                else {
                    connection.insertUserProject(actualUser,project);
                }
               
                response.sendRedirect("home.jsp?"+parameter);
    }
}
