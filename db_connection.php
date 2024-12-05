<?php
error_reporting(E_ALL);

$con = mysqli_connect("hostname", "root", "");
if(!$con)
    die ("error connecting to the database");

return $con;