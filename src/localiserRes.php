<?php 
    include("utils.php");
    loginFirst();
    include("includes/head.php");
    include("includes/navigation.php");
?>

<div class="page">

    <?php
        $region = $_GET['region'];
        $req = "CALL GetStationParRegion('$region');";
        include("table.php");
        $title = "Nombre de bornes par stations situées dans la region " . $region;
        echo getTable("BORNES",$req, $title);
    ?>

        <div >
            <a class="button-table" href="localiser.php">Recherche ave une autre region</a>
        </div>
</div>




<?php include("includes/footer.php");?>


