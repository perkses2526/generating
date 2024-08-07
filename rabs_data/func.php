<?php
require_once '../dbcon.php';

$countsonly = $_POST['countsonly'] ?? '';

if (isset($_POST['viewdata'])) {
    echo "";
}

if (isset($_POST['settb'])) {
    $case_type_filter = '';
    $org_code_filter = '';
    $date_filter = '';
    if ($case_type_code) {
        $case_type_filter = ' AND c.case_type_code IN (' . implode(',', array_map(function ($case) {
            return "'" . addslashes($case) . "'";
        }, $case_type_code)) . ')';
    }

    if ($org_code) {
        $org_code_filter = ' AND d.org_code IN (' . implode(',', array_map(function ($org) {
            return "'" . addslashes($org) . "'";
        }, $org_code)) . ')';
    }

    if ($start_date && $end_date) {
        $date_filter = " AND c.filed_date BETWEEN '" . addslashes($start_date) . "' AND '" . addslashes($end_date) . "'";
    }

    if ($countsonly === "") {
        $sql = "SELECT DISTINCT c.docket_number, c.case_title, dd.date_disposed, pdt.disposition_type
        FROM cases c
        JOIN dockets d ON d.docket_id = c.docket_id
        LEFT JOIN docket_disposition dd ON dd.docket_id = c.docket_id
        LEFT JOIN param_disposition_types pdt on pdt.disposition_type_id = dd.disposition_type_id
        WHERE c.process_by IS NOT NULL
        " . $case_type_filter . "
        " . $org_code_filter . "
        " . $date_filter . "
        GROUP BY c.docket_number, c.case_title, dd.date_disposed
        ;";
    } else {
        $sql = "SELECT d.org_code, c.case_type_code,  COUNT(dd.date_disposed) AS `pendings`, COUNT(distinct d.docket_id) as `total_cases` 
        FROM cases c
        JOIN dockets d ON d.docket_id = c.docket_id
        LEFT JOIN docket_disposition dd ON dd.docket_id = c.docket_id
        WHERE c.process_by IS NOT NULL and d.org_code != ''
        " . $case_type_filter . "
        " . $org_code_filter . "
        " . $date_filter . "
        GROUP BY d.org_code, c.case_type_code
        ;";
    }
    echo datatb($sql);
}
