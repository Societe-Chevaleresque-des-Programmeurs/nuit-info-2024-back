<?php
error_reporting(E_ALL);

require_once("db_connection.php");
$html = file_get_contents("index.php");

if (isset($_POST["user"]) && isset($_POST["password"]) && isset($_POST["captcha"])) {

    $captcha_response = $_POST["captcha"];
    $captcha_verified = verifyCaptcha($captcha_response);
    if (!$captcha_verified) {
        $html = str_replace("{{ login_error }}", "Captcha non valide.", $html);
        echo $html;
    }
    else {
        $user = $_POST["user"];
        $password = $_POST["password"];

        $sql = "SELECT * FROM user WHERE login = ?";
        $query = mysqli_prepare($con, $sql);
        mysqli_stmt_bind_param($query, 's', $user);
        mysqli_stmt_execute($query);
        $result = mysqli_stmt_get_result($query);

        if ($result) {
            $user_data = mysqli_fetch_assoc($result);
            if ($user_data && password_verify($password, $user_data['password'])) {
                $_SESSION['user'] = $user_data['login'];
                http_redirect("accueil.php");
            }
            else {
                $html = str_replace("{{ login_error }}", "Nom d'utilisateur ou mot de passe incorrect", $html);
                echo $html;
            }
        }
        else {
            $html = str_replace("{{ login_error }}", "Database Error", $html);

            echo $html;
        }
        mysqli_stmt_close($query);
    }
}

function verifyCaptcha($captcha_response) {
    // TODO : implémenter la fonction
    return true;
}