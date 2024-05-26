<?php
// Database connection
$servername = "localhost"; // Change this to your database server
$username = "phpmyadmin"; // Change this to your database username
$password = "g2CE32kcpOB3"; // Change this to your database password
$dbname = "USERS"; // Change this to your database name

$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Login form submitted
if ($_SERVER["REQUEST_METHOD"] == "POST" && isset($_POST['login'])) {
    $username = $_POST['username'];
    $password = $_POST['password'];

    // Check if credentials match in the database
    $sql = "SELECT * FROM users WHERE username='$username' AND password='$password'";
    $result = $conn->query($sql);

    if ($result->num_rows > 0) {
        // User exists, login successful
        echo "Login successful";
    } else {
        // Invalid credentials
        echo "Invalid username or password";
    }
}

$conn->close();
?>
