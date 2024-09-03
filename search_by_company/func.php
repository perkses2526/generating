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
        return "(p.company_name LIKE '%" . addslashes(trim($value)) . "%')";
    }, $valuesArray);

    // Join all LIKE clauses with OR
    $whereClause = implode(' OR ', $likeClauses);

    /* c.docket_number,
    c.case_title,
    c.filed_date,
    IFNULL(k.disposition_type, 'PENDING') AS disposition_type */

    /* 
            FOR CAUSES 
            LEFT JOIN (
                SELECT
                    ccc.case_id,
                    GROUP_CONCAT(DISTINCT ccc.poopi SEPARATOR '|') AS actioni
                FROM
                    (SELECT
                        aaa.case_id,
                        IF(bbb.others_flag = 'Y', CONCAT(ifnull(bbb.action_cause_short_name, ''), ' - ', ifnull(aaa.action_cause_others, '')), bbb.action_cause_short_name) AS poopi
                    FROM
                        case_action_causes AS aaa
                    LEFT JOIN
                        param_action_causes AS bbb ON aaa.action_cause_id = bbb.action_cause_id) AS ccc
                GROUP BY
                    ccc.case_id
            ) AS h ON h.case_id = c.case_id

            h.actioni as causes,
*/

    $sql = "SELECT 
    distinct
    c.docket_number AS case_no,
    c.case_title,
    GROUP_CONCAT(DISTINCT IF(pac.others_flag = 'Y', 
                    CONCAT(pac.action_cause_short_name, ' - ', cac.action_cause_others), 
                    pac.action_cause_short_name
                    )) as causes, 
    IFNULL(k.disposition_type, 'PENDING') AS disposition_status,
    COUNT(DISTINCT pd.party_id) AS `No of workers`
FROM 
    cases c
INNER JOIN 
    dockets d ON d.docket_id = c.docket_id
INNER JOIN 
    case_parties cp ON cp.case_id = c.case_id
LEFT JOIN 
    case_parties pd ON pd.case_id = c.case_id AND pd.case_party_type LIKE 'P%'
INNER JOIN 
    parties p ON p.party_id = cp.party_id
LEFT JOIN 
    (
        SELECT 
            zz.* 
        FROM 
            docket_disposition zz
        INNER JOIN 
            (
                SELECT 
                    docket_id, 
                    MAX(disposition_id) AS MaxDate 
                FROM 
                    docket_disposition 
                GROUP BY 
                    docket_id
            ) xm 
            ON zz.docket_id = xm.docket_id 
            AND zz.disposition_id = xm.MaxDate
    ) z ON z.docket_id = c.docket_id
LEFT JOIN 
    param_disposition_types k ON k.disposition_type_id = z.disposition_type_id
LEFT JOIN case_action_causes cac ON cac.case_id = c.case_id
LEFT JOIN param_action_causes pac ON pac.action_cause_id = cac.action_cause_id
WHERE 
    $whereClause
    AND c.filed_date between '2019-04-01' and '2024-06-01'
    and c.case_type_code = 'RFA'
    AND c.process_by IS NOT NULL
GROUP BY 
    c.docket_number, 
    c.case_title, 
    p.company_name, 
    c.filed_date, 
    k.disposition_type
";


    // Execute the query and fetch the results
    // echo $sql;
    echo datatb($sql);
}
