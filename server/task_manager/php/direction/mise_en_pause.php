  

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

        //recuperation des  id tache pour la mise en pause
        
        $n= $obj->label; 
        $lab_enpause='en_pause';
		 /*
        $sql1="select 	ID_PAUSE from  PAUSE where lab_pause='$lab_enpause'";
        $resultat = mysqli_query($base,$sql);
        $id_fin = mysqli_fetch_array($resultat);*/
 


        $sql="UPDATE tachedirs SET ID_ETAT = 'en_pause' where LABEL_TACHE='$n'";
        

       if ($base->query($sql) === TRUE) {


						echo " update  successfully" ;
					} else {
						
	
						echo "Error tache : ttttttttt" . $sql1 . "<br>"   . $base->error; 
						 
					  }
	
                     
       
	 



        
         }


?>