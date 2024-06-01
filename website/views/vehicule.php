

<?php 
    include("utils.php");
    loginFirst();
    include("includes/head.php");
    include("includes/navigation.php");
?>


<div class="page">
    <?php
        $req = "SELECT * FROM vehiculesBatterieSup";
        include("table.php");
        $title = "Liste des véhicules ayant une batterie de puissance supérieure à 50 KW";
        echo getTable($dbname, $dbuser, $dbpass,$req, $title);
    ?>
</div>

    


<?php include("includes/footer.php");?>


