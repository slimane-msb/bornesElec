
<?php 
    include("utils.php");
    loginFirst();
    include("includes/head.php");
    include("includes/navigation.php");

    function doesExistOperateur($key, $valeur,$conn){
        $req = "SELECT * FROM operateurs WHERE $key = '$valeur'";
        $result = $conn->query($req);
        if ($result->num_rows > 0) {
            return True;
        }else{
            return False;
        }

    }

    function ajoutOperateur($valeurArray, $conn){
        $nom = $valeurArray['nom'];
        if (!doesExistOperateur("nom", $nom,$conn )){
            $req = "INSERT INTO operateurs ";
            
            $nbElement = 0;
            $keys = "(";
            $values = "(";
            foreach ($valeurArray as $colonne => $valeur) {
                if($valeur != ""  && $colonne!="formName" ){
                    $nbElement++;
                    $keys .= $colonne . ",";
                    $values .= "'" . $valeur . "',";
                }
            }
            if($nbElement>0){
                $keys = substr($keys, 0, -1);
                $keys .=")";
                $values = substr($values, 0, -1);
                $values .=")";

                $req .= $keys . " VALUES " . $values;
                
                try{
                    $conn->query($req);
                    return createLog(False,"Ajouté avec succès"); 
                }catch(Exception $e){
                    return createLog(True,"Veuillez entrer le tarif comme aa.bb"); 
                }
            }else{
                return createLog(True,"Veuillez entrer un element a modifier"); 
            }
        }else{
            return createLog(True,"Operateur deja existant");
        }

    }


    function editOperateur($valeurArray, $conn){
        $idOperateur = $valeurArray['idOperateur'];
        if (doesExistOperateur("numeroId",$idOperateur,$conn )){
            $req = "UPDATE operateurs SET ";
            
            $nbElement = 0;
            foreach ($valeurArray as $colonne => $valeur) {
                if($valeur != "" && $colonne!="idOperateur" && $colonne!="formName" ){
                    $nbElement++;
                    $req .= " $colonne = '$valeur', ";
                }
            }
            $req = substr($req, 0, -2);
            $req .= " WHERE numeroId = $idOperateur";
            
            if($nbElement>0){
                $conn->query($req);
                return createLog(False,"Modifié avec succès"); 
            }else{
                return createLog(True,"Veuillez entrer un element a modifier"); 
            }
        }else{
            return createLog(True,"Operateur n'existe pas");
        }

    }

    function deleteOperateur($idOperateur, $conn){
        if (doesExistOperateur("numeroId",$idOperateur, $conn)){
            $req = "DELETE FROM operateurs WHERE numeroId = $idOperateur";
            $conn->query($req);
            return createLog(False,"Supprimé avec succès"); 
        }else{
            return createLog(True,"Operateur n'existe pas");
        }
        
    }


    if ($_SERVER["REQUEST_METHOD"] == "GET") {
        include("db_connect.php");
        $conn = connectDb("BORNES2", $dbuser, $dbpass);

        if ($_GET['formName'] == 'edit') {
            $editLog = editOperateur($_GET, $conn);
        } elseif ($_GET['formName'] == 'delete') {
            $deleteLog = deleteOperateur($_GET['idOperateur'], $conn );
        } elseif  ($_GET['formName'] == 'ajout'){
            $ajoutLog = ajoutOperateur($_GET, $conn );
        }
        disconnectDb($conn);
    } 

?>



<div class="page pageAsRow">
    <div class="login-container">
        <h2>Modifier un operateur</h2>

        <?php showLog($editLog); ?>

        <form name="editOperateur" method="GET" action="<?php echo $_SERVER['PHP_SELF']; ?>"> 
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

        <?php showLog($deleteLog); ?>

        <form name="supprimerOperateur" method="GET" action="<?php echo $_SERVER['PHP_SELF']; ?>" > 
            <input type="hidden" name="formName" value="delete"/>
            <input type="text" name="idOperateur" id="idOperateur" placeholder="Identifiant" required>
            <button type="supprimerOperateur">Supprimer Un Operateur</button>
        </form>
    </div>

    <div class="login-container">
        <h2>Ajouter un operateur</h2>

        <?php showLog($ajoutLog); ?>

        <form name="ajoutOperateur" method="GET" action="<?php echo $_SERVER['PHP_SELF']; ?>"> 
            <input type="hidden" name="formName" value="ajout"/>
            <input type="text" name="nom" id="nom" placeholder="Nom" >
            <input type="text" name="adresse" id="adresse" placeholder="Adresse" >
            <input type="text" name="telephone" id="telephone" placeholder="Telephone" >
            <input type="text" name="tarifAbonne" id="tarifAbonne" placeholder="Tarif abonné" >
            <input type="text" name="tarifNonAbonne" id="tarifNonAbonne" placeholder="Tarif non abonné" >
            <button type="ajoutOperateur">Ajouter Un Operateur</button>
        </form>
    </div>


</div>


<?php include("includes/footer.php");?>


