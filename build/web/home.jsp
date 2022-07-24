<%@page import="models.Project"%>
<%@page import="models.User"%>
<%@page import="models.Task"%>
<%@page import="db.ConnectionDB"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%
    
    ConnectionDB connection = new ConnectionDB();
    session = request.getSession();
    
    
    int actualProject = 0;
    User admin = new User();
    //Get user projects
    Project[] userProjects = connection.getUserProjects(Integer.parseInt(session.getAttribute("idUser").toString()));
    
    if (!(request.getParameter("project") == null || Integer.parseInt(request.getParameter("project")) > userProjects.length-1 || Integer.parseInt(request.getParameter("project")) < 0)) {
        actualProject = Integer.parseInt(request.getParameter("project"));
    }
    
    if (userProjects.length != 0) {
        //Set id from the first project
        session.setAttribute("idProj",userProjects[actualProject].getId());
        admin = connection.getProjectAdmin(Integer.parseInt(session.getAttribute("idProj").toString()));
    }
    
    
    

    //[1] OBTENER TODOS LOS DATOS DE TODOS LOS PROYECTOS DONDE ESTÉ EL USUARIO X
    //[0] OBTENER EL NOMBRE Y USERNAME DEL ADMINISTRADOR DEL PROYECTO X
    //[0] OBTENER EL TOTAL DE TAREAS DEL PROYECTO X
    //[0] OBTENER EL TOTAL DE TAREAS COMPLETADAS DEL PROYECTO X
    
    //[0] OBTENER TODOS LOS DATOS DE TODAS LAS TAREAS ASIGNADAS AL USUARIO X EN UN PROYECTO X QUE NO ESTÉN COMPLETADAS Y QUE SE VENZAN ANTES DE LA FECHA X
    //[0] OBTENER TODOS LOS DATOS DE TODAS LAS TAREAS ASIGNADAS AL USUARIO X EN UN PROYECTO X QUE NO ESTÉN COMPLETADAS Y QUE SE VENZAN EN LA FECHA X
    //[0] OBTENER TODOS LOS DATOS DE TODAS LAS TAREAS ASIGNADAS AL USUARIO X EN UN PROYECTO X QUE NO ESTÉN COMPLETADAS Y QUE SE VENZAN DESPUES DE LA FECHA X
    //[0] OBTENER TODOS LOS DATOS DE TODAS LAS TAREAS ASIGNADAS AL USUARIO X EN UN PROYECTO X QUE ESTÉN COMPLETADAS
    
    //[1] OBTENER TODOS LOS DATOS DE TODOS LOS USUARIOS REGISTRADOS EN UN PROYECTO X 
    
    //[0] OBTENER NOMBRE DEL USUARIO, USERNAME, DESCRIPCION Y FECHA DE TODOS LOS COMENTARIOS DE UN PROYECTO X

    //[0] OBTENER NOMBRE DEL USUARIO, USERNAME, DESCRIPCION Y FECHA DE LOS COMENTARIOS DE LAS TAREAS DE UN PROYECTO X

