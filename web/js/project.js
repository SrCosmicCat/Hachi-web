const hive = document.getElementById("secHive");
const posts = document.getElementById("secPosts");
const members = document.getElementById("secMembers");

const btnHive = document.getElementById("btnHive");
const btnPosts = document.getElementById("btnPosts");
const btnMembers = document.getElementById("btnMembers");

switch (getParameterByName("sec")){
    case "hive": showHive();
        break;
    case "posts": showPosts();
        break;
    case "members": showMembers();
        break;
    //case default:
       
}
function showHive() {
    hive.classList.remove("no-visible");
    posts.classList.add("no-visible");
    members.classList.add("no-visible");
}
function showPosts() {
    hive.classList.add("no-visible");
    posts.classList.remove("no-visible");
    members.classList.add("no-visible");
}
function showMembers() {
    hive.classList.add("no-visible");
    posts.classList.add("no-visible");
    members.classList.remove("no-visible");
}

btnHive.addEventListener("click", () => {
    showHive();
});
btnPosts.addEventListener("click", () => {
    showPosts();
});
btnMembers.addEventListener("click", () => {
    showMembers();
});

/*
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
 */
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
