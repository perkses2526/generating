use ects;

describe ects_core.users;
-- arbiters cases list 

SELECT * FROM docket_disposition where docket_id in(SELECT docket_id FROM dockets
WHERE docket_number IN (
    'NLRC-SRABVI-05-00041-24',
    'NLRC-SRABVI-06-00023-24',
    'NLRC-SRABVI-06-00033-24',
    'NLRC-SRABVI-06-00007-24',
    'NLRC-SRABVI-06-00016-24',
    'NLRC-SRABVI-05-00010-24',
    'NLRC-SRABVI-06-00013-24',
    'NLRC-SRABVI-06-00015-24',
    'NLRC-SRABVI-06-00030-24',
    'NLRC-SRABVI-06-00032-24',
    'NLRC-SRABVI-05-00015-24',
    'NLRC-SRABVI-05-00035-24',
    'NLRC-SRABVI-05-00036-24',
    'NLRC-SRABVI-06-00010-24',
    'NLRC-SRABVI-06-00011-24',
    'NLRC-SRABVI-06-00025-24',
    'NLRC-SRABVI-06-00027-24',
    'NLRC-SRABVI-06-00005-24',
    'NLRC-SRABVIA-06-00029-24'
)
ORDER BY CASE docket_id
WHEN 296792 THEN 1
WHEN 299079 THEN 2
WHEN 299829 THEN 3
WHEN 297983 THEN 4
WHEN 298780 THEN 5
WHEN 292968 THEN 6
WHEN 298505 THEN 7
WHEN 298665 THEN 8
WHEN 299678 THEN 9
WHEN 299728 THEN 10
WHEN 293556 THEN 11
WHEN 295953 THEN 12
WHEN 296146 THEN 13
WHEN 298309 THEN 14
WHEN 298339 THEN 15
WHEN 299117 THEN 16
WHEN 299456 THEN 17
WHEN 297935 THEN 18
WHEN 297945 THEN 19
    ELSE 20
END
)ORDER BY CASE docket_id
WHEN 296792 THEN 1
WHEN 299079 THEN 2
WHEN 299829 THEN 3
WHEN 297983 THEN 4
WHEN 298780 THEN 5
WHEN 292968 THEN 6
WHEN 298505 THEN 7
WHEN 298665 THEN 8
WHEN 299678 THEN 9
WHEN 299728 THEN 10
WHEN 293556 THEN 11
WHEN 295953 THEN 12
WHEN 296146 THEN 13
WHEN 298309 THEN 14
WHEN 298339 THEN 15
WHEN 299117 THEN 16
WHEN 299456 THEN 17
WHEN 297935 THEN 18
WHEN 297945 THEN 19
    ELSE 20
END;



SELECT * FROM docket_disposition where docket_id in(SELECT docket_id FROM dockets
WHERE docket_number IN (
    'NLRC-SRABVI-05-00041-24',
    'NLRC-SRABVI-06-00023-24',
    'NLRC-SRABVI-06-00033-24',
    'NLRC-SRABVI-06-00007-24',
    'NLRC-SRABVI-06-00016-24',
    'NLRC-SRABVI-05-00010-24',
    'NLRC-SRABVI-06-00013-24',
    'NLRC-SRABVI-06-00015-24',
    'NLRC-SRABVI-06-00030-24',
    'NLRC-SRABVI-06-00032-24',
    'NLRC-SRABVI-05-00015-24',
    'NLRC-SRABVI-05-00035-24',
    'NLRC-SRABVI-05-00036-24',
    'NLRC-SRABVI-06-00010-24',
    'NLRC-SRABVI-06-00011-24',
    'NLRC-SRABVI-06-00025-24',
    'NLRC-SRABVI-06-00027-24',
    'NLRC-SRABVI-06-00005-24',
    'NLRC-SRABVIA-06-00029-24'
)
ORDER BY CASE docket_number
    WHEN 'NLRC-SRABVI-05-00041-24' THEN 1
    WHEN 'NLRC-SRABVI-06-00023-24' THEN 2
    WHEN 'NLRC-SRABVI-06-00033-24' THEN 3
    WHEN 'NLRC-SRABVI-06-00007-24' THEN 4
    WHEN 'NLRC-SRABVI-06-00016-24' THEN 5
    WHEN 'NLRC-SRABVI-05-00010-24' THEN 6
    WHEN 'NLRC-SRABVI-06-00013-24' THEN 7
    WHEN 'NLRC-SRABVI-06-00015-24' THEN 8
    WHEN 'NLRC-SRABVI-06-00030-24' THEN 9
    WHEN 'NLRC-SRABVI-06-00032-24' THEN 10
    WHEN 'NLRC-SRABVI-05-00015-24' THEN 11
    WHEN 'NLRC-SRABVI-05-00035-24' THEN 12
    WHEN 'NLRC-SRABVI-05-00036-24' THEN 13
    WHEN 'NLRC-SRABVI-06-00010-24' THEN 14
    WHEN 'NLRC-SRABVI-06-00011-24' THEN 15
    WHEN 'NLRC-SRABVI-06-00025-24' THEN 16
    WHEN 'NLRC-SRABVI-06-00027-24' THEN 17
    WHEN 'NLRC-SRABVI-06-00005-24' THEN 18
    WHEN 'NLRC-SRABVIA-06-00029-24' THEN 19
    ELSE 20
END
);

