<?php
// Database connection
$servername = "localhost"; // Change this to your database server
$username = "your_username"; // Change this to your database username
$password = "your_password"; // Change this to your database password
$dbname = "your_database"; // Change this to your database name

$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Registration form submitted
if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['register'])) {
    $fullname = $_POST['fullname'];
    $username = $_POST['username'];
    $password = $_POST['password'];

    // Insert data into database
    $sql = "INSERT INTO users (fullname, username, password) VALUES ('$fullname', '$username', '$password')";
    
    if ($conn->query($sql) === TRUE) {
        echo "Registration successful";
    } else {
        echo "Error: " . $sql . "<br>" . $conn->error;
    }
}

$conn->close();
?>