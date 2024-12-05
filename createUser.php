<?php
error_reporting(E_ALL);

require_once("db_connection.php");
$html = file_get_contents("index.php");
$login = $_POST['login'];
$password = $_POST['password'];
$password = sha1($password);
$sql = "INSERT INTO `users`(`login`, `password`) VALUES ( '$login','$password')";
$query = mysqli_prepare($con, $sql);
mysqli_stmt_bind_param($query, 's', $user);
mysqli_stmt_execute($query);
$result = mysqli_stmt_get_result($query);
if ($result) {
    //to log
}

?>