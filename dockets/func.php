<?php
require_once '../dbcon.php';

$docket_number = $_POST['docket_number'] ?? '';

if (isset($_POST['dockettask'])) {
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
        d.docket_id = '$did'
";

    $tb = '
        <div class="text-end col-auto">
            <div class="btn-group">
                <button class="btn btn-primary btn-sm" onclick="printDiv(\'modaldivprint\')" title="Print this data"><i class="bi bi-printer"></i></button>
                <button class="btn btn-warning btn-sm" onclick="datatable_to_excel(\'modaltb\', \'Docket task data - ' . $docket_number . '\');" title="Export all data"><i class="bi bi-file-spreadsheet-fill"></i></button>
                <button class="btn btn-success btn-sm" onclick="htmltb_to_excel(\'modaltb\');" title="Export only the visible"><i class="bi bi-file-spreadsheet-fill"></i></button>
            </div>
        </div>
        <div class="table-responsive" id="modaldivprint">
            <table class="table table-bordered table-hover w-100" id="modaltb">';
    $tb .= autotb($sql);

    $tb .= '</table>
        </div>';
    echo $tb;
}

if (isset($_POST['docketreassign'])) {
    $sql = "SELECT reassign_id, reassign_name, reason, date_reassigned FROM docket_reassignment where docket_id = '$did'";
    $tb = '
    <div class="text-end col-auto">
        <div class="btn-group">
            <button class="btn btn-primary btn-sm" onclick="printDiv(\'modaldivprint\')" title="Print this data"><i class="bi bi-printer"></i></button>
            <button class="btn btn-warning btn-sm" onclick="datatable_to_excel(\'modaltb\', \'Docket task data - ' . $docket_number . '\');" title="Export all data"><i class="bi bi-file-spreadsheet-fill"></i></button>
            <button class="btn btn-success btn-sm" onclick="htmltb_to_excel(\'modaltb\');" title="Export only the visible"><i class="bi bi-file-spreadsheet-fill"></i></button>
        </div>
    </div>
    <div class="table-responsive" id="modaldivprint">
        <table class="table table-bordered table-hover w-100" id="modaltb">';
    $tb .= autotb($sql);

    $tb .= '</table>
    </div>';
    echo $tb;
}

if (isset($_POST['settb'])) {
    $sql = "SELECT 
            d.docket_id,
            d.docket_number,
            d.docket_type_code,
            d.org_code,
            CONCAT(
                '<button class=\"btn btn-primary btn-sm\" onclick=\"viewDocket(this);\">View</button>',
                IF(
                    (SELECT COUNT(*) FROM docket_reassignment dr WHERE dr.docket_id = d.docket_id) >= 1, 
                    '<button class=\"btn btn-sm btn-warning\" onclick=\"docketreassign(this);\">Docket re-assignment</button>', 
                    ''
                ),
                IF(
                    (SELECT COUNT(*) FROM docket_tasks dt WHERE dt.docket_id = d.docket_id) >= 1, 
                    '<button class=\"btn btn-sm btn-info\" onclick=\"dockettask(this);\">Docket task</button>', 
                    ''
                )
            ) AS action 
        FROM 
            ects.dockets d;
    ";
    echo datatb($sql);
}

if (isset($_POST['setpages'])) {
    $sql = "SELECT count(*) FROM dockets";
    echo pages($sql, $entries);
}
// SELECT * FROM ects.dockets where docket_number = 'NCR-10-13560-13';
