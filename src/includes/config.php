<?php
	switch ($_SERVER["SCRIPT_NAME"]) {
		case "/bornesElec/website/views/index.php":
			$CURRENT_PAGE = "Index"; 
			$PAGE_TITLE = "BDD FIPA";
			break;
		default:
			$path = $_SERVER["SCRIPT_NAME"] ;
			$page = basename($path, ".php");
			$CURRENT_PAGE = $page ;
			$PAGE_TITLE = $page . " | BDD FIPA!";
	}
?>