
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
            <select class="choix-liste" name="prise" id="prise" required>
                <option value="CSS1">CSS1</option>
                <option value="CSS3">CSS3</option>
                <option value="CHAMO">CHAMO</option>
                <option value="E">E</option>
                <option value="T2">T2</option>
            </select>
            <button type="rechercher">Rechercher</button>
        </form>
    </div>
</div>
    

<?php include("includes/footer.php");?>

