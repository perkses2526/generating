<?php
require_once '../dbcon.php';

if (isset($_POST['viewdata'])) {
    echo "";
}

if (isset($_POST['settb'])) {
    $sql = "SELECT user_id, username, org_code, fname, lname, mname, email, contact_no, mobile_no, status FROM ects_core.users;";
    echo datatb($sql);
}
