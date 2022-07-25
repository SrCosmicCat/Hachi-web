package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.Comment;
import models.Project;
import models.Task;
import models.User;

public class ConnectionDB {
    Connection con;
    Statement smt;
    ResultSet rs;

    public ConnectionDB() {
    }
    
    public void connect() {
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            //Ruta a la BD, usuario, password
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/HACHI","root","");
            smt = con.createStatement();
            
            System.out.println("Conexión exitosa");
        }
        catch (ClassNotFoundException | SQLException e) {
            System.out.println("Error en la conexión "+e);
        }
    }
    
    public void disconnect() {
        try{
            con.close();
            System.out.println("Desconexión exitosa");
        }
        catch (SQLException ex) {
            System.out.println(ex);
        }
    }
    
    public int insertUser(User u) {
        //Generate id
        int idGen = genUserId();
        //Generate sql query
        String sql = "INSERT INTO USERH (id_user, name_user, username, email, pass_user) VALUES("+Integer.toString(idGen)+",'"+u.getName()+"','"+u.getUsername()+"','"+u.getEmail()+"','"+u.getPassword()+"')";
        try {
            connect();
            int regs = smt.executeUpdate(sql);
            disconnect();
            return regs;
        }
        catch (SQLException ex) {
            System.out.println(ex+sql);
            return 0;
        }
    }
    
    public int updateUser(User actualUser, User newUser) {
        //Generate sql query
        String sql = "UPDATE USERH SET name_user = '"+newUser.getName()+"', username = '"+newUser.getUsername()+"', email = '"+newUser.getEmail()+"', pass_user = '"+newUser.getPassword()+"' WHERE id_user = "+Integer.toString(actualUser.getId());
        try {
            connect();
            int regs = smt.executeUpdate(sql);
            disconnect();
            return regs;
        }
        catch (SQLException ex) {
            System.out.println(ex+sql);
            return 0;
        }       
    }
    
    public int deleteUser(User u) {
        //Generate sql query
        String sql = "DELETE FROM USERH WHERE id_user = "+u.getId(); //CAMBIAAAAAAAAAAAAAAAAR
        
        try {
            connect();
            //delete user projects
            deleteUserProjects(u);
            //Delete user
            int regs = smt.executeUpdate(sql);
            
            disconnect();
            return regs;
        }
        catch (SQLException ex) {
            System.out.println(ex+sql);
            return 0;
        }
    }
    
    private void deleteUserProjects(User u) {
        String sql = "";
        //Delete the projects from user
        Project[] userProjects = getUserProjects(u.getId());
        for (Project userProject : userProjects) {
            if (getProjectAdmin(userProject.getId()).getId() == u.getId()) {
                sql = "DELETE FROM PROJECT WHERE id_proj = " + userProject.getId();
                try{
                    connect();
                    smt.executeUpdate(sql);
                    System.out.println("Proyecto borrado");
                }
                catch (SQLException ex) {
                    System.out.println(ex+sql);
                }
            }
        }
    }
    
    public int insertProject(Project p, User u) {
        //Generate id
        int idGen = genProjectId();
        String codeGen = genProjectCode();
        LocalDate date = LocalDate.now();
        //Generate sql query for insertion of project
        String sql = "INSERT INTO PROJECT (id_proj, name_proj, desc_proj, code_proj) VALUES("+Integer.toString(idGen)+",'"+p.getName()+"','"+p.getDescription()+"','"+codeGen+"')";
        //Generate sql query for insertion in table access
        String sql2 = "INSERT INTO access VALUES("+Integer.toString(u.getId())+","+Integer.toString(idGen)+",'"+date+"','ADMIN')";
        //Generate sql query for insertion in table make1
        String sql3 = "INSERT INTO make1 VALUES("+Integer.toString(u.getId())+","+Integer.toString(idGen)+",'"+date+"')";
        
        try {
            connect();
            int regs = smt.executeUpdate(sql);
            smt.executeUpdate(sql2);
            smt.executeUpdate(sql3);
            disconnect();
            return regs;
        }
        catch (SQLException ex) {
            System.out.println(ex+sql);
            return 0;
        }
    }
    
    public int insertTask(Task t, User u, User uAssign, Project p) {
        //Generate id
        int idGen = genTaskId();
        LocalDate date = LocalDate.now();
        //Generate sql query for insertion of task
        String sql = "INSERT INTO TASK (id_task, name_task, desc_task, date_task, state, id_proj1) VALUES("+Integer.toString(idGen)+",'"+t.getName()+"','"+t.getDescription()+"','"+t.getDate()+"',FALSE,"+p.getId()+")";
        //Generate sql query for insertion in table make2
        String sql2 = "INSERT INTO make2 VALUES("+Integer.toString(u.getId())+","+Integer.toString(idGen)+",'"+date+"')";
        
        try {
            connect();
            int regs = smt.executeUpdate(sql);
            smt.executeUpdate(sql2);
            
            t = getTaskById(idGen);
            
            insertUserTask(uAssign, t);
                    
            disconnect();
            return regs;
        }
        catch (SQLException ex) {
            System.out.println(ex+sql);
            return 0;
        }
    }
    
    public int insertUserTask(User u, Task t) {
        LocalDate date = LocalDate.now();
        //Generate sql query for insertion in table access
        //CHANGE TO INSERTPROJECT String sql = "INSERT INTO access VALUES("+Integer.toString(u.getId())+","+Integer.toString(p.getId())+",'"+date+"','USER')";
        //Generate sql query for insertion in table assign_t
        String sql = "INSERT INTO assign_t VALUES("+Integer.toString(u.getId())+","+Integer.toString(t.getId())+",'"+date+"')";
        
        try {
            connect();
            int regs = smt.executeUpdate(sql);
            disconnect();
            return regs;
        }
        catch (SQLException ex) {
            System.out.println(ex+sql);
            return 0;
        }
    }
    
     public int completeTask(Task t, User u) {
        //Obtain the date
        LocalDate date = LocalDate.now();
        //Generate sql query for update task to completed
        String sql = "UPDATE TASK SET state = TRUE WHERE id_task = "+t.getId();
        //Generate sql query for insertion in table realice
        String sql2 = "INSERT INTO realice VALUES("+u.getId()+","+t.getId()+",'"+date+"')";
        
        try {
            connect();
            int regs = smt.executeUpdate(sql);
            smt.executeUpdate(sql2);
                    
            disconnect();
            return regs;
        }
        catch (SQLException ex) {
            System.out.println(ex+sql);
            return 0;
        }
    }
    
    public int insertUserProject(User u, Project p) {
        LocalDate date = LocalDate.now();
        //Generate sql query for insertion in table access
        String sql = "INSERT INTO access VALUES("+Integer.toString(u.getId())+","+Integer.toString(p.getId())+",'"+date+"','USER')";
        //Generate sql query for insertion in table assign_p
        String sql2 = "INSERT INTO assign_p VALUES("+Integer.toString(u.getId())+","+Integer.toString(p.getId())+",'"+date+"')";
        
        try {
            connect();
            int regs = smt.executeUpdate(sql);
            smt.executeUpdate(sql2);
            disconnect();
            return regs;
        }
        catch (SQLException ex) {
            System.out.println(ex+sql);
            return 0;
        }
    }
    
    public int sendCommentTask(Comment c) {
        //Obtain the date
        LocalDate date = LocalDate.now();
        //Generate sql query
        String sql = "INSERT INTO comment_t (desc_com, date_com, id_user6, id_task3) VALUES('"+c.getDescription()+"','"+date+"',"+c.getIdUser()+","+c.getIdTask()+")";
        try {
            connect();
            int regs = smt.executeUpdate(sql);
            disconnect();
            return regs;
        }
        catch (SQLException ex) {
            System.out.println(ex+sql);
            return 0;
        }
    }
    
    public int genUserId() {
        //Generate sql quey
        String sql = "SELECT MAX(id_user) FROM USERH";
        try {
            //declare id
            int id = 0;
            connect();
            //execute sql query
            rs = smt.executeQuery(sql);
            
            //obtain value of col
            if (rs != null) {
                
                while(rs.next()) {
                    id = rs.getInt(1);
                }
            }
            
            disconnect();
            //return the value of col id_usu + 1
            return id + 1;
        }
        catch (SQLException ex) {
            System.out.println(ex+sql);
            return 0;
        }
    }
    
    public int genProjectId() {
        //Generate sql quey
        String sql = "SELECT MAX(id_proj) FROM PROJECT";
        try {
            //declare id
            int id = 0;
            connect();
            //execute sql query
            rs = smt.executeQuery(sql);
            
            //obtain value of col
            if (rs != null) {
                
                while(rs.next()) {
                    id = rs.getInt(1);
                }
            }
            
            disconnect();
            //return the value of col id_usu + 1
            return id + 1;
        }
        catch (SQLException ex) {
            System.out.println(ex+sql);
            return 0;
        }
    }
    
    public String genProjectCode() {
        //Generate key
        String randomStr = genRandomString(6);
        
        //Check if the key exists in db, if exists, then generate another key
        while (existsInDB("PROJECT","code_proj",randomStr)) {
            randomStr = genRandomString(6);
        }
        
        return randomStr;
    }
    
    public int genTaskId() {
        //Generate sql quey
        String sql = "SELECT MAX(id_task) FROM TASK";
        try {
            //declare id
            int id = 0;
            connect();
            //execute sql query
            rs = smt.executeQuery(sql);
            
            //obtain value of col
            if (rs != null) {
                
                while(rs.next()) {
                    id = rs.getInt(1);
                }
            }
            
            disconnect();
            //return the value of col id_usu + 1
            return id + 1;
        }
        catch (SQLException ex) {
            System.out.println(ex+sql);
            return 0;
        }
    }
    
    public boolean existsInDB(String table, String col, String value) {
        //Generate sql query
        //Values of col = [nom_usu,username,email, pass_user]
        
        String sql = "SELECT "+col+" FROM "+table+" WHERE "+col+" = '"+value+"'";
        boolean exists = false;
        
        try {
            connect();
            //execute sql query
            rs = smt.executeQuery(sql);
            
            //obtain value of col
            if (rs != null) {
                
                while(rs.next()) {
                    //Check if the value of col is not null
                     if (!rs.getString(1).equals("")) {
                         //If the value of col is not null, then returns true
                         exists = true;
                     }
                }
            }
            
            disconnect();
            //return the existense in the DB of a row with the given value
            return exists;
        }
        catch (SQLException ex) {
            System.out.println(ex+sql);
            return false;
        }
    }
    
    public boolean checkLogin(String usernameEmail, String password) {
        //Generate sql query
        
        String sql = "SELECT name_user FROM USERH WHERE (username = '"+usernameEmail+"' OR email = '"+usernameEmail+"') AND pass_user ='"+password+"'";
        boolean exists = false;
        
        try {
            connect();
            //execute sql query
            rs = smt.executeQuery(sql);
            
            //obtain value of name_user
            if (rs != null) {
                
                while(rs.next()) {
                    //Check if the value of name_user is not null
                     if (!rs.getString(1).equals("")) {
                         //If the value of name_user is not null, means that user/email and password is correct, then returns true
                         exists = true;
                     }
                }
            }
            
            disconnect();
            //return the existense in the DB of a row with the given value
            return exists;
        }
        catch (SQLException ex) {
            System.out.println(ex+sql);
            return false;
        }
    }
    
     public boolean checkProject(User u, String codeProject) {
        //Generate sql query
        Project[] userProjects = getUserProjects(u.getId());
        boolean exists = false;
        
        for (Project userProject : userProjects) {
            if (userProject.getCode().equals(codeProject)) {
                exists = true;
            }
        }
        return exists;
    }
    
    public User getUserById(int id) {
        //Generate sql query
        String sql = "SELECT * FROM USERH WHERE id_user = "+id;
        
        try {
            connect();
            //execute sql query
            rs = smt.executeQuery(sql);
            //Creates a user to send
            User user = new User();
            //obtain values of user
            if (rs != null) {
                
                while(rs.next()) {
                    user.setId(id);
                    user.setName(rs.getString("name_user"));
                    user.setUsername(rs.getString("username"));
                    user.setEmail(rs.getString("email"));
                    user.setPassword(rs.getString("pass_user"));
                }
                //Sends user
                return user;
            }
            
            disconnect();
            //return null
            return null;
        }
        catch (SQLException ex) {
            System.out.println(ex+sql);
            return null;
        }
    }
    
    public User getUserByUsernameEmail(String usernameEmail) {
        //Generate sql query
        String sql = "SELECT * FROM USERH WHERE username = '"+usernameEmail+"' OR email = '"+usernameEmail+"'";
        
        try {
            connect();
            //execute sql query
            rs = smt.executeQuery(sql);
            //Creates a user to send
            User user = new User();
            //obtain values of user
            if (rs != null) {
                
                while(rs.next()) {
                    user.setId(rs.getInt("id_user"));
                    user.setName(rs.getString("name_user"));
                    user.setUsername(rs.getString("username"));
                    user.setEmail(rs.getString("email"));
                }
                //Sends user
                return user;
            }
            
            disconnect();
            //return null
            return null;
        }
        catch (SQLException ex) {
            System.out.println(ex+sql);
            return null;
        }
    }
    
    public Project getProjectById(int id) {
        //Generate sql query
        String sql = "SELECT * FROM PROJECT WHERE id_proj = "+id;
        
        try {
            connect();
            //execute sql query
            rs = smt.executeQuery(sql);
            //Creates a project to send
            Project project = new Project();
            //obtain values of user
            if (rs != null) {
                
                while(rs.next()) {
                    project.setId(id);
                    project.setName(rs.getString("name_proj"));
                    project.setDescription(rs.getString("desc_proj"));
                    project.setCode(rs.getString("code_proj"));
                }
                //Sends project
                return project;
            }
            
            disconnect();
            //return null
            return null;
        }
        catch (SQLException ex) {
            System.out.println(ex+sql);
            return null;
        }
    }
    
    public Project getProjectByCode(String code) {
        //Generate sql query
        String sql = "SELECT * FROM PROJECT WHERE code_proj = '"+code+"'";
        
        try {
            connect();
            //execute sql query
            rs = smt.executeQuery(sql);
            
            Project project = new Project();
            //obtain values of project
            if (rs != null) {
                
                while(rs.next()) {
                    //Creates a project to send
                    project.setId(rs.getInt("id_proj"));
                    project.setName(rs.getString("name_proj"));
                    project.setDescription(rs.getString("desc_proj"));
                    project.setCode(rs.getString("code_proj"));
                }
                //Sends project
                return project;
            }
            
            disconnect();
            //return null
            return null;
        }
        catch (SQLException ex) {
            System.out.println(ex+sql);
            return null;
        }
    }
    
    public Task getTaskById(int id) {
        //Generate sql query
        String sql = "SELECT * FROM TASK WHERE id_task = "+id;
        
        try {
            connect();
            //execute sql query
            rs = smt.executeQuery(sql);
            //Creates a task to send
            Task task = new Task();
            //obtain values of task
            if (rs != null) {
                
                while(rs.next()) {
                    task.setId(id);
                    task.setName(rs.getString("name_task"));
                    task.setDescription(rs.getString("desc_task"));
                    task.setDate(rs.getString("date_task"));
                    task.setCompleted(rs.getBoolean("state"));
                    task.setId_project(rs.getInt("id_proj1"));
                }
                //Sends task
                return task;
            }
            
            disconnect();
            //return null
            return null;
        }
        catch (SQLException ex) {
            System.out.println(ex+sql);
            return null;
        }
    }
    
    public Project[] getUserProjects(int id) {
        String sql = "CALL getUserProjects("+id+")";
        try {
            List<Project> list = new ArrayList<>();
            connect();
            rs = smt.executeQuery(sql);
            while (rs.next()) {
                Project project = new Project();
                project.setId(rs.getInt("id_proj"));
                project.setName(rs.getString("name_proj"));
                project.setDescription(rs.getString("desc_proj"));
                project.setCode(rs.getString("code_proj"));
                list.add(project);
            }
            Project[] strArray = new Project[list.size()];
            strArray = list.toArray(strArray);
            
            disconnect();
            return strArray;
        }
        catch (SQLException ex) {
            Logger.getLogger(Connection.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
        
    }
    
    public User[] getProjectMembers(int id) {
        String sql = "CALL getProjectMembers("+id+")";
        
        try {
            List<User> list = new ArrayList<>();
            connect();
            rs = smt.executeQuery(sql);
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id_user"));
                user.setName(rs.getString("name_user"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                list.add(user);
            }
            User[] strArray = new User[list.size()];
            strArray = list.toArray(strArray);
            
            disconnect();
            return strArray;
        }
        catch (SQLException ex) {
            Logger.getLogger(Connection.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
        
    }
    
    public User getProjectAdmin(int idProj) {
        //Generate sql query
        String sql = "CALL getProjectAdmin("+idProj+");";
        
        try {
            connect();
            //Execute query
            rs = smt.executeQuery(sql);
            //Create a user to send
            User user = new User();
            //Assign user values
            while (rs.next()) {
                user.setId(rs.getInt("id_user"));
                user.setName(rs.getString("name_user"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
            }
            disconnect();
            //Return user
            return user;
            
        }
        catch (SQLException ex) {
            Logger.getLogger(Connection.class.getName()).log(Level.SEVERE, null, ex);
            return null;
        }
        
    }
    
    public Task[] getUserTasks(int idUser, int idProj) {
        //Generate sql query
        String sql = "CALL getUserTasks("+idUser+","+idProj+")";
        
        try {
            List<Task> list = new ArrayList<>();
            connect();
            //execute sql query
            rs = smt.executeQuery(sql);
            
            //obtain values of tasks
            while(rs.next()) {
                //Creates a tasks to send
                Task task = new Task();
                task.setId(rs.getInt("id_task"));
                task.setName(rs.getString("name_task"));
                task.setDescription(rs.getString("desc_task"));
                task.setDate(rs.getString("date_task"));
                task.setCompleted(rs.getBoolean("state"));
                task.setId_project(rs.getInt("id_proj1"));
                task.setId_user(idUser);
                list.add(task);
            }
            Task[] strArray = new Task[list.size()];
            strArray = list.toArray(strArray);
            
            disconnect();
            return strArray;
        }
        catch (SQLException ex) {
            System.out.println(ex+sql);
            return null;
        }
    }
    
    public Task[] getProjectTasks(int idProj) {
        //Generate sql query
        String sql = "CALL getProjectTasks("+idProj+")";
        
        try {
            List<Task> list = new ArrayList<>();
            connect();
            //execute sql query
            rs = smt.executeQuery(sql);
            
            //obtain values of tasks
            while(rs.next()) {
                //Creates a tasks to send
                Task task = new Task();
                task.setId(rs.getInt("id_task"));
                task.setName(rs.getString("name_task"));
                task.setDescription(rs.getString("desc_task"));
                task.setDate(rs.getString("date_task"));
                task.setCompleted(rs.getBoolean("state"));
                task.setId_project(rs.getInt("id_proj1"));
                task.setId_user(rs.getInt("id_user7"));
                list.add(task);
            }
            Task[] strArray = new Task[list.size()];
            strArray = list.toArray(strArray);
            
            disconnect();
            return strArray;
        }
        catch (SQLException ex) {
            System.out.println(ex+sql);
            return null;
        }
    }
    
    public Task[] getTasksToDo(int idUser, int idProj) {
        //Obtain the date
        LocalDate date = LocalDate.now();
        //Generate sql query
        String sql = "CALL getTasksToDo("+idUser+","+idProj+",'"+date+"')";
        
        try {
            List<Task> list = new ArrayList<>();
            connect();
            //execute sql query
            rs = smt.executeQuery(sql);
            
            //obtain values of tasks
            while(rs.next()) {
                //Creates a tasks to send
                Task task = new Task();
                task.setId(rs.getInt("id_task"));
                task.setName(rs.getString("name_task"));
                task.setDescription(rs.getString("desc_task"));
                task.setDate(rs.getString("date_task"));
                task.setCompleted(rs.getBoolean("state"));
                task.setId_project(rs.getInt("id_proj1"));
                task.setId_user(idUser);
                list.add(task);
            }
            Task[] strArray = new Task[list.size()];
            strArray = list.toArray(strArray);
            
            disconnect();
            return strArray;
        }
        catch (SQLException ex) {
            System.out.println(ex+sql);
            return null;
        }
    }
    
    public Task[] getTasksUrgent(int idUser, int idProj) {
        //Obtain the date
        LocalDate date = LocalDate.now();
        //Generate sql query
        String sql = "CALL getTasksUrgent("+idUser+","+idProj+",'"+date+"')";
        
        try {
            List<Task> list = new ArrayList<>();
            connect();
            //execute sql query
            rs = smt.executeQuery(sql);
            
            //obtain values of tasks
            while(rs.next()) {
                //Creates a tasks to send
                Task task = new Task();
                task.setId(rs.getInt("id_task"));
                task.setName(rs.getString("name_task"));
                task.setDescription(rs.getString("desc_task"));
                task.setDate(rs.getString("date_task"));
                task.setCompleted(rs.getBoolean("state"));
                task.setId_project(rs.getInt("id_proj1"));
                task.setId_user(idUser);
                list.add(task);
            }
            Task[] strArray = new Task[list.size()];
            strArray = list.toArray(strArray);
            
            disconnect();
            return strArray;
        }
        catch (SQLException ex) {
            System.out.println(ex+sql);
            return null;
        }
    }
    
    public Task[] getTasksPast(int idUser, int idProj) {
        //Obtain the date
        LocalDate date = LocalDate.now();
        //Generate sql query
        String sql = "CALL getTasksPast("+idUser+","+idProj+",'"+date+"')";
        
        try {
            List<Task> list = new ArrayList<>();
            connect();
            //execute sql query
            rs = smt.executeQuery(sql);
            
            //obtain values of tasks
            while(rs.next()) {
                //Creates a tasks to send
                Task task = new Task();
                task.setId(rs.getInt("id_task"));
                task.setName(rs.getString("name_task"));
                task.setDescription(rs.getString("desc_task"));
                task.setDate(rs.getString("date_task"));
                task.setCompleted(rs.getBoolean("state"));
                task.setId_project(rs.getInt("id_proj1"));
                task.setId_user(idUser);
                list.add(task);
            }
            Task[] strArray = new Task[list.size()];
            strArray = list.toArray(strArray);
            
            disconnect();
            return strArray;
        }
        catch (SQLException ex) {
            System.out.println(ex+sql);
            return null;
        }
    }
    
    public Task[] getTasksDone(int idUser, int idProj) {
        //Generate sql query
        String sql = "CALL getTasksDone("+idUser+","+idProj+")";
        
        try {
            List<Task> list = new ArrayList<>();
            connect();
            //execute sql query
            rs = smt.executeQuery(sql);
            
            //obtain values of tasks
            while(rs.next()) {
                //Creates a tasks to send
                Task task = new Task();
                task.setId(rs.getInt("id_task"));
                task.setName(rs.getString("name_task"));
                task.setDescription(rs.getString("desc_task"));
                task.setDate(rs.getString("date_task"));
                task.setCompleted(rs.getBoolean("state"));
                task.setId_project(rs.getInt("id_proj1"));
                task.setId_user(idUser);
                list.add(task);
            }
            Task[] strArray = new Task[list.size()];
            strArray = list.toArray(strArray);
            
            disconnect();
            return strArray;
        }
        catch (SQLException ex) {
            System.out.println(ex+sql);
            return null;
        }
    }
    
public Comment[] getTaskComments(Task t) {
        //Generate sql query
        String sql = "CALL getTaskComments("+t.getId()+")";
        
        try {
            List<Comment> list = new ArrayList<>();
            connect();
            //execute sql query
            rs = smt.executeQuery(sql);
            
            //obtain values of tasks
            while(rs.next()) {
                //Creates a tasks to send
                Comment com = new Comment();
                com.setAuthor(rs.getString("name_user"));
                com.setDescription(rs.getString("desc_com"));
                com.setDate(rs.getString("date_com"));
                list.add(com);
            }
            Comment[] strArray = new Comment[list.size()];
            strArray = list.toArray(strArray);
            
            disconnect();
            return strArray;
        }
        catch (SQLException ex) {
            System.out.println(ex+sql);
            return null;
        }
    }
    
public int getTotalNumTasks(User u, Project p) {
        //Generate sql query
        String sql = "CALL getTotalNumTasks("+u.getId()+","+p.getId()+")";
        int tasks = 0;
        try {
            
            connect();
            //execute sql query
            rs = smt.executeQuery(sql);
            
            //obtain values of tasks
            while(rs.next()) {
                tasks = rs.getInt(1);
            }
            disconnect();
            return tasks;
        }
        catch (SQLException ex) {
            System.out.println(ex+sql);
            return tasks;
        }
    }

public int getTotalNumComTask(User u, Project p) {
        //Generate sql query
        String sql = "CALL getTotalNumComTask("+u.getId()+","+p.getId()+")";
        int tasks = 0;
        try {
            
            connect();
            //execute sql query
            rs = smt.executeQuery(sql);
            
            //obtain values of tasks
            while(rs.next()) {
                tasks = rs.getInt(1);
            }
            disconnect();
            return tasks;
        }
        catch (SQLException ex) {
            System.out.println(ex+sql);
            return tasks;
        }
    }
     
    public String genRandomString(int s) {
        UUID randomUUID = UUID.randomUUID();
        return (randomUUID.toString().replaceAll("-", "")).substring(0,s);
    }
}
