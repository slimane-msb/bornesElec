<?php 
    include("utils.php");
    loginFirst();
    include("includes/head.php");
    include("includes/navigation.php");
?>




<div class="page">
    <?php
        $puissanceMoteur = $_GET['puissanceMoteur'];
        $puissanceBatterie = $_GET['puissanceBatterie'];
        $req = "CALL GetVehiculeParPuissanceMin('$puissanceMoteur', '$puissanceBatterie');";
        include("table.php");
        $title = "Liste des véhicules ayant une batterie de puissance supérieure à " . $puissanceBatterie ." KW et de moteur supérieure à  ". $puissanceMoteur . " Kw";
        echo getTable("BORNES",$req, $title);
    ?>

    <div >
        <a class="button-table" href="vehicule.php">Rechercher avec une autre puissance</a>
    </div>
</div>


<?php include("includes/footer.php");?>


