<?php
require_once 'dbcon.php';

$username = $_POST['username'] ?? '';
$password = $_POST['password'] ?? '';

if (isset($_POST['signin'])) {
    $sql = "SELECT * FROM `accounts` WHERE `username` = '$username'";
    $res = execquery($sql);
    if (mysqli_num_rows($res) > 0) {
        $row = mysqli_fetch_array($res);
        $dbpass = $row['password'];
        if (password_verify($password, $dbpass)) {
            $_SESSION['account_id'] = $row['account_id'];
            $_SESSION['username '] = $row['username'];
            $_SESSION['full_name'] = $row['full_name'];
            $_SESSION['usertype'] = $row['usertype'];
            echo "success";
        } else {
            echo "password incorrect";
        }
    } else {
        echo "Wrong username and password";
    }
}
