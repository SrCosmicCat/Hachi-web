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
import models.Task;
import models.User;

@WebServlet(name = "TaskRegister", urlPatterns = {"/TaskRegister"})
public class TaskRegister extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                ConnectionDB connection = new ConnectionDB();
                HttpSession session = request.getSession();

                Project actualProject = connection.getProjectById(Integer.parseInt(session.getAttribute("idProj").toString()));
                User[] membersProject = connection.getProjectMembers(actualProject);
                User actualUser = connection.getUserById(Integer.parseInt(session.getAttribute("idUser").toString()));
                User assignUser = connection.getUserById(membersProject[Integer.parseInt(request.getParameter("inputAssignTo"))].getId());
                
                Task t = new Task();
                
                t.setName(request.getParameter("taskName"));
                t.setDescription(request.getParameter("taskDescription"));
                t.setDate(request.getParameter("taskDate"));
                
                //Insert task in db
                System.out.println("ID assign user: "+assignUser.getId());
                connection.insertTask(t,actualUser, assignUser,actualProject); 

                System.out.println("Task inserted");
                
                //response.sendRedirect("project.jsp?");
    }
}
