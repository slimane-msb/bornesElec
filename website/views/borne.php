
<?php 
    include("utils.php");
    loginFirst();
    include("includes/head.php");
    include("includes/navigation.php");
?>



<div class="page">
    <?php
        $req = "SELECT * FROM bornesStation";
        include("table.php");
        $title = "Liste des bornes de recharge de la station de numéro 100";
        echo getTable($dbname, $dbuser, $dbpass,$req, $title);
    ?>

    <div class="login-container">
        <h2>Ajouter une borne</h2>
        <form action="borneAjout.php" name="recherche" method="GET" > 
            <input type="text" name="puissanceMax" id="puissanceMax" placeholder="Puissance Max" required>
            <input type="text" name="type" id="type" placeholder="Type" required>
            <button type="AjouterBorne">Ajouter Une Borne</button>
        </form>
    </div>
    </div>


<?php include("includes/footer.php");?>


