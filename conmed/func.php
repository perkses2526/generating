<?php
require_once '../dbcon.php';

if (isset($_POST['viewdata'])) {
    echo "";
}

if (isset($_POST['settb'])) {
    $sql = "SELECT 
        d.user_id, 
        d.username,
        UPPER(concat(d.lname, ', ', d.fname, ' ', if(d.mname is null or d.mname = '', '' , concat(left(d.mname, 1), '.'))))as `Full Name`, d.org_code, d.status
    from ects_core.users as d
    left join ects_core.user_roles ur on ur.user_id = d.user_id
    where 
         ur.role_code = 'CON_MED' 
    order by d.lname ASC
    ;";
    echo datatb($sql);
}
