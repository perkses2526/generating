use ects;

-- SELECT * FROM ects.case_reliefs where relief_others like '%DISABILITY BENEFITS AND SICKWAGE ALLOWANCE%';

SELECT a.docket_number, a.case_title, a.filed_date, b.date_disposed, e.disposition_type, 
       CONCAT(d.fname, ' ', d.mname, ' ', d.lname) AS LA, c.org_code, b.created_date, h.actioni
FROM cases AS a
LEFT JOIN dockets AS c ON a.docket_id = c.docket_id
LEFT JOIN ects_core.users AS d ON a.process_by = d.user_id
LEFT JOIN (
    SELECT bb.* 
    FROM docket_disposition AS bb 
    INNER JOIN (
        SELECT docket_id, MIN(disposition_id) AS MaxDate 
        FROM docket_disposition 
        GROUP BY docket_id
    ) xm ON bb.docket_id = xm.docket_id AND bb.disposition_id = xm.MaxDate
) AS b ON b.docket_id = a.docket_id
LEFT JOIN param_disposition_types AS e ON b.disposition_type_id = e.disposition_type_id
LEFT JOIN (
    SELECT ccc.case_id, GROUP_CONCAT(DISTINCT ccc.poopi SEPARATOR '|') AS actioni 
    FROM (
        SELECT aaa.case_id, 
               IF(bbb.others_flag = 'Y', CONCAT(bbb.action_cause_short_name, ' - ', aaa.action_cause_others), bbb.action_cause_short_name) AS poopi 
        FROM case_action_causes AS aaa 
        LEFT JOIN param_action_causes AS bbb ON aaa.action_cause_id = bbb.action_cause_id
    ) AS ccc 
    GROUP BY ccc.case_id
) AS h ON h.case_id = a.case_id
WHERE a.case_type_code = 'CASE'
AND a.filed_date BETWEEN '2019-05-01' AND '2019-12-31'
AND (h.actioni LIKE '%disa%')
ORDER BY a.filed_date ASC;
