use ects;

SELECT DISTINCT position
FROM ects.parties
WHERE position REGEXP 'technical|encoder|tsr|t.s.r|system|data control|web|data entry|tech support|it support|it officer|it|quality analyst'
  AND position REGEXP 'BPO|BPM' order by position asc;
  
  select pc.* from cases c
  join dockets d on c.docket_id = d.docket_id
  LEFT JOIN case_action_causes cac ON cac.case_id = c.case_id
  LEFT JOIN param_action_causes pc ON pc.action_cause_id = cac.action_cause_id
  where d.docket_number = 'NCR-01-00106-16'
  ; 
  
  -- SELECT
--     d.docket_number AS `Docket number`,
--     c.case_title AS `Case title`,
--     IF(pc.others_flag = 'Y', CONCAT(pc.action_cause_name, ' - ', IFNULL(cac.action_cause_others, '')), pc.action_cause_name) AS `Action Cause`,
--     IFNULL(pd.disposition_type, 'Pending') AS `Disposition status`,
--     d.org_code AS `Organization code`,
--     p.position AS `Position`, 
--     c.filed_date AS `Filed date`
-- FROM
--     cases c
--     LEFT JOIN dockets d ON d.docket_id = c.docket_id
--     LEFT JOIN case_parties cp ON cp.case_id = c.case_id
--     LEFT JOIN parties p ON p.party_id = cp.party_id
--     LEFT JOIN case_action_causes cac ON cac.case_id = c.case_id
--     LEFT JOIN param_action_causes pc ON pc.action_cause_id = cac.action_cause_id
--     LEFT JOIN docket_disposition dd ON dd.docket_id = d.docket_id
--     LEFT JOIN param_disposition_types pd ON pd.disposition_type_id = dd.disposition_type_id
-- WHERE
--     p.position REGEXP 'technical|encoder|tsr|t.s.r|system|data control|web|data entry|tech support|it support|it officer|it|quality analyst'
--     AND p.position REGEXP 'BPO|BPM'
-- ORDER BY
--     d.org_code, c.filed_date ASC;
  
  -- SELECT 
--         distinct
--         c.docket_number AS case_no,
--         p.position,
--         GROUP_CONCAT(DISTINCT IF(pac.others_flag = 'Y', 
--                         CONCAT(pac.action_cause_short_name, ' - ', cac.action_cause_others), 
--                         pac.action_cause_short_name
--                         )) as causes, 
--         IFNULL(k.disposition_type, 'PENDING') AS disposition_status,
--         COUNT(DISTINCT pd.party_id) AS `No of workers`
--     FROM 
--         cases c
--     INNER JOIN 
--         dockets d ON d.docket_id = c.docket_id
--     INNER JOIN 
--         case_parties cp ON cp.case_id = c.case_id
--     LEFT JOIN 
--         case_parties pd ON pd.case_id = c.case_id AND pd.case_party_type LIKE 'P%'
--     INNER JOIN 
--         parties p ON p.party_id = cp.party_id
--     LEFT JOIN 
--         (
--             SELECT 
--                 zz.* 
--             FROM 
--                 docket_disposition zz
--             INNER JOIN 
--                 (
--                     SELECT 
--                         docket_id, 
--                         MAX(disposition_id) AS MaxDate 
--                     FROM 
--                         docket_disposition 
--                     GROUP BY 
--                         docket_id
--                 ) xm 
--                 ON zz.docket_id = xm.docket_id 
--                 AND zz.disposition_id = xm.MaxDate
--         ) z ON z.docket_id = c.docket_id
--     LEFT JOIN 
--         param_disposition_types k ON k.disposition_type_id = z.disposition_type_id
--     LEFT JOIN case_action_causes cac ON cac.case_id = c.case_id
--     LEFT JOIN param_action_causes pac ON pac.action_cause_id = cac.action_cause_id
-- WHERE
--    (
--         p.position LIKE '%technical%' OR
--         p.position LIKE '%encoder%' OR
--         p.position LIKE '%tsr%' OR
--         p.position LIKE '%t.s.r%' OR
--         p.position LIKE '%system%' OR
--         p.position LIKE '%data control%' OR
--         p.position LIKE '%web%' OR
--         p.position LIKE '%data entry%' OR
--         p.position LIKE '%tech support%' OR
--         p.position LIKE '%it support%' OR
--         p.position LIKE '%it officer%' OR
--         p.position LIKE '%it%' OR
--         p.position LIKE '%quality analyst%'
--     )
--     and c.process_by is not null
--     GROUP BY 
--         c.docket_number, 
--         c.case_title, 
--         p.position, 
--         c.filed_date, 
--         k.disposition_type
-- ORDER BY
--     d.org_code, c.filed_date ASC;

SET SESSION net_read_timeout=600;
SET SESSION net_write_timeout=600;
SET SESSION group_concat_max_len = 1000000;

SELECT 
    c.docket_number, p.position
FROM 
    cases c
INNER JOIN 
    case_parties cp ON cp.case_id = c.case_id
INNER JOIN 
    parties p ON p.party_id = cp.party_id
WHERE
    p.position LIKE '%technical%' 
    AND c.process_by IS NOT NULL; -- Use limit for faster results during testing

