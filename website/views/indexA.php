<?php 
    include("utils.php");
    loginFirst();
    include("includes/head.php");
    include("includes/navigation.php");
?>

<div class="page">
    <?php
        $codePostal = $_GET['codePostal'];
        $prise = $_GET['prise'];
        $req = "CALL GetStationParCodePostalPrise('$codePostal', '$prise');";
        include("table.php");
        $title = "voici votre liste";
        echo getTable("BORNES2", $dbuser, $dbpass,$req, $title);
    ?>
</div>

<?php include("includes/footer.php");?>
