<?php





	   include "../connexionBase.php";

       if($base)
       {
            

        $data = json_decode(file_get_contents('php://input'), true);
        $email=$data["email"];

        $requet="SELECT * FROM vehicule ";
        $addOn='';
        if(!empty($data["email"])){ //if is requesting only one user data..
			   $addOn=" where id_fk= '".$data["email"]."' ";
              $requet="SELECT * FROM vehicule ";     
              
        }
        else{
            $addOn=" where Unit=(select distinct Unit from user where email='".$data["email"]."')";
        }
        $result= mysqli_query($base,$requet.$addOn);
        // file_put_contents('php://stderr', print_r("$requet"."$addOn", TRUE));
        $user_data=array();
        if($result == false ){
            // echo "<p>pas possible d'executer la requete SQL</p>" ;
            // echo $requet.$addOn;
            file_put_contents('php://stderr', print_r("pas possible d'executer la requete SQL", TRUE));
        }else{

                    while($row =mysqli_fetch_array($result)){
                        //echo " labas";
                        //$= json_encode($user_data);
                        $user_data[]=array(                       
                            "ID_VEHICULE"=>$row[0],
                            "ID_UNITE"=>$row[1],
                            "LABEL_VEHICULE"=>$row[2],
                            "DISPONIB_VEHICULE"=>$row[3],
                        );
                    }
                    if($user_data)
                        $file_user= json_encode($user_data);
                    
                    file_put_contents('php://stderr', print_r("json encoded successfully for : ".$file_user, TRUE));
                    echo $file_user;

    }
         
         
         
         

      
       
       
}
?>
