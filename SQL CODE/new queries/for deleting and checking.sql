use ects;

select p.company_name as `Company name`, c.docket_number as `Docket number`, c.case_title as `Case title`, pdt.disposition_type as `Disposition type`  from cases c 
join dockets d on d.docket_id = c.docket_id
join case_parties cp on cp.case_id = c.case_id
join parties p on p.party_id = cp.party_id
join docket_disposition dd on dd.docket_id = d.docket_id
left join param_disposition_types pdt on pdt.disposition_type_id = dd.disposition_type_id
where 
p.company_name like '%12 STARS INTERNATIONAL%' or
p.company_name like '%3D ANALYZER INFORMATION%' or
p.company_name like '%66 GLOBAL SOLUTIONS %' or
p.company_name like '%7 PRIME TECH%' or
p.company_name like '%ACSTREAM MANAGE%' or
p.company_name like '%ALTERA KARNA%' or
p.company_name like '%ANOC99 CORP%' or
p.company_name like '%DIGITAL JENtUS%' or
p.company_name like '%DYNAMIC STUDIO%' or
p.company_name like '%FRONTIER POINT%' or
p.company_name like '%GAMMA INTERACTIVE%' or
p.company_name like '%GAO SHOU%' or
p.company_name like '%GLARION%' or
p.company_name like '%IDNPLAY CORP%' or
p.company_name like '%INTELLIGENT OPTICAL SOLUTION%' or
p.company_name like '%KNW TECH%' or
p.company_name like '%MACH 86%' or
p.company_name like '%MAIMAI INFO%' or
p.company_name like '%MERIT LEGEND%' or
p.company_name like '%NEO INCO%' or
p.company_name like '%NETEASE TECH%' or
p.company_name like '%NEW WAVE INFO%' or
p.company_name like '%NOCMAKATI%' or
p.company_name like '%PHOENIXFIELD%' or
p.company_name like '%ROYAL GLOBAL%' or
p.company_name like '%SHAW GLOBAL%' or
p.company_name like '%SOHU EXPERT%' or
p.company_name like '%SPARVA INCO%' or
p.company_name like '%33 SQUARED ROUTE%' or
p.company_name like '%THE PLAYHUB%' or
p.company_name like '%VICCI BUSINESS%' or
p.company_name like '%VICTORY 88%' or
p.company_name like '%WANFANG TECH%' or 
p.company_name like '%w%'
order by p.company_name asc
;

describe param_business_natures;

select * from param_business_natures;

select distinct company_name from parties;
-- checking number of parties
SELECT d.org_code, c.case_id , d.docket_number, c.case_title, c.filed_date, c.created_date,
(select count(*) from case_parties where case_id = c.case_id and case_party_type = 'P') as `P`,
(select count(*) from case_parties where case_id = c.case_id and case_party_type = 'CP') as `CP`
FROM cases c
join dockets d on d.docket_id = c.docket_id
where c.created_date like '%2024-07-03%' and c.docket_number like '%OFF%'
order by case_id desc;

-- checking latest cases/dockets
select * from dockets order by docket_id desc;
select * from cases order by case_id desc;
-- searching dockets/cases
select * from dockets where docket_number LIKE '%rabxii-kd-04-00004-24%' order by docket_id desc;
select * from cases where docket_number = 'RABIII-07-00055-24' order by case_id desc;


-- searching foreign keys
SELECT 
    TABLE_NAME,
    COLUMN_NAME,
    CONSTRAINT_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM 
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE 
    TABLE_SCHEMA = 'ects' -- Replace with your database name
    AND REFERENCED_TABLE_NAME IS NOT NULL;

    SELECT 
    TABLE_NAME, 
    COLUMN_NAME 
FROM 
    INFORMATION_SCHEMA.COLUMNS 
WHERE 
    TABLE_SCHEMA = 'ects' 
    AND COLUMN_NAME = 'docket_id'
    AND TABLE_NAME IN (
        'docket_archives',
        'docket_comments',
        'docket_decision',
        'docket_disposition',
        'docket_entry_finality',
        'docket_orgs',
        'docket_reassignment',
        'docket_relationships',
        'docket_subledgers',
        'docket_task_documents',
        'docket_tasks',
        'docket_transfer',
        'docket_tro_of_exec',
        'docket_writ_of_exec'
    );
    
    use ects;
    
select * from docket_disposition order by disposition_id desc;
    
