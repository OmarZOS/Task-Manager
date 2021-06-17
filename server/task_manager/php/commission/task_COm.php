  

<?php 
//select task of user
 include "../connexionBase.php";
 //selectionner les taches d'une personne (password connue);
//*Need un json qui contient password or something unique for user */

 if($base)
        {
        // echo "hello 1";
       /* $fileJson = file_get_contents('Search_Tasks.json');
        $obj = json_decode($fileJson);*/
        $data = json_decode(file_get_contents('php://input'), true);
        $email=$data["email"];


        
        //$email=  $obj->email; 
        //$email=$_POST["email"];
        // if(isset($_POST["password"]) and isset($_POST["email"]))
        {
            $sql = "select  t.* from tachescom t
                    where t.id_tache in(select id_tache from necissitecomu where  ID_USER='".$data["email"]."'  )
                    UNION
                    select  v.* from tachesdir v
                    where v.id_tache in(select id_tache from necissitediru where  ID_USER='".$data["email"]."' ) 
                ";
            
            $task_data= array();
            $result= mysqli_query($base,$sql);
            if ($result==true) {
                // echo "hello 1";
                while($row =mysqli_fetch_array($result)){

                    $task_data[]=array(
                        "Label_Tache"=>$row[2],
                        "Etat"=>$row[1],
                        "Description"=>$row[3],
                        "Date_Debut"=>$row[4],
                        "periode"=>$row[5],
                        "ID_TACHE"=>$row[0]
                    );
               } 
               $file_task= json_encode($task_data);
               
               echo $file_task;
            } else {
                $file_task= json_encode($task_data);
                echo $file_task;
                // echo "Error: " . $sql . "<br>" . $base->error;
            }



   }

}
?>