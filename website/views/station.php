

<?php 
    include("utils.php");
    loginFirst();
    include("includes/head.php");
    include("includes/navigation.php");
?>


<div class="page">
    <?php
        $req = "SELECT * FROM stationTesla";
        include("table.php");
        $title = "Liste des stations ayant au moins une borne compatible avec une Tesla modèle 3";
        echo getTable("BORNES2", $req, $title);
    ?>
</div>

<?php include("includes/footer.php");?>


