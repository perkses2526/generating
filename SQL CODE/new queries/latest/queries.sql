USE ects; 
--  WORKING QUERY/GENERAL QUERY
SELECT DISTINCT
    c.case_type_code as `Case type`,
    c.docket_number AS `Case number`,
    c.case_title as `Case title`,
    GROUP_CONCAT(DISTINCT p.position) as `Position`,
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
	c.process_by IS NOT NULL AND 
	c.filed_date between '2024-01-01' and '2024-09-30' and 
	d.org_code = 'RABXII'
GROUP BY 
    c.docket_number, c.case_type_code, c.case_title, 
    IFNULL(k.disposition_type, 'PENDING'), c.filed_date
ORDER BY
    d.org_code, c.filed_date ASC;


SELECT * FROM docket_disposition where disposition_id = 225438;
SELECT * FROM main_nlrc_db.T_EditorTransfers where pointer = 23923;

select c.docket_number as `Docket number`, c.case_type_code as `Case type`, c.case_title as `Case title`, c.filed_date as `Filed date`, dd.date_disposed as `Date disposed`, concat(u.lname, ', ', u.fname) as LA from cases c 
join dockets d on d.docket_id = c.docket_id
join docket_disposition dd on dd.docket_id = d.docket_id
join ects_core.users u on u.user_id = c.process_by
where 
-- c.process_by = 1177 and 
d.org_code = 'SRABI' AND
c.filed_date between '2024-07-03' and '2024-07-10' 
and c.process_by is not null
;


select * from docket_disposition where disposition_id = 224694;

select * from cases where case_title  like '%ARIANE CELESTIAL BENDICIO VS CITY SPEC CORPORATION%';

select c.docket_number as `Docket number`,c.case_title as `Case title`, cac.action_cause_others as `Causes others` from cases c 
join case_action_causes cac on cac.case_id = c.case_id
join param_action_causes pac on pac.action_cause_id = cac.action_cause_id
where 
c.filed_date between '2021-01-01' and '2024-09-05' and 
-- pac.action_cause_id = 184 AND 
cac.action_cause_others like '%auto%' AND 
c.process_by is not null
group by c.docket_number
;

select * from case_action_causes;

select * from param_action_causes where docket_type_flag != 'DOCKET_TYPE_RFA';

select distinct sex_flag from parties;

select a.case_type_code as `Case type code`, c.org_code as `Rab`, a.docket_number AS `Docket number`, a.case_title AS `Case title`, a.filed_date AS `Filed date`, concat(d.fname, ' ', d.mname, ' ' , d.lname) as LA
from cases as a
left join dockets as c on a.docket_id = c.docket_id
left join ects_core.users as d on a.process_by = d.user_id
left join (select bb.* from docket_disposition as bb inner join (select docket_id, min(disposition_id) as MaxDate from docket_disposition group by docket_id ) xm on bb.docket_id = xm.docket_id and bb.disposition_id = xm.MaxDate) as b on b.docket_id = a.docket_id
where a.process_by is not null

and a.case_type_code = 'RFA' 

and c.org_code = 'SRABXII'

and a.filed_date between '2019-05-01' AND '2024-12-31'
and b.date_disposed is null
and not d.user_id = 769
order by 3 asc limit 10;

SELECT * FROM cases where case_title like '%EDWIN T. PADILLA %';

select * from case_reliefs where case_id in (
304780,
305013,
304996,
304993,
304942
);

select * from party_contacts where party_id in (
684480,
684484,
684488,
684494,
685084,
685090,
685093,
685040,
685045,
685051,
685056,
685062,
685065,
685070,
685076,
685078,
685079,
685032,
685035,
684924,
684928
);

select * from parties where party_id in (
684480,
684484,
684488,
684494,
685084,
685090,
685093,
685040,
685045,
685051,
685056,
685062,
685065,
685070,
685076,
685078,
685079,
685032,
685035,
684924,
684928
);

select * from case_parties where party_id in 
(684480,
684484,
684488,
684494,
685084,
685090,
685093,
685040,
685045,
685051,
685056,
685062,
685065,
685070,
685076,
685078,
685079,
685032,
685035,
684924,
684928);

select * from parties where party_id in (
684480,
684484,
684488,
684494,
685084,
685090,
685093,
685040,
685045,
685051,
685056,
685062,
685065,
685070,
685076,
685078,
685079,
685032,
685035,
684924,
684928
);

select * from docket_task_predecessors where docket_task_id in (1516675,
1516676,
1516677,
1516678,
1517313,
1517314,
1517315,
1517316,
1517498,
1517499,
1517500,
1517501,
1517514,
1517515,
1517516,
1517517,
1517576,
1517577,
1517578,
1517579
);

SELECT * FROM docket_tasks where docket_id in(304773,
304935,
304986,
304989,
305006);

SELECT * FROM cases where case_title like '%Rizzan A. Nepomuceno VS Jarlop Distributor Inc.%';

SELECT * FROM docket_disposition where disposition_id = 222665;

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
WHERE c.case_type_code = 'CASE' AND c.filed_date BETWEEN '2024-04-01' AND '2024-05-07' AND d.org_code != 'NCR' 
AND (SELECT COUNT(*) FROM case_parties WHERE case_id = c.case_id AND case_party_type LIKE 'P%') > 1 
AND d.docket_number is not null 
order by d.org_code, p.company_name, `Labor Arbiter`ASC;

SELECT distinct cp.* FROM cases c
join case_parties cp on cp.case_id = c.case_id and cp.case_party_type like 'P%'
where c.docket_number = 'RABIV-08-00063-24';

select * from cases where docket_number = 'NLRC-RABVII-06-00137-24-OFF';

SELECT distinct cac.* FROM cases c 
join case_action_causes cac on cac.case_id = c.case_id
join param_action_causes pac on pac.action_cause_id = cac.action_cause_id
where c.docket_number = 'NCR-06-00686-24';