SELECT docket_number, docket_id FROM dockets
WHERE docket_number IN (
    'NLRC-SRABVI-05-00041-24',
    'NLRC-SRABVI-06-00023-24',
    'NLRC-SRABVI-06-00033-24',
    'NLRC-SRABVI-06-00007-24',
    'NLRC-SRABVI-06-00016-24',
    'NLRC-SRABVI-05-00010-24',
    'NLRC-SRABVI-06-00013-24',
    'NLRC-SRABVI-06-00015-24',
    'NLRC-SRABVI-06-00030-24',
    'NLRC-SRABVI-06-00032-24',
    'NLRC-SRABVI-05-00015-24',
    'NLRC-SRABVI-05-00035-24',
    'NLRC-SRABVI-05-00036-24',
    'NLRC-SRABVI-06-00010-24',
    'NLRC-SRABVI-06-00011-24',
    'NLRC-SRABVI-06-00025-24',
    'NLRC-SRABVI-06-00027-24',
    'NLRC-SRABVI-06-00005-24',
    'NLRC-SRABVIA-06-00029-24'
)
ORDER BY CASE docket_number
    WHEN 'NLRC-SRABVI-05-00041-24' THEN 1
    WHEN 'NLRC-SRABVI-06-00023-24' THEN 2
    WHEN 'NLRC-SRABVI-06-00033-24' THEN 3
    WHEN 'NLRC-SRABVI-06-00007-24' THEN 4
    WHEN 'NLRC-SRABVI-06-00016-24' THEN 5
    WHEN 'NLRC-SRABVI-05-00010-24' THEN 6
    WHEN 'NLRC-SRABVI-06-00013-24' THEN 7
    WHEN 'NLRC-SRABVI-06-00015-24' THEN 8
    WHEN 'NLRC-SRABVI-06-00030-24' THEN 9
    WHEN 'NLRC-SRABVI-06-00032-24' THEN 10
    WHEN 'NLRC-SRABVI-05-00015-24' THEN 11
    WHEN 'NLRC-SRABVI-05-00035-24' THEN 12
    WHEN 'NLRC-SRABVI-05-00036-24' THEN 13
    WHEN 'NLRC-SRABVI-06-00010-24' THEN 14
    WHEN 'NLRC-SRABVI-06-00011-24' THEN 15
    WHEN 'NLRC-SRABVI-06-00025-24' THEN 16
    WHEN 'NLRC-SRABVI-06-00027-24' THEN 17
    WHEN 'NLRC-SRABVI-06-00005-24' THEN 18
    WHEN 'NLRC-SRABVIA-06-00029-24' THEN 19
    ELSE 20
END;


