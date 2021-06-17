  

<?php 
//select task of user
 include "connexionBase.php";
 //selectionner les taches d'une personne (password connue);
//*Need un json qui contient password or something unique for user */

 if($base)
        {
        echo "hello 1";
        $fileJson = file_get_contents('info_vehicule_task.json');
        $obj = json_decode($fileJson);

        //recuperation des data necessaires passxord de personne **** id_eta en cours****info task 
        //en plus change disponibility de la perssonne
        $LABEL_MACHINE=  $obj->LABEL_MACHINE; 
        $n= $obj->label; 
	    	$d= $obj-> dateDeb;
		    $e= $obj-> periode;
        $sql="select id_tache from tachescom where LABEL_TACHE='$n'";
        $resultat = mysqli_query($base,$sql);
        $id_tache = mysqli_fetch_array($resultat);

        ///seelct id vehicule

        $sql3="select  ID_MACHINE  from MACHINE	 where 	LABEL_MACHINE='$LABEL_MACHINE'";
        $resultat1 = mysqli_query($base,$sql3);
        $id_machine = mysqli_fetch_array($resultat1);


        $sql1 = "INSERT INTO necissitecomV  VALUES ($id_tache[0],$id_machine[0] ,'$d','$e')" ;
					if ($base->query($sql1) === TRUE) {


						echo "New Mach_task attribuer  successfully" ;
					} else {
						
	
						echo "Error tache : ttttttttt" . $sql1 . "<br>"   . $base->error; 
						 
					  }
	
                     
       
	 



        
         }


?>