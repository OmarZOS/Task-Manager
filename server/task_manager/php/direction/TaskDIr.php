  

<?php 
//select task of user
 include "connexionBase.php";
 //selectionner les taches d'une personne (password connue);
//*Need un json qui contient password or something unique for user */

 if($base)
        {
        echo "hello 1";
        $fileJson = file_get_contents('Search_Tasks.json');
        $obj = json_decode($fileJson);

        
        $email=  $obj->email; 
        //$email=$_POST["email"];
        // if(isset($_POST["password"]) and isset($_POST["email"]))
        {
            $sql = "select  t.label_tache,t.id_Etat,t.description_tache,t.DATE_DEBETACHE,t.periode from tachesdir t
                    where t.id_tache in(select id_tache from necissitecomU where  ID_USER= '$email' );
            if ($base->query($sql) === TRUE) {
                echo "TRUE ";
                $result= mysqli_query($base,$sql);
                while($row =mysqli_fetch_array($result)){

                    echo " labas";
                    $task_data[]=array(
                       
                        "Label_Tache"=>$row[0],
                        "Etat"=>$row[1],
                        "Description"=>$row[2],
                        "Date_Debut"=>$row[3],
                        "periode"=>$row[4]

                    );
               } 
               $file_task= json_encode($task_data);
               
               echo $file_task;
            } else {
                echo "Error: " . $sql . "<br>" . $base->error;
            }



   }

}
?>