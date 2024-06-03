<?php
    if (isset($_COOKIE['name'])) {
        $loginMenu = strtoupper($_COOKIE['name']) ;
        $loginLink = "profil.php";
        $registerMenu = "LOGOUT";
        $registerLink = "logout.php"; 
    }else{
        $loginMenu = "CONNEXION";
        $loginLink = "login.php";
        $registerMenu = "INSCRIPTION";
        $registerLink = "register.php";
    }

?>


<header>
    <nav>
        <ul>
            <li><a href="index.php">HOME</a></li>
            <li><a href="vehicule.php">VEHICULE</a></li>
            <li><a href="borne.php">BORNE</a></li>
            <li><a href="operateur.php">OPERATEUR</a></li>
            <li><a href="station.php">TESLA</a></li>
            <li><a href="localiser.php">LOCALISER</a></li>
            <li><a href="stats.php">STATS</a></li>
            <li><a href=<?php print $registerLink;?>><?php print $registerMenu;?></a></li>
            <li><a href=<?php print $loginLink;?>><?php print $loginMenu;?></a></li>
        </ul>
    </nav>
</header>
