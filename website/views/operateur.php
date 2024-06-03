
<?php 
    include("utils.php");
    loginFirst();
    include("includes/head.php");
    include("includes/navigation.php");

    $deleteLog=NULL;
    $ajoutLog=NULL;
    $editLog=NULL;

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
                    return createLog(True,"Veuillez entrer le tarif comme un nombre"); 
                }
            }else{
                return createLog(True,"Veuillez entrer un element a modifier"); 
            }
        }else{
            return createLog(True,"Operateur deja existant");
        }

    }


    function editOperateur($valeurArray, $conn){
        $idOperateurJson = $valeurArray['idOperateur'];
        $idOperateur = json_decode($idOperateurJson, true);
        $idOperateur = $idOperateur['numeroId'];
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

    function getOperateursIdName( ){
        try{        
            $req = "SELECT numeroId,nom FROM operateurs";
            $conn = connectDb("BORNES2");
            $result = $conn->query($req);
            $res = array();
            if ($result->num_rows > 0) {
                while ($ligne = $result->fetch_assoc()) {
                    $res[] = $ligne;
                }
            }
            return $res;
        }catch(Exception $e){
            return array();
        }        
    }

    

    function getOperateurs( ){
        try{        
            $req = "SELECT * FROM operateurs";
            $conn = connectDb("BORNES2");
            $result = $conn->query($req);
            $res = array();
            if ($result->num_rows > 0) {
                while ($ligne = $result->fetch_assoc()) {
                    $res[] = $ligne;
                }
            }
            return $res;
        }catch(Exception $e){
            return array();
        }        
    }

    function getOperateursHtml( ){
        $operateurs = getOperateursIdName( );
        $res = "";
        foreach ($operateurs as $operateur){
            $id = $operateur['numeroId'];
            $nom = $operateur['nom'];
            $res .= "<option value='$id'>$id:$nom</option>";
        }
        return $res;
    }



    function getOperateursHtmlJson(){
        $operateurs = getOperateurs( );
        $res = "";
        foreach ($operateurs as $operateur){
            $json = htmlspecialchars(json_encode($operateur));
            $id = $operateur['numeroId'];
            $nom = $operateur['nom'];
            $res .= "<option value='$json'>$id:$nom</option>";
        }
        return $res;
    }



    if ($_SERVER["REQUEST_METHOD"] == "GET") {
        include("db_connect.php");
        $conn = connectDb("BORNES2");

        if(isset($_GET['formName'])){
            $action = $_GET['formName'];
        }else{
            $action = NULL;
        }
        
        if ($action == 'edit') {
            $editLog = editOperateur($_GET, $conn);
        } elseif ($action == 'delete') {
            $deleteLog = deleteOperateur($_GET['idOperateur'], $conn );
        } elseif  ($action == 'ajout'){
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
            <select class="choix-liste" name="idOperateur" id="idOperateurJson" onchange="updateForm()" required>
                <option value="">Choisir un operateur</option>
                <?php
                    echo getOperateursHtmlJson();
                ?>
            </select>
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
            <select class="choix-liste" name="idOperateur" id="idOperateur" required>
                <option value="">Choisir un operateur</option>
                <?php
                    echo getOperateursHtml();
                ?>
            </select>
            <button type="supprimerOperateur">Supprimer Un Operateur</button>
        </form>
    </div>

    <div class="login-container">
        <h2>Ajouter un operateur</h2>

        <?php showLog($ajoutLog); ?>

        <form name="ajoutOperateur" method="GET" action="<?php echo $_SERVER['PHP_SELF']; ?>"> 
            <input type="hidden" name="formName" value="ajout"/>
            <input type="text" name="nom" id="nom" placeholder="Nom" required>
            <input type="text" name="adresse" id="adresse" placeholder="Adresse" >
            <input type="text" name="telephone" id="telephone" placeholder="Telephone" >
            <input type="text" name="tarifAbonne" id="tarifAbonne" placeholder="Tarif abonné" >
            <input type="text" name="tarifNonAbonne" id="tarifNonAbonne" placeholder="Tarif non abonné" >
            <button type="ajoutOperateur">Ajouter Un Operateur</button>
        </form>
    </div>


</div>


<?php include("includes/footer.php");?>


