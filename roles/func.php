<?php
require_once '../dbcon.php';

if (isset($_POST['viewdata'])) {
    // u.user_id, u.username, u.org_code, concat(u.lname, ', ', u.fname, ' ', u.mname) as `Full name`
    $sql = "SELECT 
    u.user_id as `User id`, u.username, u.fname as `First name`, u.mname as `Middle name`, u.lname as `Last name`, u.email, u.contact_no as `Contact no`, u.status
    FROM ects_core.users u 
    join ects_core.user_roles ur on ur.user_id = u.user_id
    where ur.role_code = '$did'";
    $tb = '
    <div class="btn-group text-end">
      <button class="btn btn-warning btn-sm" onclick="datatable_to_excel(\'modaltb\', \'Role Data\')" title="Export all data"><i class="bi bi-file-spreadsheet-fill"></i></button>
      <button class="btn btn-success btn-sm" onclick="htmltb_to_excel(\'modaltb\');" title="Export only the visible"><i class="bi bi-file-spreadsheet-fill"></i></button>
      <button class="btn btn-primary btn-sm refresh-tb" title="Refresh table"><i class="bi bi-arrow-clockwise"></i></button>
    </div>
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
    (SELECT count(*) FROM ects_core.user_roles where role_code = r.role_code) as `Count`,
    CONCAT('<button class=\"btn btn-primary btn-sm\" did=\"', role_code, '\" onclick=\"viewdata(this)\">View details</button>') AS `Action`
    FROM ects_core.roles r;";
    echo datatb($sql);
}
