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
import models.Comment;

@WebServlet(name = "CommentSend", urlPatterns = {"/CommentSend"})
public class CommentSend extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
                ConnectionDB connection = new ConnectionDB();
                HttpSession session = request.getSession();
                User u = connection.getUserById(Integer.parseInt(session.getAttribute("idUser").toString()));
                Task t = connection.getTaskById(Integer.parseInt(session.getAttribute("idTask").toString()));
                Comment c = new Comment();
                c.setDescription(request.getParameter("newComment"));
                c.setIdUser(u.getId());
                c.setIdTask(t.getId());
                
                connection.sendCommentTask(c);
    }
    
}
