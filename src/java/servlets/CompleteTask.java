package servlets;

import db.ConnectionDB;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.Task;
import models.User;

@WebServlet(name = "CompleteTask", urlPatterns = {"/CompleteTask"})
public class CompleteTask extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                ConnectionDB connection = new ConnectionDB();
                HttpSession session = request.getSession();
                
                User actualUser = connection.getUserById(Integer.parseInt(session.getAttribute("idUser").toString()));
                Task task = connection.getTaskById(Integer.parseInt(request.getParameter("taskId").toString()));
                
                System.out.println("Task completed");
    }
}
