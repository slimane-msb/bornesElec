

<?php include("includes/head.php");?>


<?php include("includes/navigation.php");?>

<div class="page">
    <?php
        $req = "SELECT * FROM bornesParDepartement";
        include("table.php");
        $title = "Numéro du département qui a le plus de bornes de recharge";
        echo getTable($dbname, $dbuser, $dbpass,$req, $title);
    ?>
</div>


<?php include("includes/footer.php");?>

