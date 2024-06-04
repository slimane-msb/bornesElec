<?php 

    include("utils.php");
    $loginLog=NULL;
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        $loginLog = login($_POST['email'], $_POST['password']);
    }
    


    include("includes/head.php");
    include("includes/navigation.php");
    


    
    
    
    
?>

<div class="page">
    <div class="login-container">
        <h2>Login</h2>

        <?php showLog($loginLog); ?>
        <form name="login" method="POST" > 

        <!-- <form action="loginA.php" name="login" method="POST" >  -->
            <input type="text" name="email" id="email" placeholder="Email" required>
            <input type="password" name="password" id="password" placeholder="Password" required>
            <button type="login">Login</button>
        </form>
        <div class="besoinCompte">
             Besoin d'un compte? <a href="register.php">Sign Up</a>
        </div>
    </div>
    
</div>
    

<?php include("includes/footer.php");?>

