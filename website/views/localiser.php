<?php 
    include("utils.php");
    loginFirst();
    include("includes/head.php");
    include("includes/navigation.php");
?>

<div class="page">
    <!-- <div class="table-container"> -->
        <?php
            $req = "SELECT * FROM stationIdf";
            include("table.php");
            $title = "Nombre de bornes par stations situées dans les départements Ile de France";
            echo getTable("BORNES2",$req, $title);
        ?>

        <div >
            <a class="button-table" href="localiser.php">Nouvelle Recherche</a>
        </div>
    <!-- </div> -->
</div>

<?php include("includes/footer.php");?>


