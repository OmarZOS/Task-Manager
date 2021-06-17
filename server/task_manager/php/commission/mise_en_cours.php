  

<?php 
//select task of user
 include "../connexionBase.php";
 //selectionner les taches d'une personne (password connue);
//*Need un json qui contient password or something unique for user */

 if($base)
        {
        // echo "hello 1";
        $fileJson = file_get_contents('php://input');
        $obj = json_decode($fileJson);

        //recuperation des  id tache pour la mise en pause
        
        $n= $obj->ID; 
        // $lab_enpause='en_cours';
		 /*
        $sql1="select 	ID_PAUSE from  PAUSE where lab_pause='$lab_enpause'";
        $resultat = mysqli_query($base,$sql);
        $id_fin = mysqli_fetch_array($resultat);*/
 


        $sql1="UPDATE tachesdir SET ID_ETAT = 'encours' where ID_TACHE='$n'";
        $sql2="UPDATE tachescom SET ID_ETAT = 'encours' where ID_TACHE='$n'";        
        $base->query($sql2);
       if ($base->query($sql1) === TRUE || $base->query($sql2) === TRUE) {
          
        echo $sql1;
        echo $sql2;

						echo "encours" ;
					} else {
						
	
						echo "Error mise en cours : " . $sql1 . "<br>"   . $base->error; 
						 
          }
	
                     
       
	 



        
         }


?>