  

<?php 
//select task of user
 include "connexionBase.php";
 //selectionner les taches d'une personne (password connue);
//*Need un json qui contient password or something unique for user */

 if($base)
        {
        echo "hello 1";
        $fileJson = file_get_contents('info_user_task.json');
        $obj = json_decode($fileJson);

        //recuperation des data necessaires passxord de personne **** id_eta en cours****info task 
        //en plus change disponibility de la perssonne
        $email=  $obj-> email
        $n= $obj->label; 
		    $d= $obj-> dateDeb;
		    $e= $obj-> periode;
        $sql="select id_tache from tachesdir where LABEL_TACHE='$n'";
        $resultat = mysqli_query($base,$sql);
        $id_tache = mysqli_fetch_array($resultat);


        $sql1 = "INSERT INTO necissitedirU  VALUES ($id_tache[0],'$email','$d','$e')" ;
					if ($base->query($sql1) === TRUE) {


						echo "New tache attribuer  successfully" ;
					} else {
						
	
						echo "Error tache : ttttttttt" . $sql1 . "<br>"   . $base->error; 
						 
					  }
	
                     
       
	 



        
         }


?>