/*
//Projects
const project1 = document.getElementById("project-1");

//Buttons
const btnProject1 = document.getElementById("btn-project-1");

//Form join a project
const formJoinProject = document.getElementById("form-join-project");
const errorProjectJoin = document.getElementById("errorProjectJoin");
const inputAccessCode = document.getElementById("inputAccessCode");

//Form create project
const formCreateProject = document.getElementById("form-create-project");
const inputProjectName = document.getElementById("inputProjectName");
const inputProjectDescription = document.getElementById("inputProjectDescription");
const errorProjectName = document.getElementById("errorProjectName");

//Form create task
const formCreateTask = document.getElementById("form-create-task");
const inputTaskName = document.getElementById("inputTaskName");
const inputTaskDescription = document.getElementById("inputTaskDescription");
const inputTaskDate = document.getElementById("inputTaskDate");

let exists;

formJoinProject.addEventListener("submit", (e) => {
    e.preventDefault();
    validUser();
    let func = setTimeout(joinProject, 100);
});

function joinProject() {
    if (exists) {
        //showToast(toastJoinProjectEx);
        errorProjectJoin.classList.add("si-visible");
        errorProjectJoin.classList.remove("no-visible");
        inputAccessCode.style.boxShadow = "inset 0 0 0 2px #4111CA";
    }
    else {
        console.log("no exists");
        formJoinProject.submit();
    }
}

//Form create project icon
formCreateProject.addEventListener("submit", (e) => {
    e.preventDefault();
    let projectName = inputProjectName.value;
    let banner = true;

    if (projectName == ""){
        errorProjectName.classList.add("si-visible");
        errorProjectName.classList.remove("no-visible");

        inputProjectName.style.boxShadow = "inset 0 0 0 2px #4111CA";
        banner = false;
    }
    if (banner){
        formCreateProject.submit();
    }
});


formCreateTask.addEventListener("submit", (e) => {
    e.preventDefault();
    let taskName = inputTaskName.value;
    let taskDate = inputTaskDate.value;
    let banner = true;

    if (taskName == ""){
        errorProjectName.classList.add("si-visible");
        errorProjectName.classList.remove("no-visible");

        inputProjectName.style.boxShadow = "inset 0 0 0 2px #4111CA";
        banner = false;
    }
    if (banner){
        formCreateTask.submit();
    }
});


inputProjectName.addEventListener("click", () => {
    errorProjectName.classList.remove("si-visible");
    errorProjectName.classList.add("no-visible");
    inputProjectName.style.boxShadow = "none";
});

*/
//Toasts
const toastTaskCompleted = document.getElementById("toastTaskCompleted");

//Toast show function
function showToast(t) {
    const toast = new bootstrap.Toast(t);
    toast.show();
}



function completeTask(id) {
    $.ajax({
        url: "CompleteTask", 
        data: {
            taskId: id
        },
        type: "POST",
        success: function (result){
            showToast(toastTaskCompleted);
            
            /*
            if (result == "true") {
                console.log("xd");
                exists = true;
            }
            else {
                exists = false;
            }*/
        }
    });
}