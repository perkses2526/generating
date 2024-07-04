<?php
require_once '../dbcon.php';

// $start_date = $_POST['start_date'] && !empty($_POST['start_date']) ? $_POST['start_date']: '';
// $start_date = isset($_POST['start_date']) && $_POST['start_date'] != "" ? $_POST['start_date']: '';
// $org_code = ($_POST['org_code'] && isset($_POST['org_code']) && !empty($_POST['org_code']) ? $_POST['org_code']: []);

$condition_array = [];

if (isset($_POST['viewcase'])) {
}

if (isset($_POST['setstart_date'])) {
    $sql = "SELECT distinct date_format(filed_date, '%m/%d/%Y') FROM cases order by case_id asc";
    echo optiontags($sql);
    die;
}

if (isset($_POST['setend_date'])) {
    $sql = "SELECT distinct date_format(filed_date, '%m/%d/%Y') FROM cases order by case_id desc";
    echo optiontags($sql);
}

if (isset($_POST['setdisposition_type'])) {
    $sql = "SELECT DISTINCT disposition_type FROM param_disposition_types;";
    echo optiontags($sql);
}

if (isset($_POST['setorg_code'])) {
    $sql = "SELECT DISTINCT org_code FROM dockets;";
    echo optiontags($sql);
}

if (isset($_POST['setcase_type_code'])) {
    $sql = "SELECT DISTINCT case_type_code FROM cases;";
    echo optiontags($sql);
}

if ($org_code && !empty($org_code) && empty($org_code[0]))
    $org_code = [];

if ($org_code) {
    $condition_array[] = 'd.org_code IN (' . implode(',', array_map(function ($org) {
        return "'$org'";
    }, $org_code)) . ')';
}

if ($case_type_code && !empty($case_type_code) && empty($case_type_code[0]))
    $case_type_code = [];

if ($case_type_code)
    $condition_array[] = 'c.case_type_code IN (' . implode(',', array_map(function ($case) {
        return "'$case'";
    }, $case_type_code)) . ')';

if ($start_date && $end_date)
    $condition_array[] = "c.filed_date between '$start_date' and '$end_date'";

$search_condition_array = [];
if ($search) {
    $search_condition_array[] = "concat(d.docket_number, c.case_title, c.filed_date, arb.fname, arb.mname, arb.lname) like '%$search%'";
    $search_condition_array[] = "c.case_id like '%$search%'";
    $search_condition_array[] = "d.docket_number like '%$search%'";
}
if ($search_condition_array)
    $condition_array[] = "  " . implode(" OR ", $search_condition_array) . "  ";

$conditions = '';
if ($condition_array)
    $conditions = " where " . implode(" AND ", $condition_array);

if (isset($_POST['settb'])) {

    $tb = '';
    $sql = "SELECT 
    c.case_id, 
    d.docket_number, 
    c.case_title, 
    c.filed_date, 
    CONCAT(arb.fname, ' ', arb.mname, ' ', arb.lname) AS LA, 
    d.org_code, 
    c.case_type_code, 
    COUNT(DISTINCT cp.party_id) AS total_parties,
    SUM(p.sex_flag = 'M') AS male_parties,
    SUM(p.sex_flag = 'F') AS female_parties
    FROM 
    cases c
    LEFT JOIN dockets d ON d.docket_id = c.docket_id
    LEFT JOIN ects_core.users AS arb ON c.process_by = arb.user_id
    LEFT JOIN case_parties cp ON cp.case_id = c.case_id
    LEFT JOIN parties p ON p.party_id = cp.party_id
    " . $conditions . "
    GROUP BY 
    c.case_id, 
    d.docket_number, 
    c.case_title, 
    c.filed_date, 
    LA, 
    d.org_code, 
    c.case_type_code
    order by c.case_id desc
    limit $page, $entries;";

    echo $sql;
    $res = execquery($sql);

    $tb .= '
    <thead>
        <tr>
            <th>Case number</th>
            <th>Docket number</th>
            <th>Case title(Complainant/Respondent)</th>
            <th>Filed date</th>
            <th>Labor Arbiter</th>
            <th>Organization code</th>
            <th>Case type code</th>
            <th>Case participant number</th>
            <th>Male participant number</th>
            <th>Female participant number</th>
            <!--<th>Action</th>-->
        </tr>
    </thead>
    <tbody>';

    if (mysqli_num_rows($res) > 0) {
        while ($rr = mysqli_fetch_array($res)) {
            $tb .= '
            <tr>
                <td>' . $rr[0] . '</td>
                <td>' . $rr[1] . '</td>
                <td>' . $rr[2] . '</td>
                <td>' . $rr[3] . '</td>
                <td>' . $rr[4] . '</td>
                <td>' . $rr[5] . '</td>
                <td>' . $rr[6] . '</td>
                <td>' . $rr[7] . '</td>
                <td>' . $rr[8] . '</td>
                <td>' . $rr[9] . '</td>
            </tr>
            ';
        }
    } else {
        $tb .= nores(6);
    }
    echo $tb . "</tbody>";
}

