<%@page import="models.Project"%>
<%@page import="models.User"%>
<%@page import="models.Task"%>
<%@page import="models.Comment"%>
<%@page import="db.ConnectionDB"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%
    ConnectionDB connection = new ConnectionDB();
    session = request.getSession();
    int actualProject = 0;
    
    //Get user projects
    Project[] userProjects = connection.getUserProjects(Integer.parseInt(session.getAttribute("idUser").toString()));
    
    
    if (!(request.getParameter("project") == null || Integer.parseInt(request.getParameter("project")) > userProjects.length-1 || Integer.parseInt(request.getParameter("project")) < 0)) {
        actualProject = Integer.parseInt(request.getParameter("project"));
    }
    if (userProjects.length != 0) {
        //Set id from the first project
        session.setAttribute("idProj",userProjects[actualProject].getId());   
    }
    
    User admin = connection.getProjectAdmin(Integer.parseInt(session.getAttribute("idProj").toString()));
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Projects</title>
        <!--<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">-->
        <link rel="icon" href="resources/img/Hachi_logo_yellowremastered.png">
        <link rel="stylesheet" href="scss/custom.css">
    </head>
    <body>
        <!-- Here we go :rosel2: -->     
        <!-- Navbar toogle-->
        <nav class="navbar navbar-expand-sm">
            <div class="container">
                <a href="home.jsp?project=<%=request.getParameter("project")%>" class="navbar-brand">
                    <img id="logo" src="resources/img/Hachi_logo_yellowremastered.png" alt="Hachi's logo brand">
                    <span class="hachiLogoMenu">Hachi</span>
                </a>
                <ul class="navbar-nav">
                     <!-- PROFILE DROPDOWN - scrolling off the page to the right -->
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" type="button" style="color:#4111CA" id="navDropDownLink" 
                            aria-haspopup="true" aria-expanded="false">
                            <span class="hachiTextMenu"><%=session.getAttribute("name")%></span>
                            <svg xmlns="http://www.w3.org/2000/svg" width="45" height="45" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
                                <path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
                                <path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
                            </svg>
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navDropDownLink">
                            <a class="dropdown-item" href="my-profile.jsp">My profile
                                <svg class="icon-bee"></svg>
                            </a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="Logout">Logout
                                <svg class="icon-logout"></svg>
                            </a>
                        </div>
                    </li>  
                </ul>
            </div>
        </nav>  
        <div class="main">
            <div class="container">
                <hr>
                <div class="hive">
                    <div class="row">
                        <div class="col-md mt-12">

                            <!-- Banner de proyecto -->
                            <div class="project-box p-5">
                                <div class="row">
                                    <div class="col-md mt-6">
                                    <h1 class="mediumTitle"><%=userProjects[actualProject].getName()%></h1>
                                    </div>
                                    <div class="col-md mt-6  d-flex justify-content-end">
                                    <h1 class="normalText">Code: <%=userProjects[actualProject].getCode()%></h1>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md mt-12">
                                        <h1 class="normalText">Owner: <%=admin.getName()%></h1>
                                    </div>
                                </div>
                            </div>

                            <!-- columnas de proyecto-->
                            <div projects-bar>
                            <div class="row">
                                <div class="col-md">
                                    <div class="section-tag d-flex justify-content-center" id="btnHive">
                                       <h1 class="normalText p-2">Hive</h1>
                                    </div>
                                </div>
                                <div class="col-md">
                                    <div class="section-tag d-flex justify-content-center" id="btnPosts">
                                       <h1 class="normalText p-2">Posts</h1>
                                    </div>
                                </div>
                                <div class="col-md">
                                    <div class="section-tag d-flex justify-content-center" id="btnMembers">
                                       <h1 class="normalText p-2">Members</h1>
                                    </div>
                                </div>
                            </div>
                            </div>
                            <hr>
                            
                            <!-- HIVE SECTION-->
                            <div class="row si-visible" id="secHive">
                                <div class="col-md mt-2">
                                    <%
                                        // Create new task box (only visible in admins side)
                                        if (admin.getId() == Integer.parseInt(session.getAttribute("idUser").toString())) {
                                            out.print("<button type=\"button\" class=\"create-add-button\" id=\"create-task\" data-bs-toggle=\"modal\" data-bs-target=\"#createTaskModal\">");
                                                out.print("<div class=\"d-flex\">");
                                                    out.print("<div>");
                                                        out.print("<svg class=\"icon-new\"></svg>");
                                                    out.print("</div>");
                                                    out.print("<div class=\"col-md mx-3\">");
                                                        out.print("<h5 class=\"normalText mt-2\"> Create new task</h5>");
                                                    out.print("</div>");
                                                out.print("</div>");
                                            out.print("</button>");
                                        }
                                    %> 
                                    <!-- Modal create task -->
                                    <div class="modal fade" id="createTaskModal" tabindex="-1" aria-labelledby="createTaskModalLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-dialog-centered">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title mx-5" id="createTaskModalLabel">Create new task</h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>

                                                <form class="form-create-task" method="POST" action="TaskRegister" id="formAddProjectTask">
                                                    <div class="modal-body">
                                                        <hr>
                                                        <div class="form-group">
                                                            <h2>Fill the following camps</h2>
                                                           <label for="inputTaskName">Task Name</label>
                                                            <div class="input-container">
                                                                <input type="text" class="form-control" id="inputTaskName" name="taskName" placeholder="Task Name" maxlength="30">
                                                                <img src="resources/icons/errorIcon.png" class="input-icon no-visible" id="errorProjectName" alt="ERROR">
                                                            </div>                                                        
                                                            <label for="inputTaskDescription">Description</label>
                                                            <div class="input-container">
                                                                <textarea name="taskDescription" id="inputTaskDescription" rows="4" maxlength="100"></textarea>
                                                            </div>
                                                            <label for="inputTaskDate">Date</label>
                                                            <div class="input-container">
                                                                <input type="date" class="form-control" id="inputTaskDate" name="taskDate">
                                                            </div>
                                                            <label for="inputAssignTo">Assign to</label>
                                                            <div class="input-container">
                                                                <select name="inputAssignTo" id="inputAssignTo">
                                                                    <%
                                                                        //Get members of project
                                                                        if (userProjects.length != 0) {
                                                                            User[] userMembers = connection.getProjectMembers(userProjects[actualProject]);

                                                                            for (int i=0; i<userMembers.length;i++) {
                                                                                out.print("<option value="+i+">"+userMembers[i].getName()+"</option>");
                                                                            }
                                                                        }
                                                                    %>
                                                                </select>
                                                            </div>
                                                            <!-- IMPLEMENTATION LATER
                                                            <label for="inputEmail">Assign To: </label>
                                                            <div class="form-check">
                                                                <input type="checkbox" class="form-check-input" id="member1">
                                                                <label for="member1"><p>Member 1</p></label>
                                                                <img src="resources/icons/errorIcon.png" class="input-icon no-visible" id="errorProjectName" alt="ERROR">
                                                            </div>
                                                            <div class="form-check">
                                                                <input type="checkbox" class="form-check-input" id="member2">
                                                                <label for="member2"><p>Member 2</p></label>
                                                                <img src="resources/icons/errorIcon.png" class="input-icon no-visible" id="errorProjectName" alt="ERROR">
                                                            </div>
                                                            <div class="form-check">
                                                                <input type="checkbox" class="form-check-input" id="member3">
                                                                <label for="member3"><p>Member 3</p></label>
                                                                <img src="resources/icons/errorIcon.png" class="input-icon no-visible" id="errorProjectName" alt="ERROR">
                                                            </div> -->
                                                        </div>
                                                    </div>
                                                    <div class="modal-footer d-flex justify-content-center">
                                                        <button type="button" class="btn btn-lg" data-bs-dismiss="modal">Close</button>
                                                        <button type="submit" class="btn btn-lg">Assign</button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- Published Tasks -->
                                    <%   
                                        if (userProjects.length != 0) {
                                            Task[] userTasks;
                                            //Get the array of tasks
                                            if (admin.getId() == Integer.parseInt(session.getAttribute("idUser").toString())) {
                                                userTasks = connection.getProjectTasks(Integer.parseInt(session.getAttribute("idProj").toString()));
                                            }
                                            else {
                                                userTasks = connection.getUserTasks(Integer.parseInt(session.getAttribute("idUser").toString()),Integer.parseInt(session.getAttribute("idProj").toString()));
                                            }
                                            //Print the tasks
                                            for (int i=0; i<userTasks.length;i++) {
                                                out.print("<a href=\"new-tsk.jsp?tskId="+i+"&project="+actualProject+"\">");
                                                    out.print("<div class=\"project-box\">");
                                                        out.print("<div class=\"d-flex\">");
                                                            out.print("<div>");
                                                                out.print("<svg class=\"icon-task\"></svg>");
                                                            out.print("</div>");
                                                            out.print("<div class=\"col-md mx-3\">");
                                                                out.print("<h5 class=\"normalText mt-2\"> Task "+(i+1)+": "+userTasks[i].getName()+"</h5>");
                                                            out.print("</div>");
                                                        out.print("</div>");
                                                    out.print("</div>");
                                                out.print("</a>");
                                            }
                                            if (userTasks.length == 0) {
                                                out.print("<h3>There is nothing here! Try to create and assign a task...</h3>");
                                            }
                                        }
                                    %>
                                    
                                    <!--  
                                    <div class="project-box">
                                        <div class="d-flex">
                                        <div>
                                        <svg class="icon-post"></svg>
                                        </div>
                                        <div class="col-md mx-3">
                                            <h5 class="normalText mt-2"> Miguel posted a comment: How do I kill the Chostito?</h5>
                                        </div>
                                        </div>
                                    </div>
                                    -->
                                    
                                </div>
                            </div>

                            <!-- POSTS SECTION-->
                            <div class="row no-visible" id="secPosts">
                                <div class="col-md mt-2">
                                    <!-- post new psot-->
                                    <button type="button" class="create-add-button" id="create-post" data-bs-toggle="modal" data-bs-target="#createPostModal">  
                                        <div class="d-flex">
                                            <div>
                                                <svg class="icon-new"></svg>
                                            </div>
                                            <div class="col-md mx-3">
                                                <h5 class="normalText mt-2"> Post a new comment </h5>
                                            </div>
                                        </div>
                                    </button>

                                    <!-- Modal post comment -->
                                    <div class="modal fade" id="createPostModal" tabindex="-1" aria-labelledby="createPostModalLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-dialog-centered">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title mx-5" id="createPostModalLabel">Create new post</h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <form class="form-add-member" action="CommentSendProject" method="POST" id="formCommentSendProject">
                                                    <div class="modal-body">
                                                        <hr>
                                                        <div class="form-group">
                                                            <h2>Ask a question, comment suggestions, let others know what you think!</h2>
                                                            <br>
                                                            <div class="input-container">
                                                                <textarea name="newCommentProject" id="newCommentProject" placeholder="Leave a comment" rows="4" maxlength="100"></textarea>
                                                            </div>
                                                        </div>
                                                        <p>Write short sentences and be concise so people make time to read you</p>
                                                    </div>
                                                    <div class="modal-footer d-flex justify-content-center">
                                                        <button type="button" class="btn btn-lg" data-bs-dismiss="modal">Close</button>
                                                        <button type="submit" class="btn btn-lg">Add</button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Published Comments -->
                                    <%
                                        Comment[] comments = connection.getProjectComments(userProjects[actualProject]);

                                        for (int i=0; i<comments.length; i++) {
                                            out.print("<div class=\"project-box\">");
                                                out.print("<div class=\"d-flex\">");
                                                    out.print("<div> <svg class=\"icon-post\"></svg> </div>");
                                                    out.print("<div class=\"col-md mx-3\"> <h5 class=\"normalText mt-2\">"+comments[i].getAuthor()+" posted a comment: "+comments[i].getDescription()+"<br>"+comments[i].getDate()+"</h5> </div>");
                                                out.print("</div>");
                                            out.print("</div>");
                                        }
                                    %>
                                </div>
                            </div>

                            <!-- MEMBERS SECTION-->
                            <div class="row no-visible" id="secMembers">
                                <div class="col-md mt-2">
                                    <!-- Add new member (only visible in admins side)-->
                                    <%
                                        // Create new task box (only visible in admins side)
                                        if (admin.getId() == Integer.parseInt(session.getAttribute("idUser").toString())) {
                                            out.print("<button type=\"button\" class=\"create-add-button\" id=\"create-task\" data-bs-toggle=\"modal\" data-bs-target=\"#addMemberModal\">");
                                                out.print("<div class=\"d-flex\">");
                                                    out.print("<div>");
                                                        out.print("<svg class=\"icon-new\"></svg>");
                                                    out.print("</div>");
                                                    out.print("<div class=\"col-md mx-3\">");
                                                        out.print("<h5 class=\"normalText mt-2\">Add new member</h5>");
                                                    out.print("</div>");
                                                out.print("</div>");
                                            out.print("</button>");
                                        }
                                    %> 
                                    <!-- Modal add member -->
                                    <div class="modal fade" id="addMemberModal" tabindex="-1" aria-labelledby="addMemberModalLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-dialog-centered">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title mx-5" id="addMemberModalLabel">Add a new member</h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <form class="form-add-member" action="ProjectAddMember" method="POST" id="formAddProjectMember">
                                                    <div class="modal-body">
                                                        <hr>
                                                        <div class="form-group">
                                                            <h2>Enter the email or username of your new member</h2>
                                                            <label for="usernameEmail">Email or username</label>
                                                            <div class="input-container">
                                                                <input type="text" class="form-control" id="usernameEmail" name="usernameEmail">
                                                                <img src="resources/icons/errorIcon.png" class="input-icon no-visible" id="errorProjectName" alt="ERROR">
                                                            </div>
                                                        </div>
                                                        <p>*They will receive an email that will
                                                            redirect them to the project</p>
                                                    </div>
                                                    <div class="modal-footer d-flex justify-content-center">
                                                        <button type="button" class="btn btn-lg" data-bs-dismiss="modal">Close</button>
                                                        <button type="submit" class="btn btn-lg">Add</button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- Actual members -->
                                    <%
                                        User[] members = connection.getProjectMembers(userProjects[actualProject]);

                                        for (int i=0; i<members.length; i++) {
                                            out.print("<div class=\"project-box\">");
                                                out.print("<div class=\"d-flex\">");
                                                    out.print("<div> <svg class=\"icon-member\"></svg> </div>");
                                                    out.print("<div class=\"col-md mx-3\"> <h5 class=\"normalText mt-2\">"+members[i].getName()+"</h5> </div>");
                                                out.print("</div>");
                                            out.print("</div>");
                                        }
                                    %>
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
                                <h1 class="hachiTextFooter">Hachi Ver 2.0 Copyright &copy; 2022. All rights reserved. </h1>
                            </div>
                        </div>
                    </footer>
                </div>
            </div>
        </div>        
        <script src="node_modules/@popperjs/core/dist/umd/popper.min.js"></script>        
        <script src="node_modules/bootstrap/dist/js/bootstrap.min.js"></script>
        <script src="js/jquery-3.6.0.min.js"></script>
        <script src="js/project.js"></script>
    </body>
</html>
