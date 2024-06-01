<?php
$dbnode='localhost'; 
$dbname='USERS'; 
$dbuser='phpmyadmin'; 
$dbpasswd='g2CE32kcpOB3'; 
try {
    $connection = new PDO('mysql:host=localhost;dbname=USERS', $dbuser, $dbpasswd); 
}catch (PDOException $e) { 
	echo $e->getMessage();
}
?>