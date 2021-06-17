  

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
        
        $n= $obj->label_tach;
        $lab_encours='en_cours';
		 
       /* $sql1="select id_encours from  en_cours where lab_en_cours='$lab_encours'";
        $resultat = mysqli_query($base,$sql);
        $id_encours = mysqli_fetch_array($resultat);
*/
        $sql="UPDATE tachesdir SET ID_ETAT ='en_cours'  where LABEL_TACHE='$n'";
        

       if ($base->query($sql) === TRUE) {


						echo " update  successfully" ;
					} else {
						
	
						echo "Error tache : ttttttttt" . $sql1 . "<br>"   . $base->error; 
						 
					  }
	
                     
       
	 



        
         }


?>