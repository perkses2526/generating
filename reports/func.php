<?php
require_once '../dbcon.php';

use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Reader\Xlsx as ReaderXlsx;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx as WriterXlsx;
use PhpOffice\PhpSpreadsheet\Style\Border;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx;

$report_list = $_POST['report_list'] ?? '';
$report_name = $_POST['report_name'] ?? '';
$sql = "";
$conditions = [];



/* if (isset($_POST['extractdata'])) {
    if ($report_list === "1") {
        $baseQuery = "SELECT a.docket_number, a.case_title, a.filed_date, b.date_disposed, e.disposition_type, 
            CONCAT(d.fname, ' ', d.mname, ' ' , d.lname) AS `Labor Arbiter`, c.org_code, b.created_date, 
            h.actioni AS `Causes`,  
            IF(g.total IS NULL, '0', g.total) AS male_count,
            IF(f.total IS NULL, '0', f.total) AS female_count
            FROM cases AS a
            LEFT JOIN dockets AS c ON a.docket_id = c.docket_id
            LEFT JOIN ects_core.users AS d ON a.process_by = d.user_id
            LEFT JOIN (SELECT aaa.case_id, COUNT(*) AS Total 
                       FROM case_parties AS aaa 
                       LEFT JOIN parties AS bbb ON aaa.party_id = bbb.party_id 
                       WHERE bbb.sex_flag = 'M' 
                       GROUP BY aaa.case_id) AS g ON g.case_id = a.case_id 
            LEFT JOIN (SELECT aaa.case_id, COUNT(*) AS Total 
                       FROM case_parties AS aaa 
                       LEFT JOIN parties AS bbb ON aaa.party_id = bbb.party_id 
                       WHERE bbb.sex_flag = 'F' 
                       GROUP BY aaa.case_id) AS f ON f.case_id = a.case_id
            LEFT JOIN (SELECT bb.* 
                       FROM docket_disposition AS bb 
                       INNER JOIN (SELECT docket_id, MIN(disposition_id) AS MaxDate 
                                   FROM docket_disposition 
                                   GROUP BY docket_id) xm 
                       ON bb.docket_id = xm.docket_id AND bb.disposition_id = xm.MaxDate) AS b ON b.docket_id = a.docket_id
            LEFT JOIN param_disposition_types AS e ON b.disposition_type_id = e.disposition_type_id
            LEFT JOIN (SELECT ccc.case_id, GROUP_CONCAT(DISTINCT ccc.poopi SEPARATOR '|') AS actioni 
                       FROM (SELECT aaa.case_id, IF(bbb.others_flag = 'Y', CONCAT(bbb.action_cause_short_name, ' - ', aaa.action_cause_others), bbb.action_cause_short_name) AS poopi 
                             FROM case_action_causes AS aaa 
                             LEFT JOIN param_action_causes AS bbb ON aaa.action_cause_id = bbb.action_cause_id) AS ccc 
                       GROUP BY ccc.case_id) AS h ON h.case_id = a.case_id
            WHERE a.process_by IS NOT NULL";

        $conditions = array();

        if ($case_type_code) {
            $conditions[] = 'a.case_type_code IN (' . implode(',', array_map(function ($case) {
                return "'$case'";
            }, $case_type_code)) . ')';
        }

        if ($org_code) {
            $conditions[] = 'd.org_code IN (' . implode(',', array_map(function ($org) {
                return "'$org'";
            }, $org_code)) . ')';
        }

        if ($start_date && $end_date) {
            $conditions[] = "a.filed_date BETWEEN '$start_date' AND '$end_date'";
        }

        if ($search) {
            $conditions[] = "(h.actioni LIKE '%$search%' OR a.docket_number LIKE '%$search%')";
        }

        $sql = $baseQuery . (count($conditions) > 0 ? ' AND ' . implode(' AND ', $conditions) : '') . " ";

        try {
            // set_time_limit(10000); // Increase maximum execution time

            $spreadsheet = new Spreadsheet();
            $sheet = $spreadsheet->getActiveSheet();

            // $title = array($sub_title . "_" . $file_title);

            // Execute the query and fetch the result
            $res = execquery($sql);

            // Get the column names from the result set
            $headersArray = array();
            $rowIndex = 3; // Starting row for data

            if ($row = $res->fetch_assoc()) {
                $headersArray = array_keys($row);
                // $sheet->fromArray($title, NULL, 'A1');
                $sheet->fromArray($headersArray, NULL, 'A2');

                do {
                    $sheet->fromArray(array_values($row), NULL, 'A' . $rowIndex);
                    $rowIndex++;
                } while ($row = $res->fetch_assoc());
            }

            $filePath = 'REPORTS/';
            createDirectory($filePath);
            $filePath .= $report_name . " Date Extracted: " . date('Y-m-d hh:mm:ss') . ".xlsx";
            // Create a writer object
            $writer = new Xlsx($spreadsheet);
            $writer->save($filePath);
            echo $filePath;
        } catch (Exception $e) {
            echo 'Error: ' . $e->getMessage();
        }
    }
} */


