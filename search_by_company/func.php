<?php
require_once '../dbcon.php';

$t = $_POST['t'] ?? '';
$attrs = $_POST['attrs'] ?? '';
$number = $_POST['number'] ?? '';

if (isset($_POST['viewdata'])) {
    $t = ($t === "2" ? 'case_id' : 'docket_id');
    $sql = "SELECT * FROM $attrs where $t = $number order by 1 asc";
    $tb = '
    <div class="btn-group text-end">
      <button class="btn btn-warning btn-sm" onclick="datatable_to_excel(\'modaltb\', $(\'#modalTitle\').html())" title="Export all data"><i class="bi bi-file-spreadsheet-fill"></i></button>
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

if (isset($_POST['search_data'])) {
    // Retrieve the formatted value from the POST request
    $val = $_POST['val'];

    // Split the input value by commas into an array
    $valuesArray = explode(',', $val);

    // Trim whitespace and build the WHERE clause
    $likeClauses = array_map(function ($value) {
        return "p.company_name LIKE '%" . addslashes(trim($value)) . "%'";
    }, $valuesArray);

    // Join all LIKE clauses with OR
    $whereClause = implode(' OR ', $likeClauses);

    $sql = "SELECT trim(p.company_name) as company_name,
                   c.docket_number,
                   c.case_type_code,
                   c.case_title,
                   c.filed_date,
                   pdt.disposition_type
            FROM cases c 
            JOIN dockets d ON d.docket_id = c.docket_id
            JOIN case_parties cp ON cp.case_id = c.case_id
            JOIN parties p ON p.party_id = cp.party_id
            JOIN docket_disposition dd ON dd.docket_id = d.docket_id
            LEFT JOIN param_disposition_types pdt ON pdt.disposition_type_id = dd.disposition_type_id
            WHERE " . $whereClause . "
            ORDER BY trim(p.company_name) ASC";

    // Execute the query and fetch the results
    // echo $sql;
    echo datatb($sql);
}