select c.* from dockets d
join cases c on c.docket_number = d.docket_number
 where d.docket_id in (
93176,
93266,
93278,
93295,
93304,
93309,
93317
);
    
SELECT 
(SELECT COUNT(*) FROM docket_archives WHERE docket_id = d.docket_id) as docket_archives,
(SELECT COUNT(*) FROM docket_comments WHERE docket_id = d.docket_id) as docket_comments,
(SELECT COUNT(*) FROM docket_decision WHERE docket_id = d.docket_id) as docket_decision,
(SELECT COUNT(*) FROM docket_disposition WHERE docket_id = d.docket_id) as docket_disposition,
(SELECT COUNT(*) FROM docket_entry_finality WHERE docket_id = d.docket_id) as docket_entry_finality,
(SELECT COUNT(*) FROM docket_orgs WHERE docket_id = d.docket_id) as docket_orgs,
(SELECT COUNT(*) FROM docket_reassignment WHERE docket_id = d.docket_id) as docket_reassignment,
(SELECT COUNT(*) FROM docket_subledgers WHERE docket_id = d.docket_id) as docket_subledgers,
(SELECT COUNT(*) FROM docket_tasks WHERE docket_id = d.docket_id) as docket_tasks,
(SELECT COUNT(*) FROM docket_transfer WHERE docket_id = d.docket_id) as docket_transfer,
(SELECT COUNT(*) FROM docket_tro_of_exec WHERE docket_id = d.docket_id) as docket_tro_of_exec,
(SELECT COUNT(*) FROM docket_writ_of_exec WHERE docket_id = d.docket_id) as docket_writ_of_exec
FROM dockets d where d.docket_id = '267845';

SELECT * FROM docket_disposition where docket_id = 267845;

SELECT 
(SELECT COUNT(*) FROM case_action_causes WHERE case_id = c.case_id) as case_action_causes,
(SELECT COUNT(*) FROM case_appeals WHERE case_id = c.case_id) as case_appeals,
(SELECT COUNT(*) FROM case_counsels WHERE case_id = c.case_id) as case_counsels,
(SELECT COUNT(*) FROM case_grievances WHERE case_id = c.case_id) as case_grievances,
(SELECT COUNT(*) FROM case_legal WHERE case_id = c.case_id) as case_legal,
(SELECT COUNT(*) FROM case_legal_parties WHERE case_id = c.case_id) as case_legal_parties,
(SELECT COUNT(*) FROM case_parties WHERE case_id = c.case_id) as case_parties,
(SELECT COUNT(*) FROM case_petitions WHERE case_id = c.case_id) as case_petitions,
(SELECT COUNT(*) FROM case_referrals WHERE case_id = c.case_id) as case_referrals,
(SELECT COUNT(*) FROM case_reliefs WHERE case_id = c.case_id) as case_reliefs,
(SELECT COUNT(*) FROM docket_decision WHERE case_id = c.case_id) as docket_decision,
(SELECT COUNT(*) FROM docket_task_documents WHERE case_id = c.case_id) as docket_task_documents,
(SELECT COUNT(*) FROM hist_case_parties WHERE case_id = c.case_id) as hist_case_parties,
(SELECT COUNT(*) FROM hist_cases WHERE case_id = c.case_id) as hist_cases
from cases c where c.case_id = 300695;

-- SELECT * FROM case_parties WHERE case_id = 300695;

SELECT * FROM case_action_causes WHERE case_id = 300695;
select * from case_grievances where case_id = 300695;
select * from case_reliefs where case_id = 300695;
describe parties;
SELECT * FROM parties where party_id in (672870, 672902, 672890, 672944, 672931, 672954);
SELECT * FROM party_addresses where party_id in (672870, 672902, 672890, 672944, 672931, 672954);
SELECT * FROM party_contacts where party_id in (672870, 672902, 672890, 672944, 672931, 672954);
SELECT * FROM party_identifications where party_id in (672870, 672902, 672890, 672944, 672931, 672954);



select * from docket_tasks where docket_id = 300683;

describe docket_task_predecessors;

select * from docket_task_predecessors where docket_task_id in (select docket_task_id from docket_tasks where docket_id = 300683) or pred_docket_task_id in (select docket_task_id from docket_tasks where docket_id = 300683);

SELECT * FROM dockets where docket_number ='CAR-05-00024-24';
SELECT * FROM docket_disposition dd
where docket_id = 303294;