if (isset($_POST['settb'])) {
    $conditions = [];

    if ($report_list === "1") {
        $baseQuery = "SELECT a.docket_number as `Docket number`, a.case_title as `Case title`, a.filed_date as `Filed date`, b.date_disposed as `Date disposed`, e.disposition_type as `Disposition type`, 
            CONCAT(d.fname, ' ', d.mname, ' ' , d.lname) AS `Labor Arbiter`, c.org_code as `RAB`, b.created_date as `Created date`, 
            h.actioni AS `Causes`,  
            IF(g.total IS NULL, '0', g.total) AS `Male count`,
            IF(f.total IS NULL, '0', f.total) AS `Female count`
            FROM cases AS a
            LEFT JOIN dockets AS c ON a.docket_id = c.docket_id
            LEFT JOIN ects_core.users AS d ON a.process_by = d.user_id
            LEFT JOIN (SELECT aaa.case_id, COUNT(*) AS Total 
                       FROM case_parties AS aaa 
                       LEFT JOIN parties AS bbb ON aaa.party_id = bbb.party_id 
                       WHERE bbb.sex_flag = 'M' 
                       GROUP BY aaa.case_id) AS g ON g.case_id = a.case_id 
            LEFT JOIN (SELECT aaa.case_id, COUNT(*) AS Total 
                       FROM case_parties AS aaa 
                       LEFT JOIN parties AS bbb ON aaa.party_id = bbb.party_id 
                       WHERE bbb.sex_flag = 'F' 
                       GROUP BY aaa.case_id) AS f ON f.case_id = a.case_id
            LEFT JOIN (SELECT bb.* 
                       FROM docket_disposition AS bb 
                       INNER JOIN (SELECT docket_id, MIN(disposition_id) AS MaxDate 
                                   FROM docket_disposition 
                                   GROUP BY docket_id) xm 
                       ON bb.docket_id = xm.docket_id AND bb.disposition_id = xm.MaxDate) AS b ON b.docket_id = a.docket_id
            LEFT JOIN param_disposition_types AS e ON b.disposition_type_id = e.disposition_type_id
            LEFT JOIN (SELECT ccc.case_id, GROUP_CONCAT(DISTINCT ccc.poopi SEPARATOR '|') AS actioni 
                       FROM (SELECT aaa.case_id, IF(bbb.others_flag = 'Y', CONCAT(bbb.action_cause_short_name, ' - ', aaa.action_cause_others), bbb.action_cause_short_name) AS poopi 
                             FROM case_action_causes AS aaa 
                             LEFT JOIN param_action_causes AS bbb ON aaa.action_cause_id = bbb.action_cause_id) AS ccc 
                       GROUP BY ccc.case_id) AS h ON h.case_id = a.case_id
            WHERE a.process_by IS NOT NULL";

        if ($case_type_code) {
            $conditions[] = 'a.case_type_code IN (' . implode(',', array_map(function ($case) {
                return "'$case'";
            }, $case_type_code)) . ')';
        }

        if ($org_code) {
            $conditions[] = 'd.org_code IN (' . implode(',', array_map(function ($org) {
                return "'$org'";
            }, $org_code)) . ')';
        }

        if ($start_date && $end_date) {
            $conditions[] = "a.filed_date BETWEEN '$start_date' AND '$end_date'";
        }

        if ($search) {
            $conditions[] = "(h.actioni LIKE '%$search%' OR a.docket_number LIKE '%$search%')";
        }

        $sql = $baseQuery . (count($conditions) > 0 ? ' AND ' . implode(' AND ', $conditions) : '') . " ";
    } else if ($report_list === "2") {
        $sql = "SELECT c.org_code AS `RAB`, c.docket_number as `Docket number`, a.case_title as `Title`, a.filed_date as `Date Filed`, f.available_date as `Initial Conference`, b.date_disposed as `Date disposed`, '' as `Duration to Dispose`, d.username as `Con-Med`, a.created_by as `FiledBy`, b.remarks as `Remarks`, 
        c.org_code AS `RAB`, concat(d.fname, ' ', d.mname,'. ', d.lname) as `Conmed`, pdt.disposition_type as `Disposition`, h.actioni as action, b.reason as `Reason`
        from cases as a
        left join dockets as c on a.docket_id = c.docket_id
        left join ects_core.users as d on a.process_by = d.user_id
        left join (select ee.* from docket_tasks as ee inner join (select docket_id, max(docket_task_id) as MaxDate from docket_tasks where activity_name = 'First conciliation-mediation conference' group by docket_id ) xm on ee.docket_id = xm.docket_id and ee.docket_task_id = xm.MaxDate) as e on a.docket_id = e.docket_id
        left join param_availability_schedule as f on e.availability_schedule_id = f.availability_schedule_id
        left join (select bb.* from docket_disposition as bb inner join (select docket_id, min(disposition_id) as MaxDate,remarks from docket_disposition group by docket_id ) xm on bb.docket_id = xm.docket_id and bb.disposition_id = xm.MaxDate) as b on b.docket_id = a.docket_id
        left join docket_disposition dd on dd.docket_id = c.docket_id
        left join param_disposition_types pdt on pdt.disposition_type_id = dd.disposition_type_id
        left join (SELECT ccc.case_id, GROUP_CONCAT(DISTINCT ccc.poopi SEPARATOR '|') as actioni FROM (select aaa.case_id, if(bbb.others_flag = 'Y',concat(bbb.action_cause_short_name, ' - ', aaa.action_cause_others),bbb.action_cause_short_name) as poopi from case_action_causes as aaa left join param_action_causes as bbb on aaa.action_cause_id = bbb.action_cause_id) as ccc GROUP BY ccc.case_id) as h on h.case_id = a.case_id
        where a.process_by is not null
        and a.case_type_code = 'RFA'
        and 
        (
            (b.date_disposed BETWEEN '2020-07-15' AND '2023-12-31' and a.filed_date between '2018-01-01' AND '2024-12-31') or 
            (b.date_disposed is null and a.filed_date between '2020-07-15' AND '2024-12-31')
        )
        order by a.filed_date, a.process_by, b.date_disposed desc;";
        /*  $sql = "SELECT c.org_code AS `RAB`, c.docket_number as `Docket number`, a.case_title as `Title`, a.filed_date as `Date Filed`, f.available_date as `Initial Conference`, b.date_disposed as `Date disposed`, '' as `Duration to Dispose`, d.username as `Con-Med`, a.created_by as `FiledBy`, b.remarks as `Remarks`, 
        c.org_code AS `RAB`, concat(d.fname, ' ', d.mname,'. ', d.lname) as `Conmed`, pdt.disposition_type as `Disposition`
        from cases as a
        left join dockets as c on a.docket_id = c.docket_id
        left join ects_core.users as d on a.process_by = d.user_id
        left join (select ee.* from docket_tasks as ee inner join (select docket_id, max(docket_task_id) as MaxDate from docket_tasks where activity_name = 'First conciliation-mediation conference' group by docket_id ) xm on ee.docket_id = xm.docket_id and ee.docket_task_id = xm.MaxDate) as e on a.docket_id = e.docket_id
        left join param_availability_schedule as f on e.availability_schedule_id = f.availability_schedule_id
        left join (select bb.* from docket_disposition as bb inner join (select docket_id, min(disposition_id) as MaxDate,remarks from docket_disposition group by docket_id ) xm on bb.docket_id = xm.docket_id and bb.disposition_id = xm.MaxDate) as b on b.docket_id = a.docket_id
        left join docket_disposition dd on dd.docket_id = c.docket_id
        left join param_disposition_types pdt on pdt.disposition_type_id = dd.disposition_type_id
        where a.process_by is not null
        and a.case_type_code = 'RFA'
        and 
        (
            (b.date_disposed BETWEEN '2020-07-15' AND '2024-12-31' and a.filed_date between '2018-01-01' AND '2024-12-31') or 
            (b.date_disposed is null and a.filed_date between '2020-07-15' AND '2024-12-31')
        )
        order by a.filed_date, a.process_by, b.date_disposed desc;"; */
    } else if ($report_list === "3") {
        $sql = "SELECT a.docket_number as `Docket number`, a.case_title as `Case title`, a.filed_date as `Filed date`, 
                CONCAT(d.fname, ' ', d.mname, ' ' , d.lname) AS `Labor Arbiter`
                FROM cases AS a
                LEFT JOIN dockets AS c ON a.docket_id = c.docket_id
                LEFT JOIN ects_core.users AS d ON a.process_by = d.user_id
                WHERE a.process_by IS NOT NULL";

        if ($case_type_code) {
            $conditions[] = 'a.case_type_code IN (' . implode(',', array_map(function ($case) {
                return "'$case'";
            }, $case_type_code)) . ')';
        }

        if ($org_code) {
            $conditions[] = 'd.org_code IN (' . implode(',', array_map(function ($org) {
                return "'$org'";
            }, $org_code)) . ')';
        }

        if ($start_date && $end_date) {
            $conditions[] = "a.filed_date BETWEEN '$start_date' AND '$end_date'";
        }

        $sql .= (count($conditions) > 0 ? ' AND ' . implode(' AND ', $conditions) : '') . " ORDER BY `Labor Arbiter` ASC ";
    } else if ($report_list === "4") {
        $sql = "SELECT 
                d.user_id AS `User id`, 
                d.username as `Username`,
                CONCAT(d.fname, ' ', d.mname, ' ', d.lname) as `Full Name`,
                d.org_code as `Organizational code`,
                COUNT(DISTINCT CASE WHEN b.date_disposed IS NULL THEN a.docket_id END) AS `Pending cases`, 
                d.status as `Status`
                FROM cases AS a
                LEFT JOIN dockets AS c ON a.docket_id = c.docket_id
                LEFT JOIN ects_core.users AS d ON a.process_by = d.user_id
                LEFT JOIN ects_core.user_roles ur ON ur.user_id = d.user_id
                LEFT JOIN (
                    SELECT bb.* 
                    FROM docket_disposition AS bb 
                    INNER JOIN (
                        SELECT docket_id, MIN(disposition_id) AS MaxDate 
                        FROM docket_disposition 
                        GROUP BY docket_id
                    ) xm ON bb.docket_id = xm.docket_id AND bb.disposition_id = xm.MaxDate
                ) AS b ON b.docket_id = a.docket_id
                WHERE 
                    CONCAT(d.username, d.lname, d.fname) LIKE '%$search%' AND d.status = 'STATUS_ACTIVE'
                    " . ($case_type_code ? ' AND a.case_type_code IN (' . implode(',', array_map(function ($case) {
            return "'$case'";
        }, $case_type_code)) . ')' : '') . "
                    " . ($org_code ? ' AND d.org_code IN (' . implode(',', array_map(function ($org) {
            return "'$org'";
        }, $org_code)) . ')' : '') . "
                    " . ($start_date && $end_date ? " AND a.filed_date BETWEEN '$start_date' AND '$end_date'" : '') . "
                GROUP BY d.fname, d.mname, d.lname
                ORDER BY `Full Name` DESC";
    } else if ($report_list === "6") {
        // a.filed_date as `Filed date`, 
        // b.date_disposed as `Date disposed`, 
        $sql = "SELECT a.docket_number AS `Docket number`, a.case_title AS `Case title`, 
        date_format(a.filed_date, '%Y') as `Filed year`,
        date_format(a.filed_date, '%m') as `Filed month`,
        date_format(a.filed_date, '%d') as `Filed day`,
        date_format(b.date_disposed, '%Y') as `Disposed year`,
        date_format(b.date_disposed, '%m') as `Disposed month`,
        date_format(b.date_disposed, '%d') as `Disposed day`,
        e.disposition_type as `Disposition type`, concat(d.fname, ' ', d.mname, ' ' , d.lname) as Conmed, c.org_code as `Organizational code`, b.created_date as `Created date`, b.remarks as `Remarks`, b.reason as `Reason`, z.comments as `Comments`        
        from cases as a
        left join dockets as c on a.docket_id = c.docket_id
        left join ects_core.users as d on a.process_by = d.user_id
        left join (select bb.* from docket_disposition as bb inner join (select docket_id, min(disposition_id) as MaxDate from docket_disposition group by docket_id ) xm on bb.docket_id = xm.docket_id and bb.disposition_id = xm.MaxDate) as b on b.docket_id = a.docket_id
        left join param_disposition_types as e on b.disposition_type_id = e.disposition_type_id
        left join (select zz.* from docket_comments as zz inner join (select docket_id, max(docket_comment_id) as MaxDate from docket_comments group by docket_id ) zm on zz.docket_id = zm.docket_id and zz.docket_comment_id = zm.MaxDate) as z on c.docket_id = z.docket_id
        where a.process_by is not null
        and a.case_type_code = 'RFA'
        " . ($start_date && $end_date ? " AND a.filed_date BETWEEN '$start_date' AND '$end_date'" : '') . "
        and not d.user_id = 769
        order by 3 asc;";
    } else if ($report_list === "7") {
        $sql = "WITH RankedCases AS (
    SELECT 
        c.org_code as `Organizational code`,
        a.docket_number as `Docket number`,
        a.case_title as `Case title`,
        DATE_FORMAT(a.filed_date, '%M %d, %Y') as `Filed date`,
        CONCAT(d.fname, ' ', d.mname, ' ' , d.lname) as LA,
        d.user_id as `User id`,
        ROW_NUMBER() OVER (PARTITION BY c.org_code ORDER BY a.filed_date) as rn
    FROM cases as a
    LEFT JOIN dockets as c ON a.docket_id = c.docket_id
    LEFT JOIN ects_core.users as d ON a.process_by = d.user_id
    LEFT JOIN (
        SELECT 
            bb.* 
        FROM docket_disposition as bb 
        INNER JOIN (
            SELECT 
                docket_id, 
                MIN(disposition_id) as MaxDate 
            FROM docket_disposition 
            GROUP BY docket_id
        ) xm ON bb.docket_id = xm.docket_id AND bb.disposition_id = xm.MaxDate
    ) as b ON b.docket_id = a.docket_id
    WHERE a.process_by IS NOT NULL
      AND a.case_type_code = 'CASE'
      " . ($org_code ? ' AND c.org_code IN (' . implode(',', array_map(function ($org) {
            return "'$org'";
        }, $org_code)) . ')' : '') . "
      " . ($start_date && $end_date ? " AND a.filed_date BETWEEN '$start_date' AND '$end_date'" : '') . "
      AND b.date_disposed IS NULL
      AND NOT d.user_id = 769
)
SELECT 
    `Organizational code`,
    `Filed date`,
    LA,
    `Case title`,
    `User id`
