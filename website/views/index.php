
<?php 
    include("utils.php");
    loginFirst();
    include("includes/head.php");
    include("includes/navigation.php");
    $isSubmitted = False;
    
?>



<div class="page">
    <div class="login-container">
        <h2>Trouver une station</h2>
        <form action="indexA.php" name="recherche" method="GET" > 
            <input type="text" name="codePostal" id="CodePostal" placeholder="Code Postal" required>
            <input type="text" name="prise" id="prise" placeholder="Prise" required>
            <button type="rechercher">Rechercher</button>
        </form>
    </div>
</div>
    

<?php include("includes/footer.php");?>

