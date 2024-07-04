use ects;

-- MAAM LENY CONMED 1st DAY OF THE MONTH
select a.docket_number, a.case_title, a.filed_date, b.date_disposed, e.disposition_type, concat(d.fname, ' ', d.mname, ' ' , d.lname) as LA, c.org_code, b.created_date, h.actioni,  
if(g.total is null, '0', g.total) as male_count,
if(f.total is null, '0', f.total) as female_count
from cases as a
left join dockets as c on a.docket_id = c.docket_id
left join ects_core.users as d on a.process_by = d.user_id
left join (select aaa.case_id, COUNT(*) AS Total from case_parties as aaa left join parties as bbb on aaa.party_id = bbb.party_id where bbb.sex_flag = 'M' group by aaa.case_id) as g on g.case_id = a.case_id 
left join (select aaa.case_id, COUNT(*) AS Total, bbb.age from case_parties as aaa left join parties as bbb on aaa.party_id = bbb.party_id where bbb.sex_flag = 'F' group by aaa.case_id) as f on f.case_id = a.case_id
left join (select bb.* from docket_disposition as bb inner join (select docket_id, min(disposition_id) as MaxDate from docket_disposition group by docket_id ) xm on bb.docket_id = xm.docket_id and bb.disposition_id = xm.MaxDate) as b on b.docket_id = a.docket_id
left join param_disposition_types as e on b.disposition_type_id = e.disposition_type_id
left join (SELECT ccc.case_id, GROUP_CONCAT(DISTINCT ccc.poopi SEPARATOR '|') as actioni FROM (select aaa.case_id, if(bbb.others_flag = 'Y',concat(bbb.action_cause_short_name, ' - ', aaa.action_cause_others),bbb.action_cause_short_name) as poopi from case_action_causes as aaa left join param_action_causes as bbb on aaa.action_cause_id = bbb.action_cause_id) as ccc GROUP BY ccc.case_id) as h on h.case_id = a.case_id
where a.process_by is not null
and a.case_type_code = 'CASE'  -- 'RFA'
-- and a.filed_date between '2019-05-01' AND '2024-12-31'
-- and a.filed_date between '2022-12-01' AND '2023-12-31'
-- and a.filed_date between '2024-01-01' AND '2024-12-31'
-- and a.filed_date between '2020-07-15' AND '2023-12-31'
and a.filed_date between '2019-05-01' AND '2024-12-31'
-- COMMENT OUT BOTH FOR ALL
 and b.date_disposed is not null -- (disposed)
-- and b.date_disposed is null -- (Pending)
-- MALE
and f.total is not null 
and f.age >= 45
-- and g.total is not null
-- and h.actioni like '%Maternity%'
-- and (h.actioni like '%Harass%' or h.actioni like '%Harras%')
-- and (h.actioni like '%Discrim%')
-- and (h.actioni like '%Paternity%')
-- and (h.actioni like '%Marri%' or h.actioni like '%Marry%')
-- and (h.actioni like '%Against women%')
-- and (h.actioni like '%Maltreatment%')
-- and (h.actioni like '% Rape%')
-- and (h.actioni like '%Lasciviousness%')
-- and (h.actioni like '%trafficking%')
-- and (h.actioni like '%distort%')
order by 3 asc;