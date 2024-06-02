<?php

include("db_connect.php");


function getTable($dbname, $dbuser, $dbpass, $req, $titre){
    
    $conn = connectDb($dbname, $dbuser, $dbpass);
    

    
    
    $result = $conn->query($req);


    

    $res .= "<H2>" . $titre . "</H2> <br>";

    if ($result->num_rows > 0) {
        $colonnes = $result->fetch_fields();
        
        $res .= "<table>";
        $res .= "<tr>";
        
        foreach ($colonnes as $colonne) {
            $res .= "<th>" . htmlspecialchars($colonne->name) . "</th>";
        }
        
        $res .= "</tr>";
    
        
        while ($ligne = $result->fetch_assoc()) {
            $res .= "<tr>";
            foreach ($ligne as $value) {
                $res .= "<td>" . htmlspecialchars($value) . "</td>";
            }
            $res .= "</tr>";
        }
        $res .= "</table>";
    } else {
        $res .= "0 résultats";
    }

  

    disconnectDb($conn);
    

    return $res; 
}

?>