<?php
require_once '../dbcon.php';

if (isset($_POST['viewdata'])) {
    echo "";
}

if (isset($_POST['settb'])) {
    $sql = "SELECT * FROM main_nlrc_db.M_Employees;";
    echo datatb($sql);
}