FROM RankedCases
WHERE rn = 1
ORDER BY `Filed date` ASC;
";
    } else if ($report_list === "8") {
        $sql = "SELECT concat(d.fname, ' ', d.mname, ' ' , d.lname) as LA, count(d.username) as `Count`, c.org_code as `Organization code`
        from cases as a
        left join dockets as c on a.docket_id = c.docket_id
        left join ects_core.users as d on a.process_by = d.user_id
        where a.process_by is not null
        and a.case_type_code = 'CASE'
        " . ($start_date && $end_date ? " AND a.filed_date BETWEEN '$start_date' AND '$end_date'" : '') . "
         " . ($org_code ? ' AND c.org_code IN (' . implode(',', array_map(function ($org) {
            return "'$org'";
        }, $org_code)) . ')' : '') . "
        and not d.user_id = 769
        group by d.username
        order by c.org_code, d.username asc;
        ";
    } else if ($report_list === "9") {
        $sql = "SELECT 
        d.user_id as `User id`, 
        d.username as `Username`,
        concat(d.fname, ' ', d.mname, ' ', d.lname) as `Full Name`,
        d.org_code as `RAB`,
        count(distinct a.docket_id) as `Total Cases`,
        count(distinct case when b.date_disposed is null then a.docket_id end) as `Pending cases`
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
        CONCAT(d.username, d.lname, d.fname) LIKE '%$search%' and d.status = 'STATUS_ACTIVE'
    and ur.role_code = 'LABOR_ARBITER'
    " . ($case_type_code ? ' and a.case_type_code IN (' . implode(',', array_map(function ($case) {
            return "'$case'";
        }, $case_type_code)) . ')' : '') . "

    " . ($org_code ? ' and d.org_code IN (' . implode(',', array_map(function ($org) {
            return "'$org'";
        }, $org_code)) . ')' : '') . "
    " . ($start_date && $end_date ? " and a.filed_date between '$start_date' and '$end_date'" : '') . "
    group by d.fname, d.mname, d.lname
    ;";
    } else if ($report_list === "10") {
        $sql = "SELECT (@cnt := @cnt + 1) AS `No`, c.case_id as `Case id`, c.case_title `Case title`, c.filed_date `Filed date`, dd.date_disposed `Date disposed`,
            TIMESTAMPDIFF(day, c.filed_date, dd.date_disposed) AS `Age`, pas.available_date , pdt.disposition_type AS `Disposition type`, dd.amount_peso, dd.award_type , u.user_id `user_id of process by`, concat(u.lname, ', ', u.fname, ' ', u.mname) as `LA`
        from cases c
        JOIN (SELECT @cnt := 0) AS dummy
        join dockets d on d.docket_id = c.docket_id
        left join docket_disposition dd on dd.docket_id = d.docket_id
        left join param_disposition_types pdt on pdt.disposition_type_id = dd.disposition_type_id
        join ects_core.users u on u.user_id = c.process_by
        join ects_core.user_roles ur on ur.user_id = u.user_id and ur.role_code = 'CON_MED'
        JOIN docket_tasks dt ON dt.docket_id = d.docket_id and dt.task_name like 'First con%'
        LEFT JOIN param_availability_schedule pas on pas.availability_schedule_id = dt.availability_schedule_id
        where c.case_type_code = 'RFA'
        " . ($start_date && $end_date ? " and c.filed_date between '$start_date' and '$end_date'" : '') . "
        and c.process_by = 1215 
        order by c.raffled_date asc
;";
    } else if ($report_list === "11") {
        $sql = "SELECT 
            d.docket_type_code, 
            d.org_code, 
            SUM(CASE WHEN dd.date_disposed IS NOT NULL THEN 1 ELSE 0 END) AS disposed_data,
            COUNT(d.org_code) AS total 
        FROM 
            dockets d
        LEFT JOIN 
            docket_disposition dd 
        ON 
            dd.docket_id = d.docket_id
        WHERE 
            d.docket_number IS NOT NULL 
            AND d.docket_type_code IN ('RFA', 'CASE') 
            AND d.org_code is not null
        GROUP BY 
            d.org_code, d.docket_type_code 
        ORDER BY 
           d.docket_type_code, d.org_code ASC;";
    } else if ($report_list === "12") {
        $sql = "SELECT (@cnt := @cnt + 1) AS `No`, 
        d.docket_number as `Case number`, c.case_title `Case title`, c.filed_date `Filed date`,
        date_format(c.filed_date, '%Y') as `Filed year`,
        date_format(c.filed_date, '%m') as `Filed month`,
        date_format(c.filed_date, '%d') as `Filed day`, 
        concat(u.fname, ' ', u.mname, ' ', u.lname) as `Conmed`,
        d.org_code
    from cases c
    JOIN (SELECT @cnt := 0) AS dummy
    join dockets d on d.docket_id = c.docket_id
    left join docket_disposition dd on dd.docket_id = d.docket_id
    join ects_core.users u on u.user_id = c.process_by
    join ects_core.user_roles ur on ur.user_id = u.user_id and ur.role_code = 'CON_MED'
    where c.case_type_code = 'RFA'
    " . ($start_date && $end_date ? " and c.filed_date between '$start_date' and '$end_date'" : '') . "
    and dd.disposition_id is null
    order by c.filed_date asc";
    } else if ($report_list === "13") {
        $sql = "SELECT 
            distinct d.docket_number AS `Docket_No`,
            c.case_title AS `Case_title`,
            CONCAT(la.lname, ', ', la.fname, ' ', LEFT(la.mname, 1), '.') AS `Labor_Arbiter`,
            d.org_code AS `Organization_code`,
            date_format(c.filed_date, '%Y-%m-%d') as `Filed_Date`
        FROM cases c 
        JOIN dockets d ON d.docket_id = c.docket_id
        JOIN case_parties cp ON cp.case_id = c.case_id
        JOIN parties p ON p.party_id = cp.party_id and cp.case_party_type LIKE 'C%'
        LEFT JOIN ects_core.users la ON la.user_id = c.process_by
        WHERE (SELECT COUNT(*) FROM case_parties WHERE case_id = c.case_id AND case_party_type LIKE 'P%') > 1 
        AND d.docket_number is not null 
        " . ($start_date && $end_date ? " and c.filed_date between '$start_date' and '$end_date'" : '') . "
         " . ($case_type_code ? ' and c.case_type_code IN (' . implode(',', array_map(function ($case) {
            return "'$case'";
        }, $case_type_code)) . ')' : '') . "
        " . ($org_code ? ' and d.org_code IN (' . implode(',', array_map(function ($org) {
            return "'$org'";
        }, $org_code)) . ')' : " AND d.org_code != 'NCR'") . "
        order by trim(d.org_code), trim(p.company_name), 3 ASC;";
    } else if ($report_list === "14") {
        $sql = "SELECT
            d.org_code as `Organizational code`,
            DATE_FORMAT(c.filed_date, '%m-%Y') as `Filed date`,
            concat(u.fname, ' ', u.mname, ' ', u.lname) as `Full Name`,
            COUNT(distinct d.docket_id) as `Cases count`
        FROM cases c
        JOIN dockets d on d.docket_id = c.docket_id
        JOIN ects_core.users u on u.user_id = c.process_by
        where c.process_by is not null
        " . ($org_code ? ' and d.org_code IN (' . implode(',', array_map(function ($org) {
            return "'$org'";
        }, $org_code)) . ')' : " AND d.org_code != 'NCR'") . "
        " . ($start_date && $end_date ? " and c.filed_date between '$start_date' and '$end_date'" : '') . "
        group by u.user_id, `Filed date`
        ;";
    } else if ($report_list === "15") {
        $sql = "SELECT a.case_type_code as `Case type code`, c.org_code as `Rab`, a.docket_number AS `Docket number`, a.case_title AS `Case title`, a.filed_date AS `Filed date`, concat(d.fname, ' ', d.mname, ' ' , d.lname) as LA
        from cases as a
        left join dockets as c on a.docket_id = c.docket_id
        left join ects_core.users as d on a.process_by = d.user_id
        left join (select bb.* from docket_disposition as bb inner join (select docket_id, min(disposition_id) as MaxDate from docket_disposition group by docket_id ) xm on bb.docket_id = xm.docket_id and bb.disposition_id = xm.MaxDate) as b on b.docket_id = a.docket_id
        where a.process_by is not null
        and a.filed_date between '2019-05-01' AND '2024-12-31'
        and b.date_disposed is null
        and not d.user_id = 769
        " . ($case_type_code ? ' and a.case_type_code IN (' . implode(',', array_map(function ($case) {
            return "'$case'";
        }, $case_type_code)) . ')' : '') . "

    " . ($org_code ? ' and d.org_code IN (' . implode(',', array_map(function ($org) {
            return "'$org'";
        }, $org_code)) . ')' : '') . "
  
        order by a.filed_date asc limit 10;";
    } else {
        echo json_encode(['error' => 'Select a report to generate']);
        exit;
    }
    echo datatb($sql);
}


