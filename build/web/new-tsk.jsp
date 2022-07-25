<%@page import="models.Project"%>
<%@page import="models.User"%>
<%@page import="models.Task"%>
<%@page import="models.Comment"%>
<%@page import="db.ConnectionDB"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%
    ConnectionDB connection = new ConnectionDB();
    session = request.getSession();
    Task actualTask;
    
    //Get user actual project
    Project actualProject = connection.getProjectById(Integer.parseInt(session.getAttribute("idProj").toString()));
    
    User admin = connection.getProjectAdmin(Integer.parseInt(session.getAttribute("idProj").toString()));
    
    //Get user tasks and actual task
    Task[] userTasks;
    
    if (admin.getId() == Integer.parseInt(session.getAttribute("idUser").toString())) {
        userTasks = connection.getProjectTasks(Integer.parseInt(session.getAttribute("idProj").toString()));
    }
    else {
        userTasks = connection.getUserTasks(Integer.parseInt(session.getAttribute("idUser").toString()),Integer.parseInt(session.getAttribute("idProj").toString()));
    }
    if (!(request.getParameter("tskId") == null || Integer.parseInt(request.getParameter("tskId")) > userTasks.length-1 || Integer.parseInt(request.getParameter("tskId")) < 0)) {
        actualTask = userTasks[Integer.parseInt(request.getParameter("tskId").toString())];
    }
    else {
        actualTask = userTasks[0];
    }
    session.setAttribute("idTask", actualTask.getId());
    
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Task Name (probably, idk)</title>
        <!--<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">-->
        <link rel="icon" href="resources/img/Hachi_logo_yellowremastered.png">
        <link rel="stylesheet" href="scss/custom.css">
    </head>
    <body>
        <!-- Here we go :rosel2: -->     
        <!-- Navbar toogle-->
        <nav class="navbar navbar-expand-sm">
            <div class="container">
                <a href="project.jsp?project=<%=request.getParameter("project")%>" class="navbar-brand">
                    <span class="hachiLogoMenu"><%=actualProject.getName()%></span>
                </a>
            </div>
        </nav>  
        <div class="main">
            <div class="container-fluid">
                <hr>
                <div class="hive">
                    
                    <div class="row">
                        <!-- SIDEBAR-->
                        <div class="col-md-1">
                            <div class="sidebar" id="side_nav">
                                <ul class="list-unstyled px-2">
                                    <li class="item pt-4">
                                        <a href="home.jsp?project=<%=request.getParameter("project")%>" class="text-decoration-none px-2">
                                            <svg class="icon-home"></svg>
                                            <span class="tooltip">Home</span>
                                        </a>
                                    </li>
                                    <li class="item pt-4">                                     
                                        <a href="project.jsp?project=<%=request.getParameter("project")%>" class="text-decoration-none px-2">
                                            <svg class="icon-hive"></svg>
                                            <span class="tooltip">Project</span>                                        
                                        </a>
                                    </li>
                                    <li class="item pt-4">
                                        <a href="my-profile.jsp" class="text-decoration-none px-2">
                                            <svg class="icon-member"></svg>
                                            <span class="tooltip">Profile</span>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>

                        <!-- Task Details -->
                        <div class="col-md-11">
                            <div class="row">
                                <div class="col-md mt-4">
                                    <h1 class="mediumTitle"><%=actualTask.getName()%></h1>
                                </div>
                                <div class="col-md">
                                    <div class="row">
                                        <div class="col-sm">
                                            <h1 class="regularText">Status</h1>                                            
                                        </div>
                                        <div class="col-sm">
                                            <h1 class="regularText">Due: </h1>
                                        </div>
                                    <div class="row">
                                        <div class="col-sm">
                                            <h1 class="normalText">To do</h1>                                            
                                        </div>
                                        <div class="col-sm">
                                            <h1 class="normalText">July 12</h1>
                                        </div>
                                    </div>
                                    </div>
                                </div>
                                <div class="col-md-1 <%if (admin.getId() == Integer.parseInt(session.getAttribute("idUser").toString()) && admin.getId() != actualTask.getId_user()) {out.print("no-visible");}%> ">
                                    <div class="task-butt">
                                        <a class="hachiTextMenu" onClick="completeTask()">
                                            <img src="resources/icons/complete.png" class="mt-3">
                                            <span class="tip">Mark as completed</span>
                                        </a>
                                    </div>  
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md">
                                    <div class="desc-box">
                                        <h3 class="normalText"><%=actualTask.getDescription()%></h3>
                                    </div>
                                </div>
                            </div>
                            


                            <div class="row">
                                <div class="col-md">
                                    <div class="row">
                                        <div class="col-md-1">
                                            <svg class="icon-comment mx-4 mt-2"></svg>
                                        </div>
                                        <div class="col-md">
                                            <h1 class="regularText">Comments: </h1>


                                        </div>
                                        <%
                                            Comment[] taskComments = connection.getTaskComments(actualTask);
                                            
                                            for (int i=0; i<taskComments.length; i++) {
                                                out.print("<div class=\"desc-box\">");
                                                    out.print("<h3>"+taskComments[i].getAuthor()+" | "+taskComments[i].getDate()+"</h3>");
                                                    out.print("<h3 class=\"normal-text\">"+taskComments[i].getDescription()+"</h3>");
                                                out.print("</div>");
                                            }
                                        %>
                                        
                                    </div>
                                    <div class="row">
                                        <div class="secondForm">
                                            <form action="CommentSend" id="formCommentSend" method="POST">
                                                <div class="row"> 
                                                    <div class="col-md-11">       
                                                        <textarea class="darkTextArea" id="newComment" name="newComment" placeholder="Leave a comment" maxlength="100"></textarea>
                                                    </div>
                                                    <div class="col-md-1 mt-4 d-flex justify-content-center">
                                                        <button type="submit" class="trans">
                                                            <svg class="icon-send"></svg>
                                                        </button>
                                                    </div>
                                                </div>
                                            </form> 
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Footer -->
                <footer class="footer">       
                    <hr>
                    <div class="row justify-content-center">
                        <div class="col-md-4">
                            <img id="hachiLogoFooter" src="resources/img/Hachi_logo_letters_horizontal.png" alt="Hachi's logo brand">
                        </div>
                        <div class="col-md-6">
                            <h1 class="hachiTextFooter"> Hachi Ver 2.0 Copyright &copy; 2022. All rights reserved. </h1>
                        </div>
                    </div>
                </footer>
            </div>
        </div>
                                    
        <div class="toast-container position-fixed bottom-0 end-0 p-3">
            <div id="toastTaskCompleted" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
                <div class="toast-header">
                    <img src="resources/img/Hachi_logo_yellowremastered.png" class="rounded me-2" alt="Hachi logo" height="20">
                    <strong class="me-auto">Hachi</strong>
                    <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
                <div class="toast-body">
                    <%=actualTask.getName()%> has been completed!
                </div>
            </div>
        </div>
    
        <script src="node_modules/@popperjs/core/dist/umd/popper.min.js"></script>        
        <script src="node_modules/bootstrap/dist/js/bootstrap.min.js"></script>                            
        <script src="js/completeTasks.js"></script>
        <script src="js/jquery-3.6.0.min.js"></script>
    </body>
</html>