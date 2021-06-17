<?php
	   include "connexionBase.php";
	   if($base)
	   {
		   echo " connection";
		 

					//Recuperation des data from json

					//***********To DO************ menu.json est le fichier json recuperer from you 
					$fileJson = file_get_contents('php://input');
                     $obj = json_decode($fileJson);
					/*teste*/
  				//$jsonobj = '{ "email" : "aliali@gmail.com", "nom" : "sop","prenom" : "lolo","date" : "2010-12-12","password" : "alalalal","Unite" : "emp","sexe" :  0}';
                 // $obj = json_decode($jsonobj);

					 

					/*  taraitement  */

					$mail= $obj-> email;
					$n= $obj->nom;
					$p= $obj-> prenom;
					$d= $obj-> date;
					$e= $obj-> password;
					$unite= $obj-> Unite;
					$s= $obj-> sexe;
					//il faut garantir un moyen pour savoire de quel unite 
					//ajouter un liste 
					 
				 //selectionner id de unite correspondante
					$sql="select id_unite from unite where label_unite ='$unite'";
					$resultat = mysqli_query($base,$sql);
					$ligne = mysqli_fetch_array($resultat);

					 //insertion 
					 //problem dans autoincrement de PK je il faux les changer le type de ces PK en d'autre cmme password pare exple
					$sql1 = "INSERT INTO user  VALUES ('$mail','$e',$ligne[0],'$n','$p',0, '$s','$d')" ;
					if ($base->query($sql1) === TRUE) {


						echo "New record created successfully" ;
					} else {
						
	
						echo "Error: ttttttttt" . $sql1 . "<br>"   . $base->error; 
						 
					  }
	
	 
		}
			?>