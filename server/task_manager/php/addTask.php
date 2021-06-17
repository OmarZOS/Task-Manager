

<?php 
// TODO CHANGE PATH CONNECTION
 include "connexionBase.php";
  
 if($base)
        {
		 //TO DO CHANGE this part to receive json file

			/*$jsonobj ='[ { "email" : "salimsalim@gmail.com", "label" : "EQUIPE SPORTIF","dateDeb" : "2021-05-29 00:00:00","periode" : "30" },{ "email" : "omaromar@gmail.com", "label" : "EQUIPE SPORTIF","dateDeb" : "2021-05-29 00:00:00","periode" : "30" } ]';
			$obj = json_decode($jsonobj);*/
			$obj = json_decode(file_get_contents('php://input'), true);

			for ($i=0; $i < count($obj); $i++) { 
				 
					
			$email= $obj[$i]['email'];
			$n=$obj[$i]['label']; 
			$dateDeb=date("Y/m/d");
			$periode= $obj[$i]["periode"];
		
			$sql="select max(id_tache) from tachesdir where LABEL_TACHE='$n'";
			//echo $email;
			$resultat = mysqli_query($base,$sql);
			file_put_contents('php://stderr', $resultat);
			$id_task = mysqli_fetch_array($resultat)[0];

			$sql1 = "INSERT INTO necissitediru  VALUES ($id_task,'$email','$dateDeb','$periode')" ;
				if ($base->query($sql1) ) {
	
					$sql_update_disponibilty="UPDATE 'user' SET 'DISPONIBILITY'= 1 WHERE email='$email'";
					$base->query($sql_update_disponibilty);
					echo 'added';
					file_put_contents('php://stderr', print_r("added"));
					//echo "New tache attribuer  successfully" ;
				} else {
					file_put_contents('php://stderr',print_r("couldn't add task"));
					echo "prblm tache attribuer  ";
					echo "Error tache : "   . $base->error."<br>";//.$obj[0]["dateDeb"];; 
					
				}
			}
			

			
			// session_id($email);
			// session_start();
			if(isset($_SESSION['ip'])){
				file_put_contents('php://stderr', print_r("\nfound ip\n", TRUE));
			$fp = pfsockopen( $_SESSION['ip'], 9000, $errno, $errstr );

			if (!$fp)
			{
				echo "ERROR: $errno - $errstr<br />\n";
			}
			socket_set_timeout ($fp, 10);

			$write = fwrite( $fp,"task:$n");
			//$data .= fread($fp,9600);
			//echo "$data<br>";
			fclose($fp);
			}
			else
			file_put_contents('php://stderr', print_r("\n ip not found \n", TRUE));
					



		}



							
        
         


?>