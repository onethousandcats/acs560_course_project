<?php
	date_default_timezone_set('America/Fort_Wayne');
	define("HOST", "slypro.hostjava.net"); // The host you want to connect to.
	define("USER", "ACS560"); // The database username.
	define("PASSWORD", "acs560"); // The database password. 
	define("DATABASE", "NutritionFacts"); // The database name.
	define("PORT", 3306);
	$mysqli = new mysqli(HOST, USER, PASSWORD, DATABASE, PORT);
	$lowNumber = 0;
	$highNumber = 99999999;
	$constraintNames = array( 'calories', 'fat', 'cholesterol', 'sodium' );
	$first = true;
	$sqlQuery = "SELECT name, restaurant, calories, fat, cholesterol, sodium FROM Meal";
	foreach ($constraintNames as &$constraintName){
		$constraint = "";
		$lowBoundary = isset($_GET['low' . $constraintName]) ? $_GET['low' . $constraintName] : $lowNumber;
		$highBoundary = isset($_GET['high' . $constraintName]) ? $_GET['high' . $constraintName] : $highNumber;
		if ($first){
			$constraint = ' WHERE ';
			$first = false;
		}
		else{
			$constraint = ' AND ';
		}
		$constraint .= $constraintName . ' BETWEEN ' . $lowBoundary . ' AND ' . $highBoundary;
		$sqlQuery .= $constraint;
	}
	$objects = array();
	if ($result = $mysqli->query($sqlQuery)) {
	     $tempArray = array();
	     while($row = $result->fetch_object()) {
	             $tempArray = $row;
	             array_push($objects, $tempArray);
	     }
	     echo json_encode($objects);
	}
?>