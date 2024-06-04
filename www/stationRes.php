

<?php 
    include("utils.php");
    loginFirst();
    include("includes/head.php");
    include("includes/navigation.php");
?>


<div class="page">
    <?php
        $marque = $_GET['marque'];
        $modele = $_GET['modele'];
        $req = "CALL GetStationParVehicule('$marque', '$modele');";
        include("table.php");
        $title = "Liste des stations ayant au moins une borne compatible avec " . $marque ." ". $modele;
        echo getTable("BORNES",$req, $title);
    ?>

    <div >
        <a class="button-table" href="station.php">Rechercher avec un autre vehicule</a>
    </div>
</div>

<?php include("includes/footer.php");?>


