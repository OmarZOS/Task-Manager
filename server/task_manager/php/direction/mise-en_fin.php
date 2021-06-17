  

<?php 
//select task of user
 include "connexionBase.php";
 //selectionner les taches d'une personne (password connue);
//*Need un json qui contient password or something unique for user */

 if($base)
        {
       // echo "hello 1";
        $fileJson = file_get_contents('info_user_task.json');
        $obj = json_decode($fileJson);

        //recuperation des  id tache pour la mise en pause
        
        $n= $obj->label_tach;
        
        $lab_fin='fin';
		 
     /*   $sql1="select id_fin from  fin where lab_fin='$lab_fin'";
        $resultat = mysqli_query($base,$sql);
        $id_fin = mysqli_fetch_array($resultat);
*/
		 
        $sql="UPDATE tachesdir SET ID_ETAT = 'fin' where LABEL_TACHE='$n'";
        

       if ($base->query($sql) === TRUE) {


						echo " mise en fin  successfully" ;
					} else {
						
	
						echo "Error tache : ttttttttt" . $sql1 . "<br>"   . $base->error; 
						 
					  }
	
                     
       
	 



        
         }


?>