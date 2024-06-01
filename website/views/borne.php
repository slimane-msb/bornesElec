

<?php include("includes/head.php");?>


<?php include("includes/navigation.php");?>

<div class="page">
    <?php
        $req = "SELECT * FROM bornesStation";
        include("table.php");
        $title = "Liste des bornes de recharge de la station de numéro 100";
        echo getTable($dbname, $dbuser, $dbpass,$req, $title);
    ?>
</div>


<?php include("includes/footer.php");?>


