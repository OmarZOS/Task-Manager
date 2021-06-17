<?php

// Allow from any origin
if (isset($_SERVER['HTTP_ORIGIN'])) {
    // should do a check here to match $_SERVER['HTTP_ORIGIN'] to a
    // whitelist of safe domains
    header("Access-Control-Allow-Origin: {$_SERVER['HTTP_ORIGIN']}");
    header('Access-Control-Allow-Credentials: true');
    header('Access-Control-Max-Age: 86400');    // cache for 1 day
}
// Access-Control headers are received during OPTIONS requests
if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {

    if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_METHOD']))
        header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");         

    if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']))
        header("Access-Control-Allow-Headers: {$_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']}");
}




	   include "connexionBase.php";

       if($base)
       {
            

        $data = json_decode(file_get_contents('php://input'), true);
        $email=$data["email"];

        $requet="SELECT * FROM user ";
        $addOn='';
        if(!empty($data["email"])){ //if is requesting only one user data..
			   $addOn=" where email= '".$data["email"]."' ";
              $requet="SELECT * FROM user ";     
              
        }
        else{
            $addOn=" where Unit=(select distinct Unit from user where email='".$data["email"]."')";
        }
        $result= mysqli_query($base,$requet.$addOn);
        file_put_contents('php://stderr', print_r("$requet"."$addOn", TRUE));
        $user_data=array();
        if($result == false ){
            // echo "<p>pas possible d'executer la requete SQL</p>" ;
            echo $requet.$addOn;
            file_put_contents('php://stderr', print_r("pas possible d'executer la requete SQL", TRUE));
        }else{

                    while($row =mysqli_fetch_array($result)){
                        //echo " labas";
                        //$= json_encode($user_data);
                        $user_data[]=array(                       
                            "email"=>$row[0],
                            "Unit"=>$row[2],
                            "nom"=>$row[3],
                            "prenom"=>$row[4],
                            "disonible"=>$row[5],
                            "sex"=>$row[6],
                            "birthDate"=>$row[7]
                        );
                    }
                    if($user_data)
                    $file_user= json_encode($user_data);
                    
                    file_put_contents('php://stderr', print_r("json encoded successfully for : ".$file_user, TRUE));
                    echo $file_user;

    }
         
         
         
         

      
       
       
}
?>
