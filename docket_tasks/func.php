<?php
require_once '../dbcon.php';

if (isset($_POST['settb'])) {
    $tb = '';
    $sql = "SELECT 
        dt.docket_task_id,
        c.docket_number, 
        c.case_title, 
        dt.task_name, 
        dt.actual_start_date, 
        dt.actual_end_date 
    FROM 
        docket_tasks dt
    JOIN 
        dockets d ON d.docket_id = dt.docket_id
    JOIN 
        cases c ON c.case_id = dt.case_id
    WHERE 
        d.docket_number LIKE '%$search%' or
        c.case_title like '%$search%' or 
        concat(dt.task_name, dt.actual_start_date, dt.actual_end_date ) like '%$search%'
        order by d.docket_id desc
    LIMIT $page, $entries;
";

    echo autotb($sql);
}

if (isset($_POST['setpages'])) {
    $sql = "SELECT count(*) FROM docket_tasks dt
    join dockets d on d.docket_id = dt.docket_id
    join cases c on c.case_id = dt.case_id
    where 
    d.docket_number LIKE '%$search%' or
    c.case_title like '%$search%' or 
    concat(dt.task_name, dt.actual_start_date, dt.actual_end_date ) like '%$search%'";
    echo pages($sql, $entries);
}