SELECT a.docket_number AS `Docket number`, a.case_title AS `Case title`, a.filed_date AS `Filed date`, b.date_disposed AS `Date disposed`, e.disposition_type AS `Disposition type`, concat(d.fname, ' ', d.mname, ' ' , d.lname) as LA, c.org_code AS `Organizational code`, h.actioni as `Causes of actions`,  
if(g.total is null, '0', g.total) as `Male count`,
if(f.total is null, '0', f.total) as `Female count`
from cases as a
left join dockets as c on a.docket_id = c.docket_id
left join ects_core.users as d on a.process_by = d.user_id
left join (select aaa.case_id, COUNT(*) AS Total from case_parties as aaa left join parties as bbb on aaa.party_id = bbb.party_id where bbb.sex_flag = 'M' group by aaa.case_id) as g on g.case_id = a.case_id 
left join (select aaa.case_id, COUNT(*) AS Total from case_parties as aaa left join parties as bbb on aaa.party_id = bbb.party_id where bbb.sex_flag = 'F' group by aaa.case_id) as f on f.case_id = a.case_id
left join (select bb.* from docket_disposition as bb inner join (select docket_id, min(disposition_id) as MaxDate from docket_disposition group by docket_id ) xm on bb.docket_id = xm.docket_id and bb.disposition_id = xm.MaxDate) as b on b.docket_id = a.docket_id
left join param_disposition_types as e on b.disposition_type_id = e.disposition_type_id
left join (SELECT ccc.case_id, GROUP_CONCAT(DISTINCT ccc.poopi SEPARATOR '|') as actioni FROM (select aaa.case_id, if(bbb.others_flag = 'Y',concat(bbb.action_cause_short_name, ' - ', aaa.action_cause_others),bbb.action_cause_short_name) as poopi from case_action_causes as aaa left join param_action_causes as bbb on aaa.action_cause_id = bbb.action_cause_id) as ccc GROUP BY ccc.case_id) as h on h.case_id = a.case_id
where a.process_by is not null
and a.case_type_code = 'RFA'  -- 'RFA'
-- and a.filed_date between '2019-05-01' AND '2024-12-31'
-- and a.filed_date between '2022-12-01' AND '2023-12-31'
-- and a.filed_date between '2024-01-01' AND '2024-12-31'
and a.filed_date between '2024-01-01' AND '2024-03-31'
-- COMMENT OUT BOTH FOR ALL
-- and b.date_disposed is not null -- (disposed)
-- and b.date_disposed is null -- (Pending)
-- FEMALE
and g.total is not null
and f.total is null
and 
(h.actioni like '%Maternity%'
    OR (h.actioni like '%Harass%' or h.actioni like '%Harras%')
    OR (h.actioni like '%Discrim%')
    OR (h.actioni like '%Paternity%')
    OR (h.actioni like '%Marri%' or h.actioni like '%Marry%')
    OR (h.actioni like '%Against women%')
    -- OR (h.actioni like '%Maltreatment%')
    OR (h.actioni like '%Rape%')
    -- OR (h.actioni like '%Lasciviousness%')
    -- OR (h.actioni like '%trafficking%')
)
order by 3 asc;

select
	UPPER(concat(u.lname, ', ', u.fname, ' ', u.mname)) as `Labor Arbiter`,
	date_format(c.filed_date, '%Y') as `Year`, 
	c.docket_number as `Case number`,
	concat(p.last_name, ', ', p.first_name, ' ', p.middle_name) as `Complainant`, 
	if(r.company_name is not null, r.company_name, concat(r.last_name, ', ', r.first_name, ' ', r.middle_name)) as `Respondent`,
    c.raffled_date as `Raffled date`, pe.deploy_nature_code as `Deployment Code`
from cases c 
join ects_core.users u on u.user_id = c.process_by
join ects_core.user_roles ur on ur.user_id = u.user_id and ur.role_code = 'LABOR_ARBITER'
join case_parties cp on cp.case_id = c.case_id and cp.case_party_type like 'P%'
join parties p on p.party_id = cp.party_id 
join party_employments pe on pe.party_id = cp.party_id and pe.deploy_nature_code in('SB', 'LB', 'LO') 
join case_parties cp2 on cp2.case_id = c.case_id and cp2.case_party_type like 'C%'
join parties r on r.party_id = cp2.party_id 
order by u.lname, c.filed_date asc
;

-- number of docket_task
SELECT 
    (@cnt := @cnt + 1) AS `No.`, 
    d.docket_number as `Docket no.`,
    dt.task_name as `Activity name`, 
    dt.task_actor_id as `Task actor id`,
    dt.availability_schedule_id as `Availability schedule`,
	pas.available_date as `Available date`,
    dt.actual_start_date as `Actual start date`, 
    dt.actual_end_date as `Actual end date`
FROM 
    cases c
JOIN 
    (SELECT @cnt := 0) AS dummy
