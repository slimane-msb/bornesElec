
<?php include("includes/head.php");?>


<?php include("includes/navigation.php");?>

<div class="page">
        
        <div class="login-container">
            <h2>Login</h2>
            <form name="login" action="login.php" method="POST" > 
                <input type="text" name="email" id="email" placeholder="Email" required>
                <input type="password" name="password" id="password" placeholder="Password" required>
                <button type="login">Login</button>
                <button type="register">Register</button>
            </form>
        </div>
    </div>
    

<?php include("includes/footer.php");?>

