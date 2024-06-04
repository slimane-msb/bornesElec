
<?php 
    include("utils.php");
    loginFirst();
    include("includes/head.php");
    include("includes/navigation.php");

    $insertionStationLog= null;
    $insertionBorneLog =null;


    function creerBorne ($puissanceMax, $type, $station, $conn){
        $req = "INSERT INTO bornes (puissanceMax, type) VALUES ($puissanceMax, '$type')";
        try{
            $res = $conn->query($req);
            $idBorne=$conn->insert_id;
            $reqStationBorne = "INSERT INTO stationBorne (numeroIdStation, numeroIdBorne) VALUES ($station, $idBorne)";
            $conn->query($reqStationBorne);
            return createLog(False,"Borne est crée avec succès");
        }catch(Exception $e){
            return createLog(True,"Veuillez entrer une puissance <400");
        }
    }

    function creerStation($valeurArray, $conn){

            $req = "INSERT INTO stations ";
            
            $keys = "(";
            $values = "(";
            foreach ($valeurArray as $colonne => $valeur) {
                if($valeur != ""  && $colonne!="formName" ){
                    $keys .= $colonne . ",";
                    $values .= "'" . $valeur . "',";
                }
            }
            
            $keys = substr($keys, 0, -1);
            $keys .=")";
            $values = substr($values, 0, -1);
            $values .=")";

            $req .= $keys . " VALUES " . $values;
            
            try{
                $conn->query($req);
                return createLog(False,"Ajouté avec succès"); 
            }catch(Exception $e){
                return createLog(True,"Veuillez entrer le bon format pour les valeurs "); 
            }
            
    }


    function getStationsIds( ){
        try{        
            $req = "SELECT numeroId FROM stations";
            $conn = connectDb("BORNES");
            $result = $conn->query($req);
            $res = array();
            if ($result->num_rows > 0) {
                while ($ligne = $result->fetch_assoc()) {
                    foreach ($ligne as $value) {
                        $res[] = $value;
                    }
                }
            }
            return $res;
        }catch(Exception $e){
            return array();
        }        
    }

    function getStationId( ){
        $stationIds = getStationsIds( );
        $res = "";
        foreach ($stationIds as $stationId){
            $res .= "<option value='$stationId'>$stationId</option>";
        }
        return $res;
    }

    



    if ($_SERVER["REQUEST_METHOD"] == "GET") {
        include("db_connect.php");
        $conn = connectDb("BORNES");

        if(isset($_GET['formName'] )){
            $action = $_GET['formName'] ;
        }else{
            $action = null;
        }

        if ($action == 'ajoutBorne') {
            $insertionBorneLog = creerBorne($_GET['puissanceMax'], $_GET['type'], $_GET['station'],$conn);
        } elseif ($action == 'ajoutStation') {
            $insertionStationLog = creerStation($_GET, $conn );
        }
        disconnectDb($conn);
    } 

    
?>



<div class="page pageAsRow">

<div class="login-container">
        <h2>Ajouter une station</h2>

        <?php showLog($insertionStationLog); ?>

        <form  name="recherche" method="GET" action="<?php echo $_SERVER['PHP_SELF']; ?>"> 
            <input type="hidden" name="formName" value="ajoutStation"/>
            <input type="number" name="codePostal" id="codePostal" placeholder="Code Postal" required>
            <input type="number"  step="0.01" name="distanceMinARoute" id="distanceMinARoute" placeholder="Distance Min AutoRoute">
            <input type="number"  step="0.01" name="latitude" id="latitude" placeholder="Latitude">
            <input type="number"  step="0.01" name="longitude" id="longitude" placeholder="Longitude">
            <input type="text"  onfocus="this.type='time';this.value='08:00'" name="ouverture" id="ouverture" placeholder="Ouverture">
            <input type="text"  onfocus="this.type='time';this.value='22:00'" name="fermeture" id="fermeture" placeholder="Fermeture">
            <button type="AjouterBorne">Ajouter Une Station</button>
        </form>
    </div>

    <div class="login-container">
        <h2>Ajouter une borne</h2>


        <?php showLog($insertionBorneLog); ?>

        <form  name="recherche" method="GET" action="<?php echo $_SERVER['PHP_SELF']; ?>"> 
            <input type="hidden" name="formName" value="ajoutBorne"/>
            <input type="text" name="puissanceMax" id="puissanceMax" placeholder="Puissance Max" required>
            <select class="choix-liste" name="type" id="type" required>
                <option value="">Choisir un type</option>
                <option value="lente">Lente</option>
                <option value="normale">Normale</option>
                <option value="rapide">Rapide</option>
            </select>
            <select class="choix-liste" name="station" id="station" required>
                <option value="">Choisir une station</option>
                <?php
                    echo getStationId();
                ?>
            </select>
            <button type="AjouterBorne">Ajouter Une Borne</button>
        </form>



        
    </div>
	
    



    

</div>


<?php include("includes/footer.php");?>


