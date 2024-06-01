
<?php

$email = $_POST['email'];

$password = $_POST['password'];

// Check if credentials match in the database
$sql = "SELECT * FROM users WHERE email='$email' AND password='$password'";

$res=$connection->query($sql);


$c1 = $res->fetch();

echo "$c1[2]";

echo "FIN";

$conn->close();




?>
