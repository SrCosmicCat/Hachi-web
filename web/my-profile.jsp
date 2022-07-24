<%@page import="models.Project"%>
<%@page import="models.User"%>
<%@page import="models.Task"%>
<%@page import="db.ConnectionDB"%>
<%@page import="javax.servlet.http.HttpSession"%>
<%
    ConnectionDB connection = new ConnectionDB();
    session = request.getSession();
    User actualUser = connection.getUserById(Integer.parseInt(session.getAttribute("idUser").toString()));
%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>My profile</title>
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
                            <a class="dropdown-item" href="my-profile.jsp">My profile</a>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="Logout">Logout</a>
                        </div>
                    </li>  
                </ul>
            </div>
        </nav>  
        <div class="main">
            <div class="container-fluid">
                <hr>
                <div class="hive">
                    <!-- Dashboard-->
                    <div class="row">
                        <div class="col-md-12">
                            <div class="darker-box">
                                <h1 class="bigTitle">
                                    My Profile
                                </h1>
                                <div class="secondForm">
                                    <form id="formUpdateUser" action="UserUpdate"  method="POST">
                                        <div class="col-md-12">
                                            <div class="row">
                                                <div class="input-container">
                                                    <input type="text" class="editableField" value="<%=actualUser.getName()%>" name="inputShowName" id="inputShowName" disabled>
                                                    <svg class="icon-edit" id="editName"></svg>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="input-container">
                                                    <input type="email" class="editableField" value="<%=actualUser.getEmail()%>" name="inputShowEmail" id="inputShowEmail" disabled>
                                                    <svg class="icon-edit" id="editEmail"></svg>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="input-container">
                                                    <input type="text" class="editableField" value="<%=actualUser.getUsername()%>" name="inputShowUsername" id="inputShowUsername" disabled>
                                                    <svg class="icon-edit" id="editUsername"></svg>  
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="input-container">
                                                    <input type="password" class="editableField" value="<%=actualUser.getPassword()%>" name="inputShowPassword" id="inputShowPassword" disabled>
                                                    <svg class="icon-edit" id="editPassword"></svg>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-md d-flex justify-content-center mt-5">
                                                <button type="submit" class="create-add-button">Save Changes</button>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                    <hr>
                                </div>
                                <h2 class="regularText">Delete Account</h2>
                                <div class="secondForm">
                                    <form id="formDeleteAccount" action="UserDelete" method="POST">
                                        <div class="row">
                                            <div class="col-md-12">
                                                <div class="row">
                                                    <div class="col-md">
                                                    <p class="normalText m-4">If you wish to delete your account, please provide us the following information</p>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md">
                                                        <div class="input-container">
                                                            <input type="email" id="inputDeleteEmail" name="inputDeleteEmail" class="editableField" placeholder="email">
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-md">
                                                        <div class="input-container">
                                                            <input type="password" id="inputDeletePass" name="inputDeletePass" class="editableField" placeholder="password">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md d-flex justify-content-center mt-5">
                                                <button type="submit" class="create-add-button">Delete account</button>
                                            </div>
                                        </div>
                                    </form>
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
        <script src="node_modules/@popperjs/core/dist/umd/popper.min.js"></script>        
        <script src="node_modules/bootstrap/dist/js/bootstrap.min.js"></script>
        <script src="js/my-profile.js"></script>
    </body>
</html>