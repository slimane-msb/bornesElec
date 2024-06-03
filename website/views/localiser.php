<?php 
    include("utils.php");
    loginFirst();
    include("includes/head.php");
    include("includes/navigation.php");
    include("db_connect.php");
    
    function getRegions(){
        try{        
            $req = "SELECT DISTINCT region FROM departements";
            $conn = connectDb("BORNES2");
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
    
    function getRegionsHtml (){
        $regions = getRegions( );
        $res = "";
        foreach ($regions as $region){
            $res .= "<option value='$region'>$region</option>";
        }
        return $res;
    }
?>

<div class="page">
    <div class="login-container">
        <h2>Trouver les stations par regions</h2>
        <form action="localiserRes.php" name="recherche" method="GET" > 
            <select class="choix-liste" name="region" id="region" required>
                <option value="">Choisir une region</option>
                <?php
                    echo getRegionsHtml();
                ?>
            </select>
            <button type="rechercher">Rechercher</button>
        </form>
    </div>
</div>

<?php include("includes/footer.php");?>


