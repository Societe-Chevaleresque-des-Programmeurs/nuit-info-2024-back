<?php
$coefRight = 1;
$coefWrong = 1;
$nbRightAnswer = 0;
$nbWrongAnswer = 0;

$procedure_params = array(
array(&$myparams['login'], SQLSRV_PARAM_IN));
$sql = "EXEC getRightAnswers login = ?";
$stmt = mysqli_prepare($con, $sql);
mysqli_stmt_execute($stmt);
$result = mysqli_stmt_get_result($stmt);
if ($result){
    $user_data = mysqli_fetch_assoc($result);
    $nbRightAnswer = $user_data['value']; // to correct
}
$sql = "EXEC getWrongAnswers login = ?";
$stmt = mysqli_prepare($conn, $sql);
mysqli_stmt_execute($stmt);
$result = mysqli_stmt_get_result($stmt);
if ($result){
    $user_data = mysqli_fetch_assoc($result);
    $nbWrongAnswer = $user_data['value']; // to correct
}

$nbScore = $coefRight * $nbRightAnswer + $coefWrong * $nbWrongAnswer;