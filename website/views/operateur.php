
<?php 
    include("utils.php");
    loginFirst();
    include("includes/head.php");
    include("includes/navigation.php");
?>



<div class="page pageAsRow">
    <div class="login-container">
        <h2>Modifier un operateur</h2>
        <form action="operateurEdit.php" name="editOperateur" method="GET" > 
            <input type="hidden" name="formName" value="edit"/>
            <input type="text" name="idOperateur" id="idOperateur" placeholder="Identifiant" required>
            <input type="text" name="nom" id="nom" placeholder="Nom" >
            <input type="text" name="adresse" id="adresse" placeholder="Adresse" >
            <input type="text" name="telephone" id="telephone" placeholder="Telephone" >
            <input type="text" name="tarifAbonne" id="tarifAbonne" placeholder="Tarif abonné" >
            <input type="text" name="tarifNonAbonne" id="tarifNonAbonne" placeholder="Tarif non abonné" >
            <button type="editOperateur">Editer Un Operateur</button>
        </form>
    </div>

    <div class="login-container">
        <h2>Supprimer un operateur</h2>
        <form action="operateurEdit.php" name="supprimerOperateur" method="GET" > 
            <input type="hidden" name="formName" value="delete"/>
            <input type="text" name="idOperateur" id="idOperateur" placeholder="Identifiant" required>
            <button type="supprimerOperateur">Supprimer Un Operateur</button>
        </form>
    </div>
</div>


<?php include("includes/footer.php");?>


