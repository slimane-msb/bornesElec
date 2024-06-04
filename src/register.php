<?php 
    
    include("utils.php");
    $registerLog=NULL;
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        $registerLog = register($_POST['email'], $_POST['name'],  $_POST['password']);
    }

    include("includes/head.php");
    include("includes/navigation.php");

?>  

<div class="page">
        <div class="login-container">
            <h2>Register</h2>
            <?php showLog($registerLog); ?>
            <form name="register" method="POST" >
                <input type="text" id="email"name="email" placeholder="Email" required>
                <input type="text" id="name" name="name" placeholder="Name" required>
                <input type="password" id="password" name="password" placeholder="Password" required>
                <button type="register">Register</button>
            </form>
            <div class="besoinCompte">
                Vous avez deja un compte? <a href="login.php">Login</a>
            </div>
        </div>
        
    </div>

<?php include("includes/footer.php");?>

