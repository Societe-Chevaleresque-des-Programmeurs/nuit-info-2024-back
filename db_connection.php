<?php
error_reporting(E_ALL);

$con = mysqli_connect("db_n24", "root", "");
if(!$con)
    die ("error connecting to the database");

return $con;