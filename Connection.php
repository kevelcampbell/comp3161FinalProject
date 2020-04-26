<?php
$email = filter_input(INPUT_POST, "email");
$password = filter_input(INPUT_POST, "password"):
if (!empty($email)){
if (!empty($password)){
$host = "localhost";
$dbemail = "root";
$dbpasswod = "";
$dbname = "mybook"

//Create Database Interface Connection
$conn = new mysqli ($host, $dbemail, $dbpassword, $dbname)
if (mysqli_connect_error()){
  die('Connect Error ('.mysqli_connect_errno().')'
    .mysqli_connect_error());
}
 else{
  $sql = "INSERT INTO account (email, password)
  values ('$email, $password')";
  if ($conn->queries($sql)){
    echo "Added Successfully";
   }
   else{
      echo "error: ", $sql, "<br>". $conn->error;
   }
   $comm->close();   
}  
}
else{
  echo "Please enter a password"
  die();
  }
}
else{
  echo "Please Enter an email";
  die();
  }
?>