if (isset($_POST['setpages'])) {
    /*  $sql = "SELECT
    COUNT(*) AS total_count
FROM
    cases AS a
LEFT JOIN dockets AS c ON a.docket_id = c.docket_id
LEFT JOIN ects_core.users AS d ON a.process_by = d.user_id
LEFT JOIN (
    SELECT
        aaa.case_id,
        COUNT(*) AS Total
    FROM
        case_parties AS aaa
        LEFT JOIN parties AS bbb ON aaa.party_id = bbb.party_id
    WHERE
        bbb.sex_flag = 'M'
    GROUP BY
        aaa.case_id
) AS g ON g.case_id = a.case_id
LEFT JOIN (
    SELECT
        aaa.case_id,
        COUNT(*) AS Total
    FROM
        case_parties AS aaa
        LEFT JOIN parties AS bbb ON aaa.party_id = bbb.party_id
    WHERE
        bbb.sex_flag = 'F'
    GROUP BY
        aaa.case_id
) AS f ON f.case_id = a.case_id
LEFT JOIN (
    SELECT
        bb.*
    FROM
        docket_disposition AS bb
        INNER JOIN (
            SELECT
                docket_id,
                MIN(disposition_id) AS MaxDate
            FROM
                docket_disposition
            GROUP BY
                docket_id
        ) xm ON bb.docket_id = xm.docket_id
            AND bb.disposition_id = xm.MaxDate
) AS b ON b.docket_id = a.docket_id
LEFT JOIN param_disposition_types AS e ON b.disposition_type_id = e.disposition_type_id
LEFT JOIN ( 
    SELECT
        ccc.case_id,
        GROUP_CONCAT(DISTINCT ccc.poopi SEPARATOR '|') AS actioni
    FROM
        (
            SELECT
                aaa.case_id,
                IF(
                    bbb.others_flag = 'Y',
                    CONCAT(bbb.action_cause_short_name, ' - ', aaa.action_cause_others),
                    bbb.action_cause_short_name
                ) AS poopi
            FROM
                case_action_causes AS aaa
                LEFT JOIN param_action_causes AS bbb ON aaa.action_cause_id = bbb.action_cause_id
        ) AS ccc
    GROUP BY
        ccc.case_id
) AS h ON h.case_id = a.case_id
WHERE
    a.process_by IS NOT NULL
    AND a.case_type_code = 'CASE'
    AND a.filed_date BETWEEN '2019-05-01' AND '2019-12-31'
    AND h.actioni LIKE '%distort%'
;
"; */
    $sql = "SELECT count(*) FROM cases c
    LEFT JOIN `dockets` d ON d.docket_id = c.docket_id
    LEFT JOIN ects_core.users as arb on c.process_by = arb.user_id
    " . $conditions . "
    ;";
    echo pages($sql, $entries);
}