JOIN 
    dockets d ON d.docket_id = c.docket_id
LEFT JOIN 
    docket_disposition dd ON dd.docket_id = d.docket_id
LEFT JOIN 
    param_disposition_types pdt ON pdt.disposition_type_id = dd.disposition_type_id
JOIN 
    ects_core.users u ON u.user_id = c.process_by
JOIN 
    ects_core.user_roles ur ON ur.user_id = u.user_id AND ur.role_code = 'LABOR_ARBITER'
JOIN 
    docket_tasks dt ON dt.docket_id = d.docket_id
LEFT JOIN param_availability_schedule pas on pas.availability_schedule_id = dt.availability_schedule_id
WHERE 
    c.case_type_code = 'CASE' 
    AND c.raffled_date BETWEEN '2023-08-01' AND DATE_FORMAT(NOW(), '%Y-%m-%d')
    AND dt.task_name IN('First mandatory conference', 'Second mandatory conference', 'Additional conference')
ORDER BY 
	d.docket_id,
    FIELD(dt.activity_name, 'First mandatory conference', 'Second mandatory conference', 'Additional conference'), 
    c.raffled_date
    ASC;

select * from ects_core.users u join ects_core.user_roles ur on ur.user_id = u.user_id where ur.role_code = 'LABOR_ARBITER';

-- list of cases from 9 months till now, conmed rating
select (@cnt := @cnt + 1) AS `No.`, c.case_id as `Case id`, c.case_title `Case title`, c.filed_date `Filed date`, dd.date_disposed `Date disposed`,
	  TIMESTAMPDIFF(day, c.filed_date, dd.date_disposed) AS `Age`, pas.available_date , pdt.disposition_type AS `Disposition type`, dd.amount_peso, dd.award_type , u.user_id `user_id of process by`, concat(u.lname, ', ', u.fname, ' ', u.mname) as `LA`      -- dd.created_by, dd.created_date
from cases c
JOIN (SELECT @cnt := 0) AS dummy
join dockets d on d.docket_id = c.docket_id
left join docket_disposition dd on dd.docket_id = d.docket_id
left join param_disposition_types pdt on pdt.disposition_type_id = dd.disposition_type_id
join ects_core.users u on u.user_id = c.process_by
join ects_core.user_roles ur on ur.user_id = u.user_id and ur.role_code = 'CON_MED'
JOIN docket_tasks dt ON dt.docket_id = d.docket_id and dt.task_name like 'First con%'
LEFT JOIN param_availability_schedule pas on pas.availability_schedule_id = dt.availability_schedule_id
where c.case_type_code = 'RFA' and
c.filed_date between '2023-01-01' and '2023-11-16' and 
c.process_by = 1215 
order by c.raffled_date asc
;


describe docket_tasks;

select distinct task_name, activity_name from docket_tasks;

describe cases;

select * from cases order by case_id desc;

SELECT d.docket_number, c.case_title, c.filed_date, concat(u.lname, ', ', u.fname) as `Labor Arbiter` FROM cases c
join dockets d on d.docket_id = c.docket_id
join ects_core.users u on u.user_id = c.process_by
left join docket_disposition dd on dd.docket_id = d.docket_id
where c.process_by = '' and dd.disposition_id is null and c.filed_date between '' and ''
;

SELECT a.docket_number, a.case_title, a.filed_date, CONCAT(d.fname, ' ', d.mname, ' ' , d.lname) AS `Labor Arbiter` FROM cases AS a LEFT JOIN dockets AS c ON a.docket_id = c.docket_id LEFT JOIN ects_core.users AS d ON a.process_by = d.user_id WHERE a.process_by IS NOT NULL ORDER BY `Labor Arbiter` ASC;

-- CHECK DOUBLE FILING IN SAME DAY 
SELECT 
    distinct d.docket_number AS `Docket No.`,
	c.case_title AS `Case title`,
    CONCAT(la.lname, ', ', la.fname, ' ', LEFT(la.mname, 1), '.') AS `Labor Arbiter`,
    d.org_code AS `Organization code`,
    date_format(c.filed_date, '%Y-%m-%d') as `Filed Date`
