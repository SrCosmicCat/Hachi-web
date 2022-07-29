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
import models.Comment;

@WebServlet(name = "CommentSendProject", urlPatterns = {"/CommentSendProject"})
public class CommentSendProject extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                ConnectionDB connection = new ConnectionDB();
                HttpSession session = request.getSession();
                User u = connection.getUserById(Integer.parseInt(session.getAttribute("idUser").toString()));
                Project p = connection.getProjectById(Integer.parseInt(session.getAttribute("idProj").toString()));
                Comment c = new Comment();
                c.setDescription(request.getParameter("newCommentProject"));
                c.setIdUser(u.getId());
                c.setIdProj(p.getId());
                
                connection.sendCommentProject(c);
    }
    
}
