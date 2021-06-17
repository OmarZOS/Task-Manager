  

<?php 
//select task of user
 include "connexionBase.php";
 //selectionner les taches d'une personne (password connue);
//*Need un json qui contient password or something unique for user */

 if($base)
      {
        echo "hello 1";
        $fileJson = file_get_contents('php://input');
        $obj = json_decode($fileJson);

        //recuperation des data necessaires passxord de personne **** id_eta en cours****info task 
        //en plus change disponibility de la perssonne
        $email=  $obj->email; 
        $n= $obj->label;
        $p= $obj->description;
        $d= $obj->date;
        $e= $obj->periode;
       /* $sql="select id_etat from en_cours where lab_en_cours ='en_cours'";
        $resultat = mysqli_query($base,$sql);
        $etat_cours = mysqli_fetch_array($resultat);*/


        $sql1 = "INSERT INTO tachescom  VALUES ($email,'en_cours','$n','$p','$d','$e')" ;
					if ($base->query($sql1) === TRUE) {


						echo "New tache created successfully" ;
					} else {
						
	
						echo "Error tache : ttttttttt" . $sql1 . "<br>"   . $base->error; 
						 
					  }
	
                     
       
	 



        
         }


?>