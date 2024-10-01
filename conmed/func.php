<?php
require_once '../dbcon.php';

$uid = $_POST['uid'] ?? '';

if (isset($_POST['viewdata'])) {
    echo "";
}

if (isset($_POST['viewpendings'])) {
    $sql = "SELECT d.docket_number, c.case_title, c.filed_date, concat(u.lname, ', ', u.fname) as `Labor Arbiter` FROM cases c
    join dockets d on d.docket_id = c.docket_id
    join ects_core.users u on u.user_id = c.process_by
    left join docket_disposition dd on dd.docket_id = d.docket_id
    where c.process_by = '$uid' and dd.disposition_id is null
    ;";

    $tb = '
    <div class="row">
        <div class="text-end">
            <button class="btn btn-success btn-sm"><i class="bi bi-file-spreadsheet-fill" onclick="datatable_to_excel(\'modaltb\');"></i></button>
        </div>
        <div class="table-responsive">
            <table class="table table-bordered table-hover w-100" id="modaltb">';
    $tb .= autotb($sql, 1);
    $tb .= '</table>
        </div>
    </div>
    ';
    echo $tb;
}

if (isset($_POST['settb'])) {
    /*     $sql = "SELECT 
        d.user_id, 
        d.username,
        UPPER(concat(d.lname, ', ', d.fname, ' ', if(d.mname is null or d.mname = '', '' , concat(left(d.mname, 1), '.'))))as `Full Name`, d.org_code, d.status
    from ects_core.users as d
    left join ects_core.user_roles ur on ur.user_id = d.user_id
    where 
         ur.role_code = 'CON_MED' 
    order by d.lname ASC
    ;"; */
    $sql = "SELECT 
    d.user_id, 
    d.username,
    concat(d.fname, ' ', d.mname, ' ', d.lname) as `Full Name`,
    d.org_code as `RAB`,
    count(distinct a.docket_number) as `Total cases`,
    concat('<button class=\"btn btn-warning btn-sm\" onclick=\"viewpendings(this);\">', count(distinct case when b.date_disposed is null then a.docket_id end), '</button>') as `Pending cases`, 
    d.status
from cases as a
left join dockets as c on a.docket_id = c.docket_id
left join ects_core.users as d on a.process_by = d.user_id
left join ects_core.user_roles ur on ur.user_id = d.user_id
left join (
    select bb.* 
    from docket_disposition as bb 
    inner join (
        select docket_id, min(disposition_id) as MaxDate 
        from docket_disposition 
        group by docket_id
    ) xm on bb.docket_id = xm.docket_id and bb.disposition_id = xm.MaxDate
) as b on b.docket_id = a.docket_id
where 
    ur.role_code = 'CON_MED'
group by d.fname, d.mname, d.lname
order by `Full Name`, `Total cases` desc
;";
    echo datatb($sql);
}
