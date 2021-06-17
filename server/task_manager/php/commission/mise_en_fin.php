  

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
        
        $n= $obj->ID_TACHE;
        
        $lab_fin='fin';
		 
        /* $sql1="select id_fin from  fin where lab_fin='$lab_fin'";
        $resultat = mysqli_query($base,$sql);
        $id_fin = mysqli_fetch_array($resultat);
        */
		 
       
        $sql1="UPDATE tachesdir SET ID_ETAT = 'fin' where id_tache='$n'";
        $sql2="UPDATE tachescom SET ID_ETAT = 'fin' where id_tache='$n'";        
        $base->query($sql2);

       if ($base->query($sql1) === TRUE || $base->query($sql2) === TRUE) {


						echo "ended" ;
					} else {
						
	
						echo "Error tache sql : " . $sql1 . " \nbase : "   . $base->error; 
						 
					  }
	
                     
       
	 



        
         }


?>