<?php
error_reporting(E_ALL);
require_once("db_connection.php");
$html = file_get_contents("index.php");

$coefRight = 1;
$coefWrong = 1;
$nbRightAnswer = 0;
$nbWrongAnswer = 0;

$login = $_SESSION['user'];

$sql = "CALL getRightAnswers(?)";
$stmt = mysqli_prepare($con, $sql);
if ($stmt === false) {
    die('Error preparing statement: ' . mysqli_error($con));
}
mysqli_stmt_bind_param($stmt, 's', $login);
mysqli_stmt_execute($stmt);
$result = mysqli_stmt_get_result($stmt);
if ($result) {
    $user_data = mysqli_fetch_assoc($result);
    $nbRightAnswer = $user_data['sumR']; // Assuming the column name is 'value'
}
mysqli_stmt_close($stmt);

// Get wrong answers
$sql = "CALL getWrongAnswers(?)";
$stmt = mysqli_prepare($con, $sql);
if ($stmt === false) {
    die('Error preparing statement: ' . mysqli_error($con));
}
mysqli_stmt_bind_param($stmt, 's', $login);
mysqli_stmt_execute($stmt);
$result = mysqli_stmt_get_result($stmt);
if ($result) {
    $user_data = mysqli_fetch_assoc($result);
    $nbWrongAnswer = $user_data['sumR']; // Assuming the column name is 'value'
}
mysqli_stmt_close($stmt);

$nbScore = $coefRight * $nbRightAnswer + $coefWrong * $nbWrongAnswer;
$html = str_replace("{{ score }}", $nbScore, $html);

echo $html;
