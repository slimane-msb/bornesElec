

<?php 
    include("utils.php");
    loginFirst();
    include("includes/head.php");
    include("includes/navigation.php");
?>


<div class="page">
    <div class="login-container">
        <h2>Trouver un vehicule par puissance</h2>
        <form action="vehiculeRes.php" name="recherche" method="GET" > 
            <input type="text" name="puissanceMoteur" id="puissanceMoteur" placeholder="Puissance moteur minimum" required>
            <input type="text" name="puissanceBatterie" id="puissanceBatterie" placeholder="Puissance batterie minimum" required>
            <button type="rechercher">Rechercher</button>
        </form>
    </div>
</div>
    


<?php include("includes/footer.php");?>