if (isset($_POST['setpages'])) {
    $sql = "";

    if ($report_list === "1") {
        $sql = "SELECT count(*)
        from cases as a
        left join dockets as c on a.docket_id = c.docket_id
        left join ects_core.users as d on a.process_by = d.user_id
        left join (select aaa.case_id, COUNT(*) AS Total from case_parties as aaa left join parties as bbb on aaa.party_id = bbb.party_id where bbb.sex_flag = 'M' group by aaa.case_id) as g on g.case_id = a.case_id 
        left join (select aaa.case_id, COUNT(*) AS Total from case_parties as aaa left join parties as bbb on aaa.party_id = bbb.party_id where bbb.sex_flag = 'F' group by aaa.case_id) as f on f.case_id = a.case_id
        left join (select bb.* from docket_disposition as bb inner join (select docket_id, min(disposition_id) as MaxDate from docket_disposition group by docket_id ) xm on bb.docket_id = xm.docket_id and bb.disposition_id = xm.MaxDate) as b on b.docket_id = a.docket_id
        left join param_disposition_types as e on b.disposition_type_id = e.disposition_type_id
        left join (SELECT ccc.case_id, GROUP_CONCAT(DISTINCT ccc.poopi SEPARATOR '|') as actioni FROM (select aaa.case_id, if(bbb.others_flag = 'Y',concat(bbb.action_cause_short_name, ' - ', aaa.action_cause_others),bbb.action_cause_short_name) as poopi from case_action_causes as aaa left join param_action_causes as bbb on aaa.action_cause_id = bbb.action_cause_id) as ccc GROUP BY ccc.case_id) as h on h.case_id = a.case_id
        where a.process_by is not null
        " . ($case_type_code ? ' and a.case_type_code IN (' . implode(',', array_map(function ($case) {
            return "'$case'";
        }, $case_type_code)) . ')' : '') . "

    " . ($org_code ? ' and d.org_code IN (' . implode(',', array_map(function ($org) {
            return "'$org'";
        }, $org_code)) . ')' : '') . "
    " . ($start_date && $end_date ? " and a.filed_date between '$start_date' and '$end_date'" : '') . "
        or (h.actioni like '%$search%')
        or a.docket_number like '%$search%'
        ";
    } else if ($report_list === "3") {
        $sql = "SELECT COUNT(*)
        from cases as a
        left join dockets as c on a.docket_id = c.docket_id
        left join ects_core.users as d on a.process_by = d.user_id
        where a.process_by is not null
        " . ($case_type_code ? ' and a.case_type_code IN (' . implode(',', array_map(function ($case) {
            return "'$case'";
        }, $case_type_code)) . ')' : '') . "
        " . ($org_code ? ' and d.org_code IN (' . implode(',', array_map(function ($org) {
            return "'$org'";
        }, $org_code)) . ')' : '') . "
        " . ($start_date && $end_date ? " and a.filed_date between '$start_date' and '$end_date'" : '') . "
        ";
    } else if ($report_list === "4") {
        $sql = "SELECT 
        COUNT(DISTINCT d.user_id) as total_count
    FROM cases as a
    LEFT JOIN dockets as c on a.docket_id = c.docket_id
    LEFT JOIN ects_core.users as d on a.process_by = d.user_id
    LEFT JOIN ects_core.user_roles ur on ur.user_id = d.user_id
    LEFT JOIN (
        SELECT 
            bb.* 
        FROM 
            docket_disposition as bb 
        INNER JOIN (
            SELECT 
                docket_id, MIN(disposition_id) as MaxDate 
            FROM 
                docket_disposition 
            GROUP BY 
                docket_id
        ) xm on bb.docket_id = xm.docket_id and bb.disposition_id = xm.MaxDate
    ) as b on b.docket_id = a.docket_id
    WHERE 
        CONCAT(d.username, d.lname, d.fname) LIKE '%$search%'
        " . ($case_type_code ? ' and a.case_type_code IN (' . implode(',', array_map(function ($case) {
            return "'$case'";
        }, $case_type_code)) . ')' : '') . "

    " . ($org_code ? ' and d.org_code IN (' . implode(',', array_map(function ($org) {
            return "'$org'";
        }, $org_code)) . ')' : '') . "
    " . ($start_date && $end_date ? " and a.filed_date between '$start_date' and '$end_date'" : '') . "
        ";
    } else if ($report_list === "") {
        echo '<option value="0">0</option>';
        exit;
    }

    echo pages($sql, $entries);
}
