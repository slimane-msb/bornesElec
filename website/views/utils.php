<?php

function loginFirst(){
    if (!isset($_COOKIE['name'])) {
        header('Location: login.php'); 
    } 
}

function login($email, $password){
    $req = "SELECT * FROM users WHERE email = '$email' AND password='$password'";
    include("db_connect.php");
    $conn = connectDb("USERS", $dbuser, $dbpass);

    $result = $conn->query($req);
    
    if ($result->num_rows > 0) {
        $res = $result->fetch_assoc();
        setcookie('name', $res["name"], time()+60);
        setcookie('email', $res["email"], time()+60);
        header('Location: index.php'); 
    }else{
        loginFirst();
    }
}

function register($email, $name, $password){
    $req = "SELECT * FROM users WHERE email = '$email' AND password='$password'";
    include("db_connect.php");
    $conn = connectDb("USERS", $dbuser, $dbpass);

    $result = $conn->query($req);
    
    if ($result->num_rows > 0) {
        // utilisateur existant 
        loginFirst();
    }else{
        $req = "INSERT INTO users (name, email, password) VALUES('$name', '$email', '$password')";
        $inserted = $conn->query($req);
        if ($inserted){
            setcookie('name', $name, time()+60);
            setcookie('email', $email, time()+60);
            header('Location: index.php'); 
        }else{
            header('Location: register.php');
        }
    }
}


?>