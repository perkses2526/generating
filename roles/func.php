<?php
require_once '../dbcon.php';

if (isset($_POST['viewdata'])) {
    $sql = "SELECT u.user_id, u.username, u.org_code, concat(u.lname, ', ', u.fname, ' ', u.mname) as `Full name` FROM ects_core.users u 
    join ects_core.user_roles ur on ur.user_id = u.user_id
    where ur.role_code = '$did'";
    // echo datatb($sql);
    $tb = '
    <div class="table-responsive">
        <table class="table table-bordered table-hover w-100" id="modaltb">';
    $tb .= autotb($sql);

    $tb .= '</table>
    </div>';
    echo $tb;
}

if (isset($_POST['settb'])) {
    $sql = "SELECT 
    role_code as `Role code`, role_name as `Role name`, 
    CONCAT('<button class=\"btn btn-primary btn-sm\" did=\"', role_code, '\" onclick=\"viewdata(this)\">View details</button>') AS `Action`
    FROM ects_core.roles;";
    echo datatb($sql);
}