SELECT
        d.docket_number as `Docket_number`,
        CONCAT('<button class="btn btn-primary btn-sm" onclick="viewdata(this)" docket_number="', d.docket_id ,'" attrs="docket_archives">',(SELECT COUNT(*) FROM docket_archives WHERE docket_id = d.docket_id), '</button>
') as docket_archives,
        CONCAT('<button class="btn btn-primary btn-sm" onclick="viewdata(this)" docket_number="', d.docket_id ,'" attrs="docket_comments">',(SELECT COUNT(*) FROM docket_comments WHERE docket_id = d.docket_id), '</button>
') as docket_comments,
        CONCAT('<button class="btn btn-primary btn-sm" onclick="viewdata(this)" docket_number="', d.docket_id ,'" attrs="docket_decision">',(SELECT COUNT(*) FROM docket_decision WHERE docket_id = d.docket_id), '</button>
') as docket_decision,
        CONCAT('<button class="btn btn-primary btn-sm" onclick="viewdata(this)" docket_number="', d.docket_id ,'" attrs="docket_disposition">',(SELECT COUNT(*) FROM docket_disposition WHERE docket_id = d.docket_id), '</button>
') as docket_disposition,
        CONCAT('<button class="btn btn-primary btn-sm" onclick="viewdata(this)" docket_number="', d.docket_id ,'" attrs="docket_entry_finality">',(SELECT COUNT(*) FROM docket_entry_finality WHERE docket_id = d.docket_id), '</button>
') as docket_entry_finality,
        CONCAT('<button class="btn btn-primary btn-sm" onclick="viewdata(this)" docket_number="', d.docket_id ,'" attrs="docket_orgs">',(SELECT COUNT(*) FROM docket_orgs WHERE docket_id = d.docket_id), '</button>
') as docket_orgs,
        CONCAT('<button class="btn btn-primary btn-sm" onclick="viewdata(this)" docket_number="', d.docket_id ,'" attrs="docket_reassignment">',(SELECT COUNT(*) FROM docket_reassignment WHERE docket_id = d.docket_id), '</button>
') as docket_reassignment,
        CONCAT('<button class="btn btn-primary btn-sm" onclick="viewdata(this)" docket_number="', d.docket_id ,'" attrs="docket_subledgers">',(SELECT COUNT(*) FROM docket_subledgers WHERE docket_id = d.docket_id), '</button>
') as docket_subledgers,
        CONCAT('<button class="btn btn-primary btn-sm" onclick="viewdata(this)" docket_number="', d.docket_id ,'" attrs="docket_tasks">',(SELECT COUNT(*) FROM docket_tasks WHERE docket_id = d.docket_id), '</button>
') as docket_tasks,
        CONCAT('<button class="btn btn-primary btn-sm" onclick="viewdata(this)" docket_number="', d.docket_id ,'" attrs="docket_transfer">',(SELECT COUNT(*) FROM docket_transfer WHERE docket_id = d.docket_id), '</button>
') as docket_transfer,
        CONCAT('<button class="btn btn-primary btn-sm" onclick="viewdata(this)" docket_number="', d.docket_id ,'" attrs="docket_tro_of_exec">',(SELECT COUNT(*) FROM docket_tro_of_exec WHERE docket_id = d.docket_id), '</button>
') as docket_tro_of_exec,
        CONCAT('<button class="btn btn-primary btn-sm" onclick="viewdata(this)" docket_number="', d.docket_id ,'" attrs="docket_writ_of_exec">',(SELECT COUNT(*) FROM docket_writ_of_exec WHERE docket_id = d.docket_id), '</button>
') as docket_writ_of_exec
        FROM dockets d where d.docket_number  IN ('RABIII-07-00055-24','RABIII-12-00007-23');

SELECT * FROM dockets where docket_number in(
'NLRC-SRABVI-05-00041-24',
'NLRC-SRABVI-06-00023-24',
'NLRC-SRABVI-05-00033-24',
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
WHEN 'NLRC-SRABVI-05-00033-24' THEN 3
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
;

select * from dockets where docket_id = 298780;

select * from docket_disposition where docket_id = 295953
;

SELECT * FROM docket_disposition dd
where docket_id in (
296792,
299079,
295537,
297983,
298780,
292968,
298505,
298665,
299678,
299728,
293556,
295953,
296146,
298309,
298339,
299117,
299456,
297935,
297945

)
ORDER BY CASE docket_id
WHEN 296792 THEN 1
WHEN 299079 THEN 2
WHEN 295537 THEN 3
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
;