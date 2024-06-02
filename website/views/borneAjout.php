<?php 
    include("utils.php");
    loginFirst();
    include("includes/head.php");
    include("includes/navigation.php");


    $puissanceMax = $_GET['puissanceMax'];
    $type = $_GET['type'];

    $req = "INSERT INTO bornes (puissanceMax, type) VALUES ($puissanceMax, '$type')";
    include("db_connect.php");
    $conn = connectDb("BORNES2", $dbuser, $dbpass);
    
    echo $req;
    $inserted = $conn->query($req);
    if ($inserted){
        header('Location: borne.php'); 
    }else{
        header('Location: index.php');
    }

    
    include("includes/footer.php");
 
 ?>
