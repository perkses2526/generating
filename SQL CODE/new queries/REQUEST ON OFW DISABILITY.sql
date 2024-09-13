use ects;

select * from cases where created_date >= '2024-06-01' and docket_number like '-2023%';

select * from dockets where created_date >= '2024-06-01' and created_date like '%2023%';
select * from dockets where org_code = 'RABVI' and docket_type_code = 'RFA' and created_date >= '2024-06-01' order by created_date desc;
select * from dockets where docket_type_code = 'RFA' and docket_number like '%-23' and created_date >= '2024-06-01';

-- SELECT * FROM dockets;

-- SELECT * FROM cases;

-- SELECT c.case_title, pc.action_cause_name 
-- FROM case_action_causes cac 
-- JOIN cases c ON c.case_id = cac.case_id 
-- JOIN param_action_causes pc ON pc.action_cause_id = cac.case_action_cause_id 
-- WHERE pc.action_cause_id = 204;

-- SELECT *
-- FROM cases
-- WHERE employment_type_flag = 'OFW'
-- AND filed_date BETWEEN '2019-01-01' AND '2023-12-31';

-- distinct d.docket_number AS `Docket no.`,
--     CONCAT(p.last_name, ', ', p.first_name) AS `Respondent`,
--     pd.disposition_type AS `Disposition`,
--     dd.won_by AS `Won by`,
--     dd.amount_awarded AS `Award`,
--     if(pc.others_flag = 'Y', concat(pc.action_cause_short_name, ' - ', cac.action_cause_others) ,pc.action_cause_short_name) as `Cause`,
-- 	c.filed_date as `Filed date

SELECT 
        DISTINCT d.docket_number,
        c.filed_date,
        dd.won_by,
        d.org_code,
        pd.disposition_type,
        IF(pc.others_flag = 'Y', CONCAT(IFNULL(pc.action_cause_name, ''), ' - ', IFNULL(cac.action_cause_others, '')), pc.action_cause_name) AS `Cause`,
        pc.action_cause_name as `orig`
    FROM 
        cases c
    LEFT JOIN 
        dockets d ON d.docket_id = c.docket_id
    LEFT JOIN 
        case_parties cp ON cp.case_id = c.case_id AND cp.case_party_type LIKE 'P%'
    LEFT JOIN 
        parties p ON p.party_id = cp.party_id
    LEFT JOIN 
        party_employments pe ON pe.party_id = p.party_id
    LEFT JOIN 
        docket_disposition dd ON dd.docket_id = c.docket_id
    LEFT JOIN 
        param_disposition_types pd ON pd.disposition_type_id = dd.disposition_type_id
    LEFT JOIN 
        case_action_causes cac ON cac.case_id = c.case_id
    LEFT JOIN 
        param_action_causes pc ON pc.action_cause_id = cac.action_cause_id 
    WHERE 
        pe.deploy_nature_code = 'SB' 
        AND (
            (IF(pc.others_flag = 'Y', CONCAT(IFNULL(pc.action_cause_name, ''), ' - ', IFNULL(cac.action_cause_others, '')), pc.action_cause_name) LIKE '%death%')
            OR
            (IF(pc.others_flag = 'Y', CONCAT(IFNULL(pc.action_cause_name, ''), ' - ', IFNULL(cac.action_cause_others, '')), pc.action_cause_name) LIKE '%disability%')
            OR 
            (IF(pc.others_flag = 'Y', CONCAT(IFNULL(pc.action_cause_name, ''), ' - ', IFNULL(cac.action_cause_others, '')), pc.action_cause_name) LIKE '%unfair%')
            OR
            (IF(pc.others_flag = 'Y', CONCAT(IFNULL(pc.action_cause_name, ''), ' - ', IFNULL(cac.action_cause_others, '')), pc.action_cause_name) LIKE '%illegal%')
            OR
            (IF(pc.others_flag = 'Y', CONCAT(IFNULL(pc.action_cause_name, ''), ' - ', IFNULL(cac.action_cause_others, '')), pc.action_cause_name) LIKE '%non-payment%')
            OR
            (IF(pc.others_flag = 'Y', CONCAT(IFNULL(pc.action_cause_name, ''), ' - ', IFNULL(cac.action_cause_others, '')), pc.action_cause_name) LIKE '%money claims%' 
            AND 
            IF(pc.others_flag = 'Y', CONCAT(IFNULL(pc.action_cause_name, ''), ' - ', IFNULL(cac.action_cause_others, '')), pc.action_cause_name) LIKE '%illegal dismissal%')
            OR
            (IF(pc.others_flag = 'Y', CONCAT(IFNULL(pc.action_cause_name, ''), ' - ', IFNULL(cac.action_cause_others, '')), pc.action_cause_name) LIKE '%others%')
        )
        AND c.employment_type_flag = 'OFW'
        AND c.case_type_code = 'CASE'
        AND c.filed_date BETWEEN '2020-01-01' AND '2023-12-31'
        GROUP BY 1
        ;

SELECT 
    distinct_cases.org_code AS `Organization code`,
    DATE_FORMAT(distinct_cases.filed_date, '%Y-%m') AS `Year Month`,
    SUM(CASE 
        WHEN distinct_cases.cause LIKE '%death%' THEN 1 
        ELSE 0 
    END) AS `Death benefits`,
    SUM(CASE 
        WHEN distinct_cases.cause LIKE '%disability%' THEN 1 
        ELSE 0 
    END) AS `Disability claims`,
    SUM(CASE 
        WHEN distinct_cases.cause LIKE '%unfair%' THEN 1 
        ELSE 0 
    END) AS `Unfair Labor Practices`,
    SUM(CASE 
        WHEN distinct_cases.cause LIKE '%illegal d%'THEN 1 
        ELSE 0 
    END) AS `Illegal Dismissal`,
    SUM(CASE 
        WHEN distinct_cases.cause LIKE '%non-payment%' THEN 1 
        ELSE 0 
    END) AS `Non-payment of wages`,
    SUM(CASE 
        WHEN distinct_cases.cause LIKE '%money%'
        -- and distinct_cases.cause LIKE '%ill%'
        THEN 1 
        ELSE 0 
    END) AS `Illegal dismissal with non-payment of wages`,
    SUM(CASE 
        WHEN distinct_cases.cause LIKE '%others%' THEN 1 
        ELSE 0 
    END) AS `Others`
FROM (
    SELECT 
        DISTINCT d.docket_number,
        c.filed_date,
        dd.won_by,
        d.org_code,
        pd.disposition_type,
        IF(pc.others_flag = 'Y', CONCAT(IFNULL(pc.action_cause_name, ''), ' - ', IFNULL(cac.action_cause_others, '')), pc.action_cause_name) AS `Cause`,
        pc.action_cause_name as `orig`
    FROM 
        cases c
    LEFT JOIN 
        dockets d ON d.docket_id = c.docket_id
    LEFT JOIN 
        case_parties cp ON cp.case_id = c.case_id AND cp.case_party_type LIKE 'P%'
    LEFT JOIN 
        parties p ON p.party_id = cp.party_id
    LEFT JOIN 
        party_employments pe ON pe.party_id = p.party_id
    LEFT JOIN 
        docket_disposition dd ON dd.docket_id = c.docket_id
    LEFT JOIN 
        param_disposition_types pd ON pd.disposition_type_id = dd.disposition_type_id
    LEFT JOIN 
        case_action_causes cac ON cac.case_id = c.case_id
    LEFT JOIN 
        param_action_causes pc ON pc.action_cause_id = cac.action_cause_id 
    WHERE 
        pe.deploy_nature_code = 'SB' 
        AND (
            (IF(pc.others_flag = 'Y', CONCAT(IFNULL(pc.action_cause_name, ''), ' - ', IFNULL(cac.action_cause_others, '')), pc.action_cause_name) LIKE '%death%')
            OR
            (IF(pc.others_flag = 'Y', CONCAT(IFNULL(pc.action_cause_name, ''), ' - ', IFNULL(cac.action_cause_others, '')), pc.action_cause_name) LIKE '%disability%')
            OR 
            (IF(pc.others_flag = 'Y', CONCAT(IFNULL(pc.action_cause_name, ''), ' - ', IFNULL(cac.action_cause_others, '')), pc.action_cause_name) LIKE '%unfair%')
            OR
            (IF(pc.others_flag = 'Y', CONCAT(IFNULL(pc.action_cause_name, ''), ' - ', IFNULL(cac.action_cause_others, '')), pc.action_cause_name) LIKE '%illegal%')
            OR
            (IF(pc.others_flag = 'Y', CONCAT(IFNULL(pc.action_cause_name, ''), ' - ', IFNULL(cac.action_cause_others, '')), pc.action_cause_name) LIKE '%non-payment%')
            OR
            (IF(pc.others_flag = 'Y', CONCAT(IFNULL(pc.action_cause_name, ''), ' - ', IFNULL(cac.action_cause_others, '')), pc.action_cause_name) LIKE '%money claims%' 
            AND 
            IF(pc.others_flag = 'Y', CONCAT(IFNULL(pc.action_cause_name, ''), ' - ', IFNULL(cac.action_cause_others, '')), pc.action_cause_name) LIKE '%illegal dismissal%')
            OR
            (IF(pc.others_flag = 'Y', CONCAT(IFNULL(pc.action_cause_name, ''), ' - ', IFNULL(cac.action_cause_others, '')), pc.action_cause_name) LIKE '%others%')
        )
        AND c.employment_type_flag = 'OFW'
        AND c.case_type_code = 'CASE'
        AND c.filed_date BETWEEN '2020-01-01' AND '2023-12-31'
) AS distinct_cases
GROUP BY 
    2, distinct_cases.org_code
ORDER BY 
    2, distinct_cases.org_code ASC;


DESCRIBE case_action_causes;

select distinct action_cause_others from case_action_causes;


SELECT * FROM param_action_causes;
-- RESPONDENT 
use ects;


SELECT 
    Cause,
    COUNT(*) AS `Number of cases`,
    GROUP_CONCAT(`Docket number` ORDER BY `Filed date` ASC) AS `Docket numbers`
FROM (
    SELECT 
        d.docket_number AS `Docket number`,
        p.company_name AS `Respondent`,
        pd.disposition_type AS `Disposition type`,
        dd.won_by AS `Won by`,
        dd.amount_awarded AS `Amount awarded`,
        d.org_code AS `Organization code`,
        c.filed_date AS `Filed date`,
        pc.action_cause_name as `Cause`
        -- IF(pc.others_flag = 'Y', CONCAT(IFNULL(pc.action_cause_name, ''), IFNULL(cac.action_cause_others, '')), pc.action_cause_name) AS `Cause`
    FROM dockets d 
    JOIN cases c ON c.docket_id = d.docket_id
    JOIN case_parties cp1 ON cp1.case_id = c.case_id AND cp1.case_party_type LIKE 'P%'
    JOIN party_employments pe ON pe.party_id = cp1.party_id AND pe.deploy_nature_code = 'SB' 
    JOIN case_parties cp2 ON cp2.case_id = c.case_id AND cp2.case_party_type LIKE 'C%'
    JOIN parties p ON p.party_id = cp2.party_id
    LEFT JOIN docket_disposition dd ON dd.docket_id = c.docket_id
    LEFT JOIN param_disposition_types pd ON pd.disposition_type_id = dd.disposition_type_id
    LEFT JOIN case_action_causes cac ON cac.case_id = c.case_id
    LEFT JOIN param_action_causes pc ON pc.action_cause_id = cac.action_cause_id 
    WHERE 
        (
            (pc.others_flag = 'Y' AND CONCAT(pc.action_cause_short_name, ' - ', cac.action_cause_others) LIKE '%disa%')
            OR
            (pc.others_flag != 'Y' AND pc.action_cause_short_name LIKE '%death%')
            OR 
            (pc.others_flag != 'Y' AND pc.action_cause_short_name LIKE '%unfair%')
            OR
            (pc.others_flag != 'Y' AND pc.action_cause_short_name LIKE '%illegal%')
            OR
            (pc.others_flag != 'Y' AND pc.action_cause_short_name LIKE '%non-payment%')
            OR
            (pc.others_flag != 'Y' AND pc.action_cause_short_name LIKE '%only%')
            OR
            (pc.others_flag != 'Y' AND pc.action_cause_short_name LIKE '%wages%')
            OR
            (pc.others_flag != 'Y' AND pc.action_cause_short_name LIKE '%id w%')
        )
        AND c.employment_type_flag = 'OFW'
        AND c.case_type_code = 'CASE'
        AND c.filed_date BETWEEN '2020-01-01' AND '2023-12-31'
    GROUP BY 
        d.docket_number
) subquery
GROUP BY 
    Cause
ORDER BY 
    Cause;


SELECT 
	d.docket_number AS `Docket number`,
    p.company_name AS `Respondent`,
    pd.disposition_type AS `Disposition type`,
    dd.won_by AS `Won by`,
    dd.amount_awarded AS `Amount awarded`,
    d.org_code AS `Organization code`,
    c.filed_date AS `Filed date`,
    IF(pc.others_flag = 'Y', CONCAT(IFNULL(pc.action_cause_name, ''), IFNULL(cac.action_cause_others, '')), pc.action_cause_name) AS `Cause`
from dockets d 
join cases c on c.docket_id = d.docket_id
join case_parties cp1 on cp1.case_id = c.case_id and cp1.case_party_type like 'P%'
join party_employments pe on pe.party_id = cp1.party_id and pe.deploy_nature_code = 'SB' 
join case_parties cp2 on cp2.case_id = c.case_id and cp2.case_party_type like 'C%'
join parties p on p.party_id = cp2.party_id
LEFT JOIN docket_disposition dd ON dd.docket_id = c.docket_id
LEFT JOIN param_disposition_types pd ON pd.disposition_type_id = dd.disposition_type_id
LEFT JOIN case_action_causes cac ON cac.case_id = c.case_id
LEFT JOIN param_action_causes pc ON pc.action_cause_id = cac.action_cause_id 
where 
    (
            (IF(pc.others_flag = 'Y', CONCAT(IFNULL(pc.action_cause_name, ''), ' - ', IFNULL(cac.action_cause_others, '')), pc.action_cause_name) LIKE '%death%')
            OR
            (IF(pc.others_flag = 'Y', CONCAT(IFNULL(pc.action_cause_name, ''), ' - ', IFNULL(cac.action_cause_others, '')), pc.action_cause_name) LIKE '%disability%')
            OR 
            (IF(pc.others_flag = 'Y', CONCAT(IFNULL(pc.action_cause_name, ''), ' - ', IFNULL(cac.action_cause_others, '')), pc.action_cause_name) LIKE '%unfair%')
            OR
            (IF(pc.others_flag = 'Y', CONCAT(IFNULL(pc.action_cause_name, ''), ' - ', IFNULL(cac.action_cause_others, '')), pc.action_cause_name) LIKE '%illegal%')
            OR
            (IF(pc.others_flag = 'Y', CONCAT(IFNULL(pc.action_cause_name, ''), ' - ', IFNULL(cac.action_cause_others, '')), pc.action_cause_name) LIKE '%non-payment%')
            OR
            (IF(pc.others_flag = 'Y', CONCAT(IFNULL(pc.action_cause_name, ''), ' - ', IFNULL(cac.action_cause_others, '')), pc.action_cause_name) LIKE '%money claims%' 
            AND 
            IF(pc.others_flag = 'Y', CONCAT(IFNULL(pc.action_cause_name, ''), ' - ', IFNULL(cac.action_cause_others, '')), pc.action_cause_name) LIKE '%illegal dismissal%')
            OR
            (IF(pc.others_flag = 'Y', CONCAT(IFNULL(pc.action_cause_name, ''), ' - ', IFNULL(cac.action_cause_others, '')), pc.action_cause_name) LIKE '%others%')
        )
    -- (IF(pc.others_flag = 'Y', CONCAT(pc.action_cause_short_name, ' - ', cac.action_cause_others), pc.action_cause_short_name)) LIKE IN('%disa%')
    AND c.employment_type_flag = 'OFW'
    AND c.case_type_code = 'CASE'
    AND c.filed_date BETWEEN '2020-01-01' AND '2023-12-31'
    -- and pd.disposition_type is null
GROUP BY 
    d.docket_number
ORDER BY 
    d.org_code, c.filed_date ASC;


--  COMPLAINANT
SELECT 
    d.docket_number AS `Docket number`,
    p.company_name AS `Complainant`,
    pd.disposition_type AS `Disposition type`,
    dd.won_by AS `Won by`,
    dd.amount_awarded AS `Amount awarded`,
    d.org_code AS `Organization code`,
    c.filed_date AS `Filed date`,
    IF(pc.others_flag = 'Y', CONCAT(IFNULL(pc.action_cause_name, ''), IFNULL(cac.action_cause_others, '')), pc.action_cause_name) AS `Cause`
FROM 
    cases c
LEFT JOIN 
    dockets d ON d.docket_id = c.docket_id
LEFT JOIN 
    case_parties cp ON cp.case_id = c.case_id and cp.case_party_type like 'C%'
LEFT JOIN 
    parties p ON p.party_id = cp.party_id
LEFT JOIN 
    party_employments pe ON pe.party_id = p.party_id
 LEFT JOIN 
    docket_disposition dd ON dd.docket_id = c.docket_id
LEFT JOIN 
    param_disposition_types pd ON pd.disposition_type_id = dd.disposition_type_id
LEFT JOIN 
    case_action_causes cac ON cac.case_id = c.case_id
LEFT JOIN 
    param_action_causes pc ON pc.action_cause_id = cac.action_cause_id 
WHERE 
    pe.deploy_nature_code = 'SB' 
    AND (IF(pc.others_flag = 'Y', CONCAT(pc.action_cause_short_name, ' - ', cac.action_cause_others), pc.action_cause_short_name)) LIKE '%disa%'
    AND c.employment_type_flag = 'OFW'
    AND c.case_type_code = 'CASE'
    AND c.filed_date BETWEEN '2019-01-01' AND '2023-12-31'
    -- AND pd.disposition_type NOT IN ('Decided', 'Settled')
    AND dd.disposition_type_id is null
GROUP BY 
    d.docket_number
ORDER BY 
    d.org_code, c.filed_date ASC;

SELECT 
    distinct_cases.org_code AS `Organization code`,
    DATE_FORMAT(distinct_cases.filed_date, '%Y') AS `Month`,
    COUNT(DISTINCT distinct_cases.docket_number) AS `Total of Cases`,
    SUM(CASE 
        WHEN distinct_cases.disposition_type = 'Decided' THEN 1 
        ELSE 0 
    END) AS `Decided`,
    SUM(CASE 
        WHEN distinct_cases.disposition_type = 'Settled' THEN 1 
        ELSE 0 
    END) AS `Settled`,
    SUM(CASE 
        WHEN distinct_cases.disposition_type = 'Dismissed With Prejudice' or distinct_cases.disposition_type = 'Dismissed Without Prejudice' THEN 1 
        ELSE 0 
    END) AS `Dismissed With Prejudice`,
    SUM(CASE 
        WHEN distinct_cases.disposition_type = 'Order' THEN 1 
        ELSE 0 
    END) AS `Order`,
    SUM(CASE 
        WHEN distinct_cases.disposition_type = 'Withdrawn' THEN 1 
        ELSE 0 
    END) AS `Withdrawn`,
    SUM(CASE 
        WHEN distinct_cases.disposition_type = 'Referred to Other Government Office' THEN 1 
        ELSE 0 
    END) AS `Referred to Other Government Office`,
    SUM(CASE 
        WHEN distinct_cases.disposition_type IS NULL THEN 1 
        ELSE 0 
    END) AS `No disposition`
FROM (
    SELECT 
        DISTINCT d.docket_number,
        c.filed_date,
        dd.won_by,
        d.org_code,
        pd.disposition_type
    FROM 
        cases c
    LEFT JOIN 
        dockets d ON d.docket_id = c.docket_id
    LEFT JOIN 
        case_parties cp ON cp.case_id = c.case_id AND cp.case_party_type LIKE 'P%'
    LEFT JOIN 
        parties p ON p.party_id = cp.party_id
    LEFT JOIN 
        party_employments pe ON pe.party_id = p.party_id
    LEFT JOIN 
        docket_disposition dd ON dd.docket_id = c.docket_id
    LEFT JOIN 
        param_disposition_types pd ON pd.disposition_type_id = dd.disposition_type_id
    LEFT JOIN 
        case_action_causes cac ON cac.case_id = c.case_id
    LEFT JOIN 
        param_action_causes pc ON pc.action_cause_id = cac.action_cause_id 
    WHERE 
        pe.deploy_nature_code = 'SB' 
        AND (IF(pc.others_flag = 'Y', CONCAT(pc.action_cause_short_name, ' - ', cac.action_cause_others), pc.action_cause_short_name)) LIKE '%disa%'
        AND c.employment_type_flag = 'OFW'
        AND c.case_type_code = 'CASE'
        AND c.filed_date BETWEEN '2019-01-01' AND '2023-12-31'
    GROUP BY 
        d.docket_number
) AS distinct_cases
GROUP BY 
    DATE_FORMAT(distinct_cases.filed_date, '%Y'), distinct_cases.org_code
ORDER BY 
    DATE_FORMAT(distinct_cases.filed_date, '%Y'), distinct_cases.org_code  ASC;


-- SELECT 
--     distinct_cases.org_code AS `Organization code`,
--     DATE_FORMAT(distinct_cases.filed_date, '%Y-%m') AS `Month`,
--     SUM(CASE 
--         WHEN distinct_cases.won_by LIKE '%labor%' THEN 1 
--         ELSE 0 
--     END) AS `Labor`,
--     SUM(CASE 
--         WHEN distinct_cases.won_by LIKE '%management%' THEN 1 
--         ELSE 0 
--     END) AS `Management`,
--     COUNT(DISTINCT distinct_cases.docket_number) AS `Total of Cases`
-- FROM (
--     SELECT 
--         DISTINCT d.docket_number,
--         c.filed_date,
--         dd.won_by,
--         d.org_code
--     FROM 
--         cases c
--     LEFT JOIN 
--         dockets d ON d.docket_id = c.docket_id
--     LEFT JOIN 
--         case_parties cp ON cp.case_id = c.case_id AND cp.case_party_type LIKE 'P%'
--     LEFT JOIN 
--         parties p ON p.party_id = cp.party_id
--     LEFT JOIN 
--         party_employments pe ON pe.party_id = p.party_id
--     JOIN 
--         docket_disposition dd ON dd.docket_id = c.docket_id
--     LEFT JOIN 
--         param_disposition_types pd ON pd.disposition_type_id = dd.disposition_type_id
--     LEFT JOIN 
--         case_action_causes cac ON cac.case_id = c.case_id
--     LEFT JOIN 
--         param_action_causes pc ON pc.action_cause_id = cac.action_cause_id 
--     WHERE 
--         pe.deploy_nature_code = 'SB' 
--         AND (IF(pc.others_flag = 'Y', CONCAT(pc.action_cause_short_name, ' - ', cac.action_cause_others), pc.action_cause_short_name)) LIKE '%disability%'
--         AND c.employment_type_flag = 'OFW'
--         AND c.case_type_code = 'CASE'
--         AND c.filed_date BETWEEN '2019-01-01' AND '2023-12-31'
--         -- AND pd.disposition_type NOT IN ('Decided', 'Settled')
--     GROUP BY 
--         d.docket_number
-- ) AS distinct_cases
-- GROUP BY 
--     distinct_cases.org_code, DATE_FORMAT(distinct_cases.filed_date, '%Y-%m')
-- ORDER BY 
--     distinct_cases.org_code, DATE_FORMAT(distinct_cases.filed_date, '%Y-%m') ASC;

--  new query

-- SELECT 
--     d.docket_number AS `Docket number`,
--     concat(p.last_name, ', ', p.first_name, ' ', p.middle_name) as `Respondent`,
--     pd.disposition_type as `Disposition type`,
-- 	dd.won_by as `Won by`,
--     dd.amount_awarded as `Amount awarded`,
--     d.org_code as `Organization code`,
--     c.filed_date as `Filed date`,
--     if(pc.others_flag = 'Y', concat(ifnull(pc.action_cause_name, ''), ifnull(cac.action_cause_others, '')), pc.action_cause_name) as `Cause`
-- FROM 
--     cases c
-- LEFT JOIN 
--     dockets d ON d.docket_id = c.docket_id
-- LEFT JOIN 
--     case_parties cp ON cp.case_id = c.case_id AND cp.case_party_type LIKE 'P%'
-- LEFT JOIN 
--     parties p ON p.party_id = cp.party_id
-- LEFT JOIN 
--     party_employments pe ON pe.party_id = p.party_id
-- LEFT JOIN 
--     docket_disposition dd ON dd.docket_id = c.docket_id
-- LEFT JOIN 
--     param_disposition_types pd ON pd.disposition_type_id = dd.disposition_type_id
-- LEFT JOIN 
--     case_action_causes cac ON cac.case_id = c.case_id
-- LEFT JOIN 
--     param_action_causes pc ON pc.action_cause_id = cac.action_cause_id 
-- WHERE 
--     pe.deploy_nature_code = 'SB' 
--     AND (if(pc.others_flag = 'Y', concat(pc.action_cause_short_name, ' - ', cac.action_cause_others) ,pc.action_cause_short_name)) LIKE '%disability%'
--     AND c.employment_type_flag = 'OFW'
--     and c.case_type_code = 'CASE'
--     AND c.filed_date BETWEEN '2019-01-01' AND '2023-12-31'
--     and pd.disposition_type in('Settled')
-- GROUP BY 
--     d.docket_number
-- ORDER BY 
--     d.org_code, c.filed_date ASC;

-- SELECT 
--     distinct_cases.org_code as `Organization code`,
-- 	DATE_FORMAT(distinct_cases.filed_date, '%Y-%M') AS `Month`,
--     SUM(CASE 
--         WHEN distinct_cases.won_by LIKE '%labor%' THEN 1 
--         ELSE 0 
--     END) AS `Labor`,
--     SUM(CASE 
--         WHEN distinct_cases.won_by LIKE '%management%' THEN 1 
--         ELSE 0 
--     END) AS `Management`,
--     COUNT(DISTINCT distinct_cases.docket_number) AS `Total of Cases`
-- FROM (
--     SELECT 
--         DISTINCT d.docket_number,
--         c.filed_date,
--         dd.won_by,
--         d.org_code
--     FROM 
--         cases c
--     LEFT JOIN 
--         dockets d ON d.docket_id = c.docket_id
--     LEFT JOIN 
--         case_parties cp ON cp.case_id = c.case_id AND cp.case_party_type LIKE 'P%'
--     LEFT JOIN 
--         parties p ON p.party_id = cp.party_id
--     LEFT JOIN 
--         party_employments pe ON pe.party_id = p.party_id
--     LEFT JOIN 
--         docket_disposition dd ON dd.docket_id = c.docket_id
--     LEFT JOIN 
--         param_disposition_types pd ON pd.disposition_type_id = dd.disposition_type_id
--     LEFT JOIN 
--         case_action_causes cac ON cac.case_id = c.case_id
--     LEFT JOIN 
--         param_action_causes pc ON pc.action_cause_id = cac.action_cause_id 
--     WHERE 
--         pe.deploy_nature_code = 'SB' 
--         AND (IF(pc.others_flag = 'Y', CONCAT(pc.action_cause_short_name, ' - ', cac.action_cause_others), pc.action_cause_short_name)) LIKE '%disa%'
--         AND c.employment_type_flag = 'OFW'
--         AND c.case_type_code = 'CASE'
--         AND c.filed_date BETWEEN '2019-01-01' AND '2023-12-31'
--         and pd.disposition_type in('Settled')
--         group by d.docket_number
-- ) AS distinct_cases
-- GROUP BY 
--     distinct_cases.org_code, DATE_FORMAT(distinct_cases.filed_date, '%Y-%M')
-- ORDER BY 
--     distinct_cases.org_code, DATE_FORMAT(distinct_cases.filed_date, '%Y-%M') ASC;
