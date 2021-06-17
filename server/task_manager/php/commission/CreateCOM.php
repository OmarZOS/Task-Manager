<<?php

include('../connexionBase.php');
	
	
	
	
	//$jsonobj = '{ "email" : "aliali@gmail.com", "label_unite" : "EMP","label_comission" : "DCC"  }';

	$obj = json_decode(file_get_contents('php://input'), true);
	$email=  $obj->email; 
	$label_unite= $obj->label_unite; 				
	$label_comission= $obj-> label_comission;
	//$periode= $obj-> periode;
	$sql="select id_unite from unite where LABEL_UNITE='$label_unite'";
	$resultat = mysqli_query($base,$sql);
	$id_unite = mysqli_fetch_array($resultat);
	if ($resultat !=false) {
	   $sql="INSERT INTO  commission  VALUES (58,$id_unite[0],'$email','$label_comission' )";
	   if($base->query($sql) )
	   {
		  echo "gut";


	   }
	   else{
		   echo"nichts";
	   }
	}





?>
