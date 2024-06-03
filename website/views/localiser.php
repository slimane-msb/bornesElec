<?php 
    include("utils.php");
    loginFirst();
    include("includes/head.php");
    include("includes/navigation.php");
?>

<div class="page">
    <div class="login-container">
        <h2>Trouver le nombre de bornes par stations situées par départements</h2>
        <form action="localiser Res.php" name="recherche" method="GET" > 
            <input type="text" name="departement" id="departement" placeholder="Département" required>
            <button type="rechercher">Rechercher</button>
        </form>
    </div>
</div>

<?php include("includes/footer.php");?>


