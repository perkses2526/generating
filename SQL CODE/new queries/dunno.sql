use ects;

select * from case_legal order by case_legal_id desc limit 10;
 
use ects;

select * from case_action_causes limit 10;
-- arbiter all list  
select
	UPPER(concat(u.lname, ', ', u.fname, ' ', u.mname, ' - ', u.org_code)) as `Labor Arbiter`,
	date_format(c.filed_date, '%Y') as Year, 
	c.docket_number as `Case number`,
	concat(p.last_name, ', ', p.first_name, ' ', p.middle_name) as Complainant, 
	if(r.company_name is not null, r.company_name, concat(r.last_name, ', ', r.first_name, ' ', r.middle_name)) as Respondent,
    c.raffled_date as `Raffled date`,
    h.actioni,
    pe.deploy_nature_code as `Deployment Code`
from cases c 
join ects_core.users u on u.user_id = c.process_by
join ects_core.user_roles ur on ur.user_id = u.user_id and ur.role_code = 'LABOR_ARBITER'
join case_parties cp on cp.case_id = c.case_id and cp.case_party_type like 'P%'
join parties p on p.party_id = cp.party_id 
join party_employments pe on pe.party_id = cp.party_id and pe.deploy_nature_code in('SB', 'LB', 'LO') 
join case_parties cp2 on cp2.case_id = c.case_id and cp2.case_party_type like 'C%'
join parties r on r.party_id = cp2.party_id 
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
where c.filed_date >= '2019-06-01'
GROUP BY c.docket_id
order by u.lname, c.filed_date asc
;

-- left join (SELECT ccc.case_id, GROUP_CONCAT(DISTINCT ccc.poopi SEPARATOR '|') as actioni FROM (select aaa.case_id, if(bbb.others_flag = 'Y',concat(bbb.action_cause_short_name, ' - ', aaa.action_cause_others),
-- bbb.action_cause_short_name) as poopi from case_action_causes as aaa 
-- left join param_action_causes as bbb on aaa.action_cause_id = bbb.action_cause_id) as ccc GROUP BY ccc.case_id) as h on h.case_id = a.case_id

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
	(IF(pc.others_flag = 'Y', CONCAT(pc.action_cause_short_name, ' - ', cac.action_cause_others), pc.action_cause_short_name)) LIKE '%disa%'
    AND c.employment_type_flag = 'OFW'
    AND c.case_type_code = 'CASE'
    AND c.filed_date BETWEEN '2019-01-01' AND '2023-12-31'
    GROUP BY 
    d.docket_number
ORDER BY 
    d.org_code, c.filed_date ASC;

select * from party_employments where party_id = 137043;