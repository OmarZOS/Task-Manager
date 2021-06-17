<?php


// session_id(json_decode(file_get_contents('php://input'), true)["email"]);
$_SESSION['ip']=$_SERVER['REMOTE_ADDR'];
if(isset($_SESSION['ip']))
    file_put_contents('php://stderr', print_r("\setup ip\n", TRUE));
session_start();



include "connexionBase.php";


$data = json_decode(file_get_contents('php://input'), true);
$email=$data["email"];
$password=$data["password"];

if(empty($data["email"] or  $data["password"]))
    echo "false" ;
else{

    // Takes raw data from the request
    // $json = file_get_contents('php://input');

    
    // Converts it into a PHP object
    
    

    $requet="SELECT * FROM user where email='$email' and password='$password'";
    $result= mysqli_query($base,$requet);
    $count= mysqli_num_rows($result);
    
    if($count>=1)
        echo "true";
    
    
    else
    echo "false";
    /*echo "Verifier Vos Input" ;*/
    
}


?>
