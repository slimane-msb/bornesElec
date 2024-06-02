<?php 
    include("utils.php");
    loginFirst();
    include("includes/head.php");
    include("includes/navigation.php");


    if ($_SERVER["REQUEST_METHOD"] == "GET") {
        $action = $_GET['formName'];
        if ($action == 'edit') {
            $idOperateur = $_GET['idOperateur'];
            $nom = $_GET['nom'];
            $adresse = $_GET['adresse'];
            $telephone = $_GET['telephone'];
            $tarifAbonne = $_GET['tarifAbonne'];
            $tarifNonAbonne = $_GET['tarifNonAbonne'];
            
            $req = "UPDATE operateurs SET ";
            $colors = array("red", "green", "blue", "yellow");

            foreach ($_GET as $colonne => $valeur) {
                if($valeur != "" && $colonne!="idOperateur" && $colonne!="formName" ){
                    $req .= " $colonne = '$valeur', ";
                }
            }
            $req = substr($req, 0, -2);

            
            $req .= " WHERE numeroId = $idOperateur";
            echo $req;
            include("db_connect.php");
            $conn = connectDb("BORNES2", $dbuser, $dbpass);
            
            echo $req;
            $inserted = $conn->query($req);
            header('Location: operateur.php');
        } elseif ($action == 'delete') {
            $idOperateur = $_GET['idOperateur'];

            $req = "DELETE FROM operateurs WHERE numeroId = $idOperateur";
            echo $req;
            include("db_connect.php");
            $conn = connectDb("BORNES2", $dbuser, $dbpass);
            
            echo $req;
            $inserted = $conn->query($req);
            header('Location: operateur.php');
        } 
    } 

    
    include("includes/footer.php");
 
 ?>
