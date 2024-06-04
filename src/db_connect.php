<?php


function connectDb ($dbname){
    $dbhost = 'mysql_db';
    $dbuser = 'root';
    $dbpass = 'root'; // juste en Dev
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