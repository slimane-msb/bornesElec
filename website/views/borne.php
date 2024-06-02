
<?php 
    include("utils.php");
    loginFirst();
    include("includes/head.php");
    include("includes/navigation.php");
    

    function creerBorne ($puissanceMax, $type){
        $req = "INSERT INTO bornes (puissanceMax, type) VALUES ($puissanceMax, '$type')";
        include("db_connect.php");
        $conn = connectDb("BORNES2", $dbuser, $dbpass);
        
        try{
            $res = $conn->query($req);
            return createLog(False,"Borne est crée avec succès");
        }catch(Exception $e){
            return createLog(True,"Veuillez entrer une puissance <400");
        }
    }
    

    if ($_SERVER["REQUEST_METHOD"] == "POST" ) {
        $insertionLog = creerBorne($_POST['puissanceMax'], $_POST['type']);

    }
?>



<div class="page">


    <div class="login-container">
        <h2>Ajouter une borne</h2>

        <?php showLog($insertionLog); ?>

        <form  name="recherche" method="POST" action="<?php echo $_SERVER['PHP_SELF']; ?>"> 
            <input type="text" name="puissanceMax" id="puissanceMax" placeholder="Puissance Max" required>
            <select class="choix-liste" name="type" id="type" required>
                <option value="lente">Lente</option>
                <option value="normale">Normale</option>
                <option value="rapide">Rapide</option>
            </select>
            <button type="AjouterBorne">Ajouter Une Borne</button>
        </form>
    </div>
    </div>


<?php include("includes/footer.php");?>


