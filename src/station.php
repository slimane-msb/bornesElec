<?php 
    include("utils.php");
    loginFirst();
    include("includes/head.php");
    include("includes/navigation.php");
?>


<div class="page">
    <div class="login-container">
        <h2>Trouver une station pour un vehicule</h2>
        <form action="stationRes.php" name="recherche" method="GET" > 
            <input type="text" name="marque" id="marque" placeholder="Marque" required>
            <input type="text" name="modele" id="modele" placeholder="Modele" required>
            <button type="rechercher">Rechercher</button>
        </form>
    </div>
</div>

<?php include("includes/footer.php");?>