%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Your hive page</title>
        <!--<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">-->
        <link rel="icon" href="resources/img/Hachi_logo_yellowremastered.png">
        <link rel="stylesheet" href="scss/custom.css">
    </head>
    <body>
        <!-- Here we go :rosel2: -->     
        <!-- Navbar toogle-->
        <nav class="navbar navbar-expand-sm">
            <div class="container">
                <a href="home.jsp" class="navbar-brand">
                    <img id="logo" src="resources/img/Hachi_logo_yellowremastered.png" alt="Hachi's logo brand">
                    <span class="hachiLogoMenu"> Hachi </span>
                </a>
                <ul class="navbar-nav">
                    <li class="nav-item dropdown m-3">
                        <div class="hachiTextMenu" id="join-project" data-bs-toggle="modal" data-bs-target="#joinProjectModal">
                            <span class="hachiTextMenu">Join</span>
                            <svg class="icon-add"></svg>
                        </div>
                    </li>
                    <!-- PROFILE DROPDOWN - scrolling off the page to the right -->
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" type="button" style="color:#4111CA" id="navDropDownLink" 
                            aria-haspopup="true" aria-expanded="false">
                            <span class="hachiTextMenu">Account</span>
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
                
                <!-- Modal join project -->
                <div class="modal fade" id="joinProjectModal" tabindex="-1" aria-labelledby="joinProjectModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title mx-5" id="joinProjectModalLabel">Join a project</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <form id="form-join-project" method="POST" action="ProjectJoin">
                                <div class="modal-body">
                                    <hr>
                                    <div class="form-group">
                                        <h2>Request the access code from the project administrator</h2>
                                        <label for="inputAccessCode"></label>
                                        <div class="input-container">
                                            <input type="text" class="form-control" id="inputAccessCode" name="inputAccessCode" placeholder="Access Code" maxlength="6">
                                            <img src="resources/icons/errorIcon.png" class="input-icon no-visible" id="errorProjectJoin" alt="ERROR">
                                        </div>
                                        <p>*The access code must be equal to 6 digits </p>
                                        <div class="modal-footer d-flex justify-content-center">
                                            <button type="button" class="btn btn-lg" data-bs-dismiss="modal">Close</button>
                                            <button type="submit" class="btn btn-lg">Join</button>
                                        </div>
                                    </div>
                                </div>
                            </form>
                       </div>
                    </div>
                </div>
                <!-- Modal join project -->
            </div>
        </nav> 
        
        <div class="main">
            <div class="container-fluid">
                <hr>
                <div class="hive">
                    
                    
                    <!-- Dashboard-->
                    <div class="row">
                        <div class="col-xl-12 col-lg-12 col-md-12 col-sm-12">
                            <div class="darker-box">
                                <div class="row projects-bar">
                                    <button type="button" class="project-box col" id="create-project" data-bs-toggle="modal" data-bs-target="#createProjectModal">
                                        Create new project
                                    </button>
                                    
                                    <!-- Modal create project -->
                                    <div class="modal fade" id="createProjectModal" tabindex="-1" aria-labelledby="createProjectModalLabel" aria-hidden="true">
                                        <div class="modal-dialog modal-dialog-centered">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title mx-5" id="createProjectModalLabel">Create new project</h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <form id="form-create-project" method="POST" action="ProjectRegister">
                                                    <div class="modal-body">
                                                        <hr>
                                                        <div class="form-group">
                                                            <h2>Fill the following camps</h2>
                                                            <label for="inputProjectName">Project Name</label>
                                                            <div class="input-container">
                                                                <input type="text" class="form-control" id="inputProjectName" name="projectName" placeholder="Project Name" maxlength="30">
                                                                <img src="resources/icons/errorIcon.png" class="input-icon no-visible" id="errorProjectName" alt="ERROR">
                                                            </div>
                                                            <label for="inputProjectDescription">Description</label>
                                                            <div class="input-container">
                                                                <textarea name="projectDescription" id="inputProjectDescription" rows="4" maxlength="100"></textarea>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="modal-footer d-flex justify-content-center">
                                                        <button type="button" class="btn btn-lg" data-bs-dismiss="modal">Close</button>
                                                        <button type="submit" class="btn btn-lg">Create new</button>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- Modal create project -->
                                    
                                    <%
                                        //Show projects
                                        for (int i=0; i<userProjects.length;i++) {
                                            
                                            //Check if the project is the project selected, if yes, then add to class selected
                                            String selected = "";
                                            if (i == actualProject) {selected = "selected";}
                                            
                                            //Print the project box
                                            out.print("<div class=\"project-box "+selected+" col\" id=\"btn-project-1\" ondblclick=\"window.location.href='project.jsp?project="+i+"'\" onclick=\"window.location.href='home.jsp?project="+i+"'\">");
                                            out.print(userProjects[i].getName()+" "); //project name
                                            out.print("</div>");
                                        }
                                    %>
                                
                                </div>
                                
                                <div class="project-box">
                                    
                                    <!--PROJECTS-->
                                    <div class="row si-visible-project" id="project-1">
                                        <%
                                            //Print if there is an existing project
                                            if (userProjects.length != 0) {
                                                out.print("<div class=\"col-xl-4 col-lg-12 col-md-12 col-sm-12\">");
                                                    out.print("<span class=\"regularText\">"+userProjects[actualProject].getName()+"</span>");
                                                    out.print("<h3>Owner Name: "+admin.getName()+"</h3>");
                                                    out.print("<br>");
                                                    out.print("<span class=\"regularText\">Overview</span>");
                                                    out.print("<h3>Completed Tasks</h3>");
                                                    out.print("<div class=\"progress\" style=\"height: 25px; border:solid; border-width: 4px; border-color: #4111CA\">");
                                                        out.print("<div class=\"progress-bar bg-hachiYellow\"  style=\"width: 58%;\"></div>");
                                                    out.print("</div>");
                                                    out.print("<h3 class=\"d-flex justify-content-center mt-2\">58%</h3>");
                                                out.print("</div>");
                                            }
                                        %>

                                        <div class="col-xl-8 col-lg-12 col-md-12 col-sm-12">
                                            
                                            <%
                                                String taskBoxShow = "";
                                                    if (userProjects.length == 0) {taskBoxShow = "no-visible"; out.print("<h3>There is nothing here! Try to join or create a new project...</h3>");}
                                            %>
                                            
                                            
                                            <div class="taskbox <%=taskBoxShow%>">
                                                <span class="regularText">Tasks</span>
                                                <br>
                                                <div class="row">
                                                    <div class="col-xl-4 col-lg-12 col-md-12 col-sm-12">
                                                        <h3>To do</h3>
                                                        <% 
                                                            if (userProjects.length != 0) {
                                                                //Get the array of tasks
                                                                
                                                                Task[] userTasksToDo = connection.getTasksToDo(Integer.parseInt(session.getAttribute("idUser").toString()),Integer.parseInt(session.getAttribute("idProj").toString()));
                                                                
                                                                //Print the tasks
                                                                for (int i=0; i<userTasksToDo.length;i++) {
                                                                    out.print("<div class=\"taskbox\">");
                                                                        out.print("<span>"+userTasksToDo[i].getName()+"</span>");
                                                                    out.print("</div>");
                                                                }
                                                            }
                                                        %>
                                                        
                                                    </div>
                                                    <div class="col-xl-4 col-lg-12 col-md-12 col-sm-12">
                                                        <h3>Urgent</h3>
                                                        <% 
                                                            if (userProjects.length != 0) {
                                                                
                                                                Task[] userTasksPast = connection.getTasksPast(Integer.parseInt(session.getAttribute("idUser").toString()),Integer.parseInt(session.getAttribute("idProj").toString()));
                                                            
                                                                //Get the array of tasks
                                                                
                                                                Task[] userTasksUrgent = connection.getTasksUrgent(Integer.parseInt(session.getAttribute("idUser").toString()),Integer.parseInt(session.getAttribute("idProj").toString()));
                                                                
                                                                for (int i=0; i<userTasksPast.length;i++) {
                                                                    out.print("<div class=\"taskbox\" style=\"box-shadow: inset 0 0 0 3px #BA1C1C\">");
                                                                        out.print("<span>"+userTasksPast[i].getName()+"</span>");
                                                                    out.print("</div>");
                                                                }
                                                                
                                                                //Print the tasks
                                                                for (int i=0; i<userTasksUrgent.length;i++) {
                                                                    out.print("<div class=\"taskbox\">");
                                                                        out.print("<span>"+userTasksUrgent[i].getName()+"</span>");
                                                                    out.print("</div>");
                                                                }
                                                            }
                                                        %>
                                                    </div>
                                                    <div class="col-xl-4 col-lg-12 col-md-12 col-sm-12">
                                                        <h3>Done</h3>
                                                         <% 
                                                            if (userProjects.length != 0) {
                                                                //Get the array of tasks
                                                                
                                                                Task[] userTasksDone = connection.getTasksDone(Integer.parseInt(session.getAttribute("idUser").toString()),Integer.parseInt(session.getAttribute("idProj").toString()));
                                                                
                                                                //Print the tasks
                                                                for (int i=0; i<userTasksDone.length;i++) {
                                                                    out.print("<div class=\"taskbox\">");
                                                                        out.print("<span>"+userTasksDone[i].getName()+"</span>");
                                                                    out.print("</div>");
                                                                }
                                                            }
                                                        %>
                                                    </div>
                                                </div>
                                            </div>

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
                                                        
                                                        
        <!--TOASTS-->
        <div class="toast-container position-fixed bottom-0 end-0 p-3">
            <div id="toastJoinProjectEx" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
                <div class="toast-header">
                    <img src="resources/img/Hachi_logo_yellowremastered.png" class="rounded me-2" alt="Hachi logo" height="20">
                    <strong class="me-auto">Hachi</strong>
                    <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
                <div class="toast-body">
                    You are already in this project!
                </div>
            </div>
        </div>
        
        <div class="toast-container position-fixed bottom-0 end-0 p-3">
            <div id="toastJoinProjectNe" class="toast" role="alert" aria-live="assertive" aria-atomic="true">
                <div class="toast-header">
                    <img src="resources/img/Hachi_logo_yellowremastered.png" class="rounded me-2" alt="Hachi logo" height="20">
                    <strong class="me-auto">Hachi</strong>
                    <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                </div>
                <div class="toast-body">
                    This project doesn't exists! Contact to project administrator.
                </div>
            </div>
        </div>
        
        
        <script src="node_modules/@popperjs/core/dist/umd/popper.min.js"></script>        
        <script src="node_modules/bootstrap/dist/js/bootstrap.min.js"></script>
        <script src="js/projectManager.js"></script>
        <script src="js/jquery-3.6.0.min.js"></script>
    </body>
</html>