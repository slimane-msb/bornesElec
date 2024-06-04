

<?php 
    include("utils.php");
    loginFirst();
    include("includes/head.php");
    include("includes/navigation.php");
?>


<div class="page">
    <?php
        $req = "SELECT * FROM bornesParDepartement";
        include("table.php");
        $title = "Numéro du département qui a le plus de bornes de recharge";
        echo getTable("BORNES",$req, $title);
    ?>
</div>


<?php include("includes/footer.php");?>


