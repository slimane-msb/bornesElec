

<?php 
    include("includes/head.php");
    include("includes/navigation.php");
    
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        include("utils.php");
        register($_POST['email'], $_POST['name'],  $_POST['password']);
    }
?>  

<div class="page">
        <div class="login-container">
            <h2>Register</h2>
            <form name="register" method="POST" >
                <input type="text" id="email"name="email" placeholder="Email" required>
                <input type="text" id="name" name="name" placeholder="Name" required>
                <input type="password" id="password" name="password" placeholder="Password" required>
                <button type="register">Register</button>
            </form>
        </div>
    </div>

<?php include("includes/footer.php");?>


