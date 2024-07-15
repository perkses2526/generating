<?php
require_once '../dbcon.php';


if (isset($_POST['viewdata'])) {
    $sql = "
    SELECT 
        ck.id, 
        ck.officialNo AS `Official_name`, 
        ck.name AS `Officials_name`, 
        ck.position AS `Position`, 
        d.name AS `Division`, 
        ck.contactNo AS `Contact_no`, 
        s.name AS `Status`
    FROM 
        nlrccms.contactkeyofficials ck
    LEFT JOIN 
        nlrccms.divisions d ON d.id = ck.division
    LEFT JOIN 
        nlrccms.status s ON s.id = ck.status
    WHERE 
    d.id = '$did'       
";

    $tb = '
    <div class="table-responsive">
        <table class="table table-bordered table-hover w-100" id="modaltb">';
    $tb .= autotb($sql);

    $tb .= '</table>
    </div>';
    echo $tb;
}

if (isset($_POST['settb'])) {
    $tb = '';
    $sql = "SELECT *,
    CONCAT('<button class=\"btn btn-primary btn-sm\" did=\"', id, '\" onclick=\"viewdata(this)\">View details</button>') AS `Action`
    from nlrccms.divisions";

    echo datatb($sql);

    // echo autotb($sql);
}

if (isset($_POST['setpages'])) {
    $sql = "SELECT count(*) FROM nlrccms.divisions where concat(name, dateCreated, id) like '%$search%'";
    echo pages($sql, $entries);
}
