<?php

function connectDb ($dbname){
    $dbhost = 'localhost';
    $dbuser = 'phpmyadmin';
    $dbpass = 'g2CE32kcpOB3'; // juste en Dev
    $conn = new mysqli($dbhost, $dbuser, $dbpass, $dbname);
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }
    return $conn;
}

function disconnectDb($connection){
    $connection->close();
}

?>