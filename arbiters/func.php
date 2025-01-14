<?php
require_once '../dbcon.php';

$case_type_code = $_POST['case_type_code'] ?? [];
$org_code = $_POST['org_code'] ?? [];
$start_date = $_POST['start_date'] ?? '';
$end_date = $_POST['end_date'] ?? '';
$uid = $_POST['uid'] ?? '';

if (isset($_POST['viewpendings'])) {
    $sql = "SELECT d.docket_number, c.case_title, c.filed_date, concat(u.lname, ', ', u.fname) as `Labor Arbiter` FROM cases c
    join dockets d on d.docket_id = c.docket_id
    join ects_core.users u on u.user_id = c.process_by
    left join docket_disposition dd on dd.docket_id = d.docket_id
    where c.process_by = '$uid' and dd.disposition_id is null and c.filed_date between '$start_date' and '$end_date'
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

if (isset($_POST['setorg_code'])) {
    $sql = "SELECT DISTINCT org_code FROM ects_core.users";
    echo optiontags($sql);
}

if (isset($_POST['setcase_type_code'])) {
    $sql = "SELECT DISTINCT case_type_code FROM cases;";
    echo optiontags($sql);
}

if (isset($_POST['settb'])) {
    $tb = '';
    $sql = "SELECT 
        d.user_id, 
        d.username,
        concat(d.fname, ' ', d.mname, ' ', d.lname) as `Full Name`,
        d.org_code as `RAB`,
        concat('<button class=\"btn btn-warning btn-sm\" onclick=\"viewpendings(this);\">', count(distinct case when b.date_disposed is null then a.docket_id end), '</button>') as `Pending cases`, 
        count(c.docket_number) as `Total cases`,
        d.status
    from cases as a
    left join dockets as c on a.docket_id = c.docket_id
    left join ects_core.users as d on a.process_by = d.user_id
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
    a.process_by is not null 
    and c.docket_number IS NOT NULL 
    AND c.org_code is not null
    AND a.case_type_code = 'CASE'
    " . ($case_type_code ? ' and a.case_type_code IN (' . implode(',', array_map(function ($case) {
        return "'$case'";
    }, $case_type_code)) . ')' : '') . "

    " . ($org_code ? ' and d.org_code IN (' . implode(',', array_map(function ($org) {
        return "'$org'";

    }, $org_code)) . ')' : '') . "
    " . ($start_date && $end_date ? " and c.created_date between '$start_date' and '$end_date'" : '') . "

    group by d.fname, d.mname, d.lname, 
		c.org_code, c.docket_type_code 
    order by `Full Name`, `Total cases` desc
    ;";
    /*    $sql = "SELECT 
        d.user_id, 
        d.username,
        UPPER(concat(d.lname, ', ', d.fname, ' ', if(d.mname is null or d.mname = '', '' , concat(left(d.mname, 1), '.'))))as `Full Name`, 
        UPPER(concat(d.fname, ' ', if(d.mname is null or d.mname = '', '' , concat(left(d.mname, 1), '.')), ' ', d.lname))as `fnmnln`, 
        d.org_code, d.status
    from ects_core.users as d
    left join ects_core.user_roles ur on ur.user_id = d.user_id
    where 
         ur.role_code = 'LABOR_ARBITER' 
    order by d.lname ASC
    ;"; */

    echo datatb($sql);

    // echo autotb($sql);
    // a.case_type_code = 'CASE'
    // and a.filed_date between '2019-05-01' AND '2024-04-31'
}
