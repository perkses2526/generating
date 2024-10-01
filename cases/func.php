<?php
require_once '../dbcon.php';



if (isset($_POST['settb'])) {
    $tb = '';
/*     $sql = "SELECT *, '<button class=\"btn btn-primary btn-sm\">View</button>' as action FROM dockets
    where concat(docket_id, docket_number, docket_type_code) like '%$search%'
    limit $page, $entries"; */
    $sql = "SELECT * FROM cases where (docket_number like '%$search%' or case_title like '%$search%') order by filed_date desc limit $page, $entries";

    echo autotb($sql);
}

if (isset($_POST['setpages'])) {
    $sql = "SELECT count(*) FROM cases where (docket_number like '%$search%' or case_title like '%$search%') ";
    echo pages($sql, $entries);
}
