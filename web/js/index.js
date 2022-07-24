//Forms
const formSignUp = document.getElementById("form-sign-up");
const formLogIn = document.getElementById("form-log-in");

//Buttons
const btnSignUp = document.getElementById("btn-sign-up");
const btnLogIn = document.getElementById("btn-log-in");

//Sign Up
const inputFullName = document.getElementById("inputFullName");
const inputUsername= document.getElementById("inputUsername");
const inputEmail = document.getElementById("inputEmail");
const inputPassword = document.getElementById("inputPassword");
const inputTerms = document.getElementById("inputTerms");

//Log In
const inputEmailUsername = document.getElementById("inputEmailUsername");
const inputPasswordLogin = document.getElementById("inputPasswordLogin");

//Error
const errorName = document.getElementById("errorName");
const errorUsername = document.getElementById("errorUsername");
const errorEmail = document.getElementById("errorEmail");
const errorPassword = document.getElementById("errorPassword");
const errorUsernameEmail = document.getElementById("errorUsernameEmail");
const errorPasswordLogin = document.getElementById("errorPasswordLogin");

//Toasts
const toastUsername = document.getElementById("toastUsername");
const toastEmail = document.getElementById("toastEmail");
const toastLogin = document.getElementById("toastLogin");

//Toast show function
function showToast(t) {
    const toast = new bootstrap.Toast(t);
    toast.show();
}

//Read parameters
if (getParameterByName("p") == "login") {
    enableLogIn();
}
else if (getParameterByName("p") == "errorU") {
    showToast(toastUsername);
    inputUsername.style.boxShadow = "inset 0 0 0 2px #4111CA";
    errorUsername.classList.add("si-visible");
    errorUsername.classList.remove("no-visible");
}
else if (getParameterByName("p") == "errorE") {
    showToast(toastEmail);
    inputEmail.style.boxShadow = "inset 0 0 0 2px #4111CA";
    errorEmail.classList.add("si-visible");
    errorEmail.classList.remove("no-visible");
}
else if (getParameterByName("p")== "errorL") {
    showToast(toastLogin);
    enableLogIn();
}



//Action buttons from header
btnLogIn.addEventListener("click", () => {
    enableLogIn();
});

btnSignUp.addEventListener("click", () => {
    enableSignUp();
});

//SignUp function
function enableSignUp() {
    if (formSignUp.className == "no-visible") {
        formSignUp.classList.add("si-visible");
        formSignUp.classList.remove("no-visible");
        formLogIn.classList.add("no-visible");
        formLogIn.classList.remove("si-visible");

        btnSignUp.classList.add("btn-default-round-md");
        btnSignUp.classList.remove("btn-primary-round-md");

        btnLogIn.classList.remove("btn-default-round-md");
        btnLogIn.classList.add("btn-primary-round-md");
    }
}

//Log in function
function enableLogIn() {
   if (formLogIn.className == "no-visible") {
        formLogIn.classList.add("si-visible");
        formLogIn.classList.remove("no-visible");
        formSignUp.classList.add("no-visible");
        formSignUp.classList.remove("si-visible");

        btnLogIn.classList.add("btn-default-round-md");
        btnLogIn.classList.remove("btn-primary-round-md");

        btnSignUp.classList.remove("btn-default-round-md");
        btnSignUp.classList.add("btn-primary-round-md");
    }
}

//Form icons from Sign Up
formSignUp.addEventListener("submit", (e) => {
    e.preventDefault();
    let name = inputFullName.value;
    let username = inputUsername.value;
    let email = inputEmail.value;
    let password = inputPassword.value;
    let checkterms = inputTerms.checked;
    let banner = true;

    if (name == ""){
        errorName.classList.add("si-visible");
        errorName.classList.remove("no-visible");
        inputFullName.style.boxShadow = "inset 0 0 0 2px #4111CA";
        banner = false;
    }
    if (username == ""){
        errorUsername.classList.add("si-visible");
        errorUsername.classList.remove("no-visible");
        inputUsername.style.boxShadow = "inset 0 0 0 2px #4111CA";
        banner = false;
    }
    if (email == ""){
        errorEmail.classList.add("si-visible");
        errorEmail.classList.remove("no-visible");
        inputEmail.style.boxShadow = "inset 0 0 0 2px #4111CA";
        banner = false;
    }
    if (password == ""){
        errorPassword.classList.add("si-visible");
        errorPassword.classList.remove("no-visible");
        inputPassword.style.boxShadow = "inset 0 0 0 2px #4111CA";
        banner = false;
    }
    if (!checkterms) {
        inputTerms.style.boxShadow = "inset 0 0 0 2px #4111CA";
        banner = false;
    }
    if (banner){
        //Submit form
        formSignUp.submit();

        //Go to Log in
        formLogIn.classList.add("si-visible");
        formLogIn.classList.remove("no-visible");
        formSignUp.classList.add("no-visible");
        formSignUp.classList.remove("si-visible");

        btnLogIn.classList.add("btn-default-round-md");
        btnLogIn.classList.remove("btn-primary-round-md");

        btnSignUp.classList.remove("btn-default-round-md");
        btnSignUp.classList.add("btn-primary-round-md");
    }
});

//Form icons from Log in
formLogIn.addEventListener("submit", (e) => {
    e.preventDefault();
    let usernameEmail = inputEmailUsername.value;
    let password = inputPasswordLogin.value;
    let banner = true;

    if (usernameEmail == ""){
        errorUsernameEmail.classList.add("si-visible");
        errorUsernameEmail.classList.remove("no-visible");
        inputEmailUsername.style.boxShadow = "inset 0 0 0 2px #4111CA";
        banner = false;
    }
    if (password == ""){
        errorPasswordLogin.classList.add("si-visible");
        errorPasswordLogin.classList.remove("no-visible");
        inputPasswordLogin.style.boxShadow = "inset 0 0 0 2px #4111CA";
        banner = false;
    }
    if (banner){
        //Submit form
        formLogIn.submit();
    }
});



//Input click errors
inputFullName.addEventListener("click", () => {
    errorName.classList.remove("si-visible");
    errorName.classList.add("no-visible");
    inputFullName.style.boxShadow = "none";
});
inputUsername.addEventListener("click", () => {
    errorUsername.classList.remove("si-visible");
    errorUsername.classList.add("no-visible");
    inputUsername.style.boxShadow = "none";
});

inputEmail.addEventListener("click", () => {
    errorEmail.classList.remove("si-visible");
    errorEmail.classList.add("no-visible");
    inputEmail.style.boxShadow = "none";
});
inputPassword.addEventListener("click", () => {
    errorPassword.classList.remove("si-visible");
    errorPassword.classList.add("no-visible");
    inputPassword.style.boxShadow = "none";
});
inputPassword.addEventListener("click", () => {
    errorPassword.classList.remove("si-visible");
    errorPassword.classList.add("no-visible");
    inputPassword.style.boxShadow = "none";
});

inputEmailUsername.addEventListener("click", () => {
    errorUsernameEmail.classList.remove("si-visible");
    errorUsernameEmail.classList.add("no-visible");
    inputEmailUsername.style.boxShadow = "none";
});
inputTerms.addEventListener("click", () => {
    inputTerms.style.boxShadow = "none";
});

function getParameterByName(variable) {
   var query = window.location.search.substring(1);
   var vars = query.split("&");
   for (var i=0; i < vars.length; i++) {
       var pair = vars[i].split("=");
       if(pair[0] == variable) {
           return pair[1];
       }
   }
   return false;
}
