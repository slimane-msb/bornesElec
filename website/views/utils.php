<?php

function loginFirst(){
    if (!isset($_COOKIE['name'])) {
        header('Location: login.php'); 
    }else{
        // il faut lancer sessions dans toutes les pages
        session_start();
    }
}

function login($email, $password){
    $req = "SELECT * FROM users WHERE email = '$email' AND password='$password'";
    include("db_connect.php");
    $conn = connectDb("USERS");

    $result = $conn->query($req);
    
    if ($result->num_rows > 0) {
        $res = $result->fetch_assoc();
        setcookie('name', $res["name"], time()+600);
        setcookie('email', $res["email"], time()+600);
        disconnectDb($conn);
        header('Location: index.php'); 
    }else{
        disconnectDb($conn);
        return createLog(True,"Veuillez entrer un mail et un mot de passe valide");
    }
}

function register($email, $name, $password){
    $req = "SELECT * FROM users WHERE email = '$email' AND password='$password'";
    include("db_connect.php");
    $conn = connectDb("USERS");

    $result = $conn->query($req);
    
    if ($result->num_rows > 0) {
        disconnectDb($conn); 
        return createLog(True,"utilisateur existant");
    }else{
        $req = "INSERT INTO users (name, email, password) VALUES('$name', '$email', '$password')";
        $inserted = $conn->query($req);
        if ($inserted){
            setcookie('name', $name, time()+60);
            setcookie('email', $email, time()+60);
            disconnectDb($conn);
            header('Location: index.php'); 
        }else{
            disconnectDb($conn);
            return createLog(True,"Erreur dans la creation du compte, veuillez entrer des données valides");
        }
    }
}



function logout(){
    //unset name and email 
    setcookie('name');
    setcookie('email');
    session_unset();  
    session_destroy();
    header('Location: index.php'); 
}




function createLog ($isError, $message){
    return array(
        "isError"=>$isError,
        "message" => $message
    );
}


function showLog($log){
    if (!empty($log)){
        if($log["isError"]){
            $classLog = "error-log";
        }else{
            $classLog = "success-log";
        }
        echo "<p class='$classLog'>" . $log["message"] . "</p>";
    } 
}




?>