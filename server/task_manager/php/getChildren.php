<?php
	   include "connexionBase.php";

       if($base)
       {
            

        $data = json_decode(file_get_contents('php://input'), true);
        $email=$data["email"];

        $requet="SELECT USE_ID_USER FROM chef where ID_USER = '".$email."'";
        
        if(!empty($data["email"])){ //if is requesting only one user data..

            $result= mysqli_query($base,$requet);
            $user_data=array();
        
        
            if($result == false ){
                    // echo "<p>pas possible d'executer la requete SQL</p>" ;
                file_put_contents('php://stderr', print_r("pas possible d'executer la requete SQL", TRUE));
                echo $file_user;
            }
            else{
    
                while($row =mysqli_fetch_array($result)){
                    $user_data[]=array(                       
                        "email"=>$row[0],
                        );
                } 
                $file_user= json_encode($user_data);
                // file_put_contents('php://stderr', print_r("json encoded successfully for : ".$file_user, TRUE));
                
                echo $file_user;
    
            }

                 


        }
}
?>








