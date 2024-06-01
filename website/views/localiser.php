

<?php include("includes/head.php");?>


<?php include("includes/navigation.php");?>

<div class="page">
    <?php
        $req = "SELECT * FROM stationIdf";
        include("table.php");
        $title = "Nombre de bornes par stations situées dans les départements Ile de France";
        echo getTable($dbname, $dbuser, $dbpass,$req, $title);
    ?>
</div>

<?php include("includes/footer.php");?>


