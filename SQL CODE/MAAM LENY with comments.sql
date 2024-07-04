use ects;

-- Maam Leny
select a.docket_number, a.case_title, a.filed_date, b.date_disposed, e.disposition_type, concat(d.fname, ' ', d.mname, ' ' , d.lname) as conmed, c.org_code, b.created_date, b.remarks, b.reason, z.comments
from cases as a
left join dockets as c on a.docket_id = c.docket_id
left join ects_core.users as d on a.process_by = d.user_id
left join (select bb.* from docket_disposition as bb inner join (select docket_id, min(disposition_id) as MaxDate from docket_disposition group by docket_id ) xm on bb.docket_id = xm.docket_id and bb.disposition_id = xm.MaxDate) as b on b.docket_id = a.docket_id
left join param_disposition_types as e on b.disposition_type_id = e.disposition_type_id
left join (select zz.* from docket_comments as zz inner join (select docket_id, max(docket_comment_id) as MaxDate from docket_comments group by docket_id ) zm on zz.docket_id = zm.docket_id and zz.docket_comment_id = zm.MaxDate) as z on c.docket_id = z.docket_id
where a.process_by is not null
and a.case_type_code = 'RFA' -- 'CASE'
-- and not c.docket_status_id = 4
-- and b.date_disposed between '2024-02-01' AND '2024-02-29'
-- and e.disposition_type like '%settled%'
-- and c.org_code = 'NCR'
-- and a.filed_date between '2019-05-01' AND '2024-12-31'
 and a.filed_date between '2023-01-01' AND '2024-12-31'
-- and (b.created_date between '2019-05-01' AND '2023-12-31' or b.date_disposed is null)
-- and (b.created_date between '2023-01-01' AND '2024-12-31' or b.date_disposed is null)
-- and b.date_disposed is null
-- and a.case_title like '%Safeguard DNA%'
-- and d.user_id in (1224,227,214,632,139,1027,209,159,256,773,1018,648,1224,320,657,231,1221,279,659,1205,1193,110,662)
-- and d.user_id in (110)
and not d.user_id = 769
order by 3 asc;

use ects;

-- Maam Leny
select a.docket_number, a.case_title, a.filed_date, b.date_disposed, e.disposition_type, concat(d.fname, ' ', d.mname, ' ' , d.lname) as conmed, c.org_code, b.created_date, b.remarks, b.reason, z.comments
from cases as a
left join dockets as c on a.docket_id = c.docket_id
left join ects_core.users as d on a.process_by = d.user_id
left join (select bb.* from docket_disposition as bb inner join (select docket_id, min(disposition_id) as MaxDate from docket_disposition group by docket_id ) xm on bb.docket_id = xm.docket_id and bb.disposition_id = xm.MaxDate) as b on b.docket_id = a.docket_id
left join param_disposition_types as e on b.disposition_type_id = e.disposition_type_id
left join (select zz.* from docket_comments as zz inner join (select docket_id, max(docket_comment_id) as MaxDate from docket_comments group by docket_id ) zm on zz.docket_id = zm.docket_id and zz.docket_comment_id = zm.MaxDate) as z on c.docket_id = z.docket_id
where a.process_by is not null
and a.case_type_code = 'RFA' -- 'CASE'
-- and not c.docket_status_id = 4
-- and b.date_disposed between '2024-02-01' AND '2024-02-29'
-- and e.disposition_type like '%settled%'
-- and c.org_code = 'NCR'
-- and a.filed_date between '2019-05-01' AND '2024-12-31'
 and a.filed_date between '2023-01-01' AND '2024-12-31'
-- and (b.created_date between '2019-05-01' AND '2023-12-31' or b.date_disposed is null)
-- and (b.created_date between '2023-01-01' AND '2024-12-31' or b.date_disposed is null)
-- and b.date_disposed is null
-- and a.case_title like '%Safeguard DNA%'
-- and d.user_id in (1224,227,214,632,139,1027,209,159,256,773,1018,648,1224,320,657,231,1221,279,659,1205,1193,110,662)
-- and d.user_id in (110)
and not d.user_id = 769
order by 3 asc;