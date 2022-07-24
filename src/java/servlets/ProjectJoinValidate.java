package servlets;

import db.ConnectionDB;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.Project;
import models.User;

@WebServlet(name = "ProjectJoinValidate", urlPatterns = {"/ProjectJoinValidate"})
public class ProjectJoinValidate extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                try (PrintWriter w = response.getWriter()) {
                    ConnectionDB connection = new ConnectionDB();
                    HttpSession session = request.getSession();

                    User u = connection.getUserById(Integer.parseInt(session.getAttribute("idUser").toString()));
                    Project p = connection.getProjectByCode(request.getParameter("inputAccessCode"));


                    //Check if the code exists in db or the user is already on it
                    if (connection.checkProject(u, request.getParameter("inputAccessCode"))) {
                        System.out.println("Invalid code");
                        //parameter="p=errorU";
                        w.print("true");
                    }
                    else {
                        w.print("false");
                    }
                }
    }
}
