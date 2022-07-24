//Forms
const formUpdateUser = document.getElementById("formUpdateUser");
const formDeleteAccount = document.getElementById("formDeleteAccount");

//Buttons
const btnEditName = document.getElementById("editName");
const btnEditEmail = document.getElementById("editEmail");
const btnEditUsername = document.getElementById("editUsername");
const btnEditPassword = document.getElementById("editPassword");

//Inputs edit 
const inputShowName = document.getElementById("inputShowName");
const inputShowEmail= document.getElementById("inputShowEmail");
const inputShowUsername = document.getElementById("inputShowUsername");
const inputPassword = document.getElementById("inputPassword");
const inputShowPassword = document.getElementById("inputShowPassword");


btnEditName.addEventListener("click", () => {
    inputShowName.disabled = !inputShowName.disabled;
    btnEditName.classList.add("no-visible");
});
btnEditEmail.addEventListener("click", () => {
    inputShowEmail.disabled = !inputShowEmail.disabled;
    btnEditEmail.classList.add("no-visible");
});
btnEditUsername.addEventListener("click", () => {
    inputShowUsername.disabled = !inputShowUsername.disabled;
    btnEditUsername.classList.add("no-visible");
});
btnEditPassword.addEventListener("click", () => {
    inputShowPassword.disabled = !inputShowPassword.disabled;
    btnEditPassword.classList.add("no-visible");
});

//Form icons from Sign Up
formUpdateUser.addEventListener("submit", (e) => {
    e.preventDefault();
    inputShowName.disabled = false;
    inputShowUsername.disabled = false;
    inputShowEmail.disabled = false;
    inputShowPassword.disabled = false;
    formUpdateUser.submit();
});