SELECT DISTINCT
    c.case_type_code as `Case type`,
    c.docket_number AS `Case number`,
    c.case_title as `Case title`,
    GROUP_CONCAT(DISTINCT p.position) as `Position`,
    p2.company_name as `Company name`,
    GROUP_CONCAT(DISTINCT IF(pac.others_flag = 'Y', 
                        CONCAT(pac.action_cause_short_name, ' - ', cac.action_cause_others), 
                        pac.action_cause_short_name)) AS Causes, 
    IFNULL(k.disposition_type, 'PENDING') AS `Disposition status`,
    c.filed_date as `Date Filed`
FROM 
    cases c
INNER JOIN 
    dockets d ON d.docket_id = c.docket_id
INNER JOIN 
    case_parties cp2 ON cp2.case_id = c.case_id
INNER JOIN 
    parties p2 ON p.party_id = cp2.party_id
INNER JOIN 
    case_parties cp ON cp.case_id = c.case_id
INNER JOIN 
    parties p ON p.party_id = cp.party_id
LEFT JOIN 
    (
        SELECT 
            zz.docket_id, 
            zz.disposition_type_id
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
LEFT JOIN 
    case_action_causes cac ON cac.case_id = c.case_id
LEFT JOIN 
    param_action_causes pac ON pac.action_cause_id = cac.action_cause_id
WHERE
    c.filed_date BETWEEN '2019-04-01' AND '2024-07-31' 
    AND p.position LIKE '%BPO%'
    AND c.process_by IS NOT NULL
GROUP BY 
    c.docket_number, c.case_type_code, c.case_title, 
    IFNULL(k.disposition_type, 'PENDING'), c.filed_date
ORDER BY
    d.org_code, c.filed_date ASC;



SELECT DISTINCT
	c.docket_number AS `Case number`,
 	c.case_type_code as `Case type`,
    c.case_title as `Case title`,
    p.position as `Position`,
    GROUP_CONCAT(DISTINCT IF(pac.others_flag = 'Y', 
                    CONCAT(pac.action_cause_short_name, ' - ', cac.action_cause_others), 
                    pac.action_cause_short_name)) AS Causes, 
    IFNULL(k.disposition_type, 'PENDING') AS `Disposition status`,
    c.filed_date as `Date Filed`
    -- ,    COUNT(DISTINCT pd.party_id) AS `No of workers`
FROM 
    cases c
INNER JOIN 
    dockets d ON d.docket_id = c.docket_id
INNER JOIN 
    case_parties cp ON cp.case_id = c.case_id
-- LEFT JOIN 
--     case_parties pd ON pd.case_id = c.case_id AND pd.case_party_type LIKE 'P%'
INNER JOIN 
    parties p ON p.party_id = cp.party_id
LEFT JOIN 
    (
        SELECT 
            zz.docket_id, 
            zz.disposition_type_id
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
LEFT JOIN 
    case_action_causes cac ON cac.case_id = c.case_id
LEFT JOIN 
    param_action_causes pac ON pac.action_cause_id = cac.action_cause_id
WHERE
	c.filed_date between '2019-04-01' and '2024-07-31' and 
    p.position LIKE '%BPO%' 
    -- OR
    -- p.position LIKE '%encoder%' OR
--     p.position LIKE '%tsr%' OR
--     p.position LIKE '%t.s.r%' OR
--     p.position LIKE '%system%' OR
--     p.position LIKE '%data control%' OR
--     p.position LIKE '%web%' OR
--     p.position LIKE '%data entry%' OR
--     p.position LIKE '%tech support%' OR
--     p.position LIKE '%it support%' OR
--     p.position LIKE '%it officer%' OR
--     p.position LIKE '%it %' OR
--     p.position LIKE '%quality analyst%'
    AND c.process_by IS NOT NULL
GROUP BY 
    c.docket_number,
    c.case_title
ORDER BY
    d.org_code, c.filed_date ASC;
    
--     c.docket_number AS case_no,
--     p.position,
--     GROUP_CONCAT(DISTINCT IF(pac.others_flag = 'Y', 
--                     CONCAT(pac.action_cause_short_name, ' - ', cac.action_cause_others), 
--                     pac.action_cause_short_name)) AS causes, 
--     IFNULL(k.disposition_type, 'PENDING') AS disposition_status,
--     COUNT(DISTINCT pd.party_id) AS `No of workers`


    
    
    

SELECT
    DATE_FORMAT(c.filed_date, '%Y-%M') AS `Year-Month`,
    d.org_code as `Organizational code`,
    pac.action_cause_name as `Cause`,
    COUNT(DISTINCT c.case_id) AS `Case count` ,
    SUM(CASE WHEN dd.disposition_type_id is not null THEN 1 ELSE 0 END) AS `Cases resolved`
FROM
    cases c
    LEFT JOIN dockets d ON d.docket_id = c.docket_id
    LEFT JOIN case_parties cp ON cp.case_id = c.case_id
    LEFT JOIN parties p ON p.party_id = cp.party_id
    LEFT JOIN case_action_causes cac ON cac.case_id = c.case_id
    LEFT JOIN param_action_causes pac ON pac.action_cause_id = cac.action_cause_id
    LEFT JOIN docket_disposition dd ON dd.docket_id = d.docket_id
WHERE
    p.position REGEXP 'technical|encoder|tsr|t.s.r|system|data control|web|data entry|tech support|it support|it officer|it|quality analyst'
    AND p.position REGEXP 'BPO|BPM'
group by d.docket_id
ORDER BY
    MIN(c.filed_date) ASC;
    
    select * from parties order by party_id desc;