FROM cases c 
JOIN dockets d ON d.docket_id = c.docket_id
JOIN case_parties cp ON cp.case_id = c.case_id
JOIN parties p ON p.party_id = cp.party_id and cp.case_party_type LIKE 'C%'
LEFT JOIN ects_core.users la ON la.user_id = c.process_by
WHERE c.case_type_code = 'CASE' AND c.filed_date BETWEEN '2024-04-01' AND '2024-04-30' AND d.org_code != 'NCR' 
AND (SELECT COUNT(*) FROM case_parties WHERE case_id = c.case_id AND case_party_type LIKE 'P%') > 1 
AND d.docket_number is not null 
and d.org_code regexp 'RABVII|RABVIII|RABIX|RABX|RABXI|RABXII|RABXIII'
order by d.org_code, `Labor Arbiter`, c.filed_date, p.company_name ASC;



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
GROUP BY
    `Year-Month`,
    d.org_code,
    pac.action_cause_short_name
ORDER BY
    MIN(c.filed_date) ASC;




-- SELECT count(*) from cases as a
--     left join dockets as c on a.docket_id = c.docket_id
--     left join ects_core.users as d on a.process_by = d.user_id
--     left join ects_core.user_roles ur on ur.user_id = d.user_id
--     left join (
--         select bb.* 
--         from docket_disposition as bb 
--         inner join (
--             select docket_id, min(disposition_id) as MaxDate 
--             from docket_disposition 
--             group by docket_id
--         ) xm on bb.docket_id = xm.docket_id and bb.disposition_id = xm.MaxDate
--     ) as b on b.docket_id = a.docket_id
--     group by d.fname, d.mname, d.lname
--     ;

-- SELECT d.user_id, d.username, concat(d.fname, ' ', d.mname, ' ', d.lname) as `Full Name`, d.org_code, count(distinct a.docket_id) as total_cases, count(distinct case when b.date_disposed is null then a.docket_id end) as pending_cases, group_concat(ur.role_code separator ',') as role from cases as a left join dockets as c on a.docket_id = c.docket_id left join ects_core.users as d on a.process_by = d.user_id left join ects_core.user_roles ur on ur.user_id = d.user_id left join ( select bb.* from docket_disposition as bb inner join ( select docket_id, min(disposition_id) as MaxDate from docket_disposition group by docket_id ) xm on bb.docket_id = xm.docket_id and bb.disposition_id = xm.MaxDate ) as b on b.docket_id = a.docket_id where --a.case_type_code = 'CASE' --and a.filed_date between '2019-05-01' AND '2024-04-31' WHERE CONCAT(d.username, d.lname, d.fname) LIKE '%%' group by d.fname, d.mname, d.lname order by `Full Name`, total_cases desc;

-- select 
-- 	d.user_id, 
--     d.username,
--     concat(d.fname, ' ', d.mname, ' ', d.lname) as `Full Name`,
--     d.org_code,
--     count(distinct a.docket_id) as total_cases,
--     count(distinct case when b.date_disposed is null then a.docket_id end) as pending_cases,
--      group_concat(ur.role_code separator ',') as role
-- from cases as a
-- left join dockets as c on a.docket_id = c.docket_id
-- left join ects_core.users as d on a.process_by = d.user_id
-- left join ects_core.user_roles ur on ur.user_id = d.user_id
-- left join (
--     select bb.* 
--     from docket_disposition as bb 
--     inner join (
--         select docket_id, min(disposition_id) as MaxDate 
--         from docket_disposition 
--         group by docket_id
--     ) xm on bb.docket_id = xm.docket_id and bb.disposition_id = xm.MaxDater
-- where a.process_by is not null
-- and a.case_type_code = 'CASE'
-- and a.filed_date between '2019-05-01' AND '2024-04-31'
-- group by d.fname, d.mname, d.lname
-- order by `Full Name`, total_cases desc;


SELECT 
    u.user_id AS `User id`,
    u.username,
    UPPER(CONCAT(u.lname, ', ', u.fname)) AS `Full name`,
    u.org_code AS `Organization code`,
    (COUNT(u.user_id)) AS `Total cases`,
    (count(dd.date_disposed is null))
FROM 
    ects_core.users u
    join cases c on c.process_by = u.user_id
    left join docket_disposition dd on dd.docket_id = c.docket_id
    
    WHERE c.filed_date between '2019-05-01' and '2024-04-31' and c.case_type_code = 'CASE'
	group by u.user_id
    order by u.org_code
    ;


SELECT count(*) from ects_core.users u;