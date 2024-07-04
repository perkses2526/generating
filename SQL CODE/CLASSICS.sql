use ects;

-- Conmed performance
-- conmed performance from 07-15-2020 (All RABs)
select c.org_code, c.docket_number, a.case_title, a.filed_date, f.available_date, b.date_disposed, '' as nothing, d.username, a.created_by, b.remarks, concat(d.fname, ' ', d.mname,'. ', d.lname), g.disposition_type, h.actioni
from cases as a
left join dockets as c on a.docket_id = c.docket_id
left join ects_core.users as d on a.process_by = d.user_id
left join (select ee.* from docket_tasks as ee inner join (select docket_id, max(docket_task_id) as MaxDate from docket_tasks where activity_name = 'First conciliation-mediation conference' group by docket_id ) xm on ee.docket_id = xm.docket_id and ee.docket_task_id = xm.MaxDate) as e on a.docket_id = e.docket_id
left join param_availability_schedule as f on e.availability_schedule_id = f.availability_schedule_id
left join (select bb.* from docket_disposition as bb inner join (select docket_id, min(disposition_id) as MaxDate,remarks from docket_disposition group by docket_id ) xm on bb.docket_id = xm.docket_id and bb.disposition_id = xm.MaxDate) as b on b.docket_id = a.docket_id
left join param_disposition_types as g on g.disposition_type_id = b.disposition_type_id
left join (SELECT ccc.case_id, GROUP_CONCAT(DISTINCT ccc.poopi SEPARATOR '|') as actioni FROM (select aaa.case_id, if(bbb.others_flag = 'Y',concat(bbb.action_cause_short_name, ' - ', aaa.action_cause_others),bbb.action_cause_short_name) as poopi from case_action_causes as aaa left join param_action_causes as bbb on aaa.action_cause_id = bbb.action_cause_id) as ccc GROUP BY ccc.case_id) as h on h.case_id = a.case_id
where a.process_by is not null
and a.case_type_code = 'RFA'
and ((b.date_disposed BETWEEN '2020-07-15' AND '2023-12-31' and a.filed_date between '2018-01-01' AND '2023-12-31') or (b.date_disposed is null and a.filed_date between '2020-07-15' AND '2023-12-31'))
order by a.filed_date, a.process_by, b.date_disposed desc;