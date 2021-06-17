   

<?php 
//select task of user
 include "connexionBase.php";
 //selectionner les taches d'une personne (password connue);
//*Need un json qui contient password or something unique for user */

 if($base)
        {
       
        //echo "hello 1";
        $data = json_decode(file_get_contents('php://input'), true);

        //recuperation des data necessaires passxord de personne **** id_eta en cours****info task 
        //en plus change disponibility de la perssonne
        //echo $email;
       //  echo "data received : ".$data["email"]."\n";
        $email=  isset($data["email"])? $data["email"] : ''; 
        $n= isset($data["label"])? $data["label"] : '';
        $p= isset($data["description"])? $data["description"] : '';
        $e= isset($data["periode"])? $data["periode"] : '2';
        //$d= $data-> date;
       /* $sql="select id_etat from en_cours where lab_en_cours ='en_cours'";
        $resultat = mysqli_query($base,$sql);
        $etat_cours = mysqli_fetch_array($resultat);*/
       $d =date('Y-m-d H:i:s');

        $sql1 = "INSERT INTO tachesdir (ID_ETAT,LABEL_TACHE,DESCRIPTION_TACHE,DATE_DEBETACHE,PERIODE) VALUES ('encours','$n','$p','".$d."','$e')" ;
					if ($base->query($sql1) === TRUE) {
						echo "added" ;
					} else {
						echo "Error tache : " . $sql1 . "\n"   . $base->error; 
					}
	
                     
       
	 



        
       }


?>