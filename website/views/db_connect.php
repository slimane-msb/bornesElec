<?php
$dbhost = 'localhost';
$dbname = 'BORNES2';
$dbuser = 'phpmyadmin';
$dbpass = 'g2CE32kcpOB3'; // juste en Dev

function connectDb ($dbname, $dbuser, $dbpass){
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