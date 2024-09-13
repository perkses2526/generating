use ects;

SELECT * FROM cases c
left join dockets d on d.docket_id = c.docket_id;

select * from case_referrals where case_refer_id = '73524';

SELECT cr.*, c.case_title FROM dockets d 
join cases c on c.docket_id = d.docket_id
join case_referrals cr on cr.case_id = c.case_id
join docket_referrals dd on d.docket_id = dd.docket_id
where d.docket_number = 'NLRC-RABIV-05-00165-24';

SELECT c.org_code AS `RAB`, c.docket_number as `Docket number`, a.case_title as `Title`, a.filed_date as `Date Filed`, f.available_date as `Initial Conference`, b.date_disposed as `Date disposed`, '' as `Duration to Dispose`, d.username as `Con-Med`, a.created_by as `FiledBy`, b.remarks as `Remarks`, 
        c.org_code AS `RAB`, concat(d.fname, ' ', d.mname,'. ', d.lname) as `Conmed`, pdt.disposition_type as `Disposition`, h.actioni as action, b.reason as `Reason`
        from cases as a
        left join dockets as c on a.docket_id = c.docket_id
        left join ects_core.users as d on a.process_by = d.user_id
        left join (select ee.* from docket_tasks as ee inner join (select docket_id, max(docket_task_id) as MaxDate from docket_tasks where activity_name = 'First conciliation-mediation conference' group by docket_id ) xm on ee.docket_id = xm.docket_id and ee.docket_task_id = xm.MaxDate) as e on a.docket_id = e.docket_id
        left join param_availability_schedule as f on e.availability_schedule_id = f.availability_schedule_id
        left join (select bb.* from docket_disposition as bb inner join (select docket_id, min(disposition_id) as MaxDate,remarks from docket_disposition group by docket_id ) xm on bb.docket_id = xm.docket_id and bb.disposition_id = xm.MaxDate) as b on b.docket_id = a.docket_id
        left join docket_disposition dd on dd.docket_id = c.docket_id
        left join param_disposition_types pdt on pdt.disposition_type_id = dd.disposition_type_id
        left join (SELECT ccc.case_id, GROUP_CONCAT(DISTINCT ccc.poopi SEPARATOR '|') as actioni FROM (select aaa.case_id, if(bbb.others_flag = 'Y',concat(bbb.action_cause_short_name, ' - ', aaa.action_cause_others),bbb.action_cause_short_name) as poopi from case_action_causes as aaa left join param_action_causes as bbb on aaa.action_cause_id = bbb.action_cause_id) as ccc GROUP BY ccc.case_id) as h on h.case_id = a.case_id
        where a.process_by is not null
        and a.case_type_code = 'RFA'
        and 
        (
            (b.date_disposed BETWEEN '2020-07-15' AND '2023-12-31' and a.filed_date between '2018-01-01' AND '2024-12-31') or 
            (b.date_disposed is null and a.filed_date between '2020-07-15' AND '2024-12-31')
        )
        order by a.filed_date, a.process_by, b.date_disposed desc;

select a.docket_number, a.case_title, a.filed_date, b.date_disposed, e.disposition_type, concat(d.fname, ' ', d.mname, ' ' , d.lname) as LA, c.org_code, b.created_date, Replace(Replace(h.actioni,',',''),'"','') as action, Replace(Replace(b.remarks,',',''),'"','') as remarks, Replace(Replace(b.reason,',',''),'"','') as reason
from cases as a
left join dockets as c on a.docket_id = c.docket_id
left join ects_core.users as d on a.process_by = d.user_id
left join (select bb.* from docket_disposition as bb inner join (select docket_id, min(disposition_id) as MaxDate from docket_disposition group by docket_id ) xm on bb.docket_id = xm.docket_id and bb.disposition_id = xm.MaxDate) as b on b.docket_id = a.docket_id
left join param_disposition_types as e on b.disposition_type_id = e.disposition_type_id
left join (SELECT ccc.case_id, GROUP_CONCAT(DISTINCT ccc.poopi SEPARATOR '|') as actioni FROM (select aaa.case_id, if(bbb.others_flag = 'Y',concat(bbb.action_cause_short_name, ' - ', aaa.action_cause_others),bbb.action_cause_short_name) as poopi from case_action_causes as aaa left join param_action_causes as bbb on aaa.action_cause_id = bbb.action_cause_id) as ccc GROUP BY ccc.case_id) as h on h.case_id = a.case_id
where a.process_by is not null
and a.case_type_code = 'RFA'  -- 'RFA'
-- and c.org_code = 'NCR'
-- and a.filed_date between '2019-05-01' AND '2024-12-31'
 and a.filed_date between '2023-01-01' AND '2023-12-31'
-- and a.filed_date between '2024-01-01' AND '2024-01-31'
-- and (b.created_date between '2019-05-01' AND '2023-12-31' or b.date_disposed is null)
-- and (b.created_date between '2023-01-01' AND '2024-12-31' or b.date_disposed is null)
 and b.date_disposed is null
-- and a.case_title like '%Safeguard DNA%'
-- and d.user_id in (1224,227,214,632,139,1027,209,159,256,773,1018,648,1224,320,657,231,1221,279,659,1205,1193,110,662)
-- and d.user_id in (110)
 and not d.user_id = 769
order by 3 asc;

SELECT * FROM docket_disposition where
docket_id in(
234002,92110,92406,93817,95063,96242,96741,99476,99857,99997,100020,102458,102781,105265,112299,112685,112979,113585,114855,116162,117570,117955,123892,124401,127703,129266,130532,134144,134708,139091,141290,141466,141624,143714,146082,150330,152577,157797,160160,174212,181183,186434,196054,200490,202521,203461,205646,206268,218225,219924,222363,223927,233946,238096,243588,246447,249948,251232,251328,251538,251808,252299,252457,252599,252672,253104,258033,258249,259279,264238,264403,265223,265556,266180,270405
)

 ;

SELECT 
    d.docket_number, 
    d.docket_id, 
    IF(GROUP_CONCAT(DATE_FORMAT(sch.available_date, '%Y-%m-%d')) IS NULL, DATE_FORMAT(dt.actual_end_date, '%Y-%m-%d'), GROUP_CONCAT(DATE_FORMAT(sch.available_date, '%Y-%m-%d'))) AS dates, 
    IF(g.total IS NULL, '0', g.total) AS male_count,
    IF(f.total IS NULL, '0', f.total) AS female_count
FROM 
    dockets d 
LEFT JOIN 
    cases a ON a.docket_id = d.docket_id
LEFT JOIN 
    docket_tasks dt ON dt.docket_id = d.docket_id AND dt.activity_name = 'First mandatory conference'
LEFT JOIN 
    param_availability_schedule sch ON sch.availability_schedule_id = dt.availability_schedule_id
LEFT JOIN 
    (SELECT aaa.case_id, COUNT(*) AS total 
     FROM case_parties AS aaa 
     LEFT JOIN parties AS bbb ON aaa.party_id = bbb.party_id 
     WHERE bbb.sex_flag = 'M' 
     GROUP BY aaa.case_id) AS g ON g.case_id = a.case_id 
LEFT JOIN 
    (SELECT aaa.case_id, COUNT(*) AS total 
     FROM case_parties AS aaa 
     LEFT JOIN parties AS bbb ON aaa.party_id = bbb.party_id 
     WHERE bbb.sex_flag = 'F' 
     GROUP BY aaa.case_id) AS f ON f.case_id = a.case_id
WHERE 
    d.docket_number IN (
        'NCR-04-00613-23', 'NCR-08-00005-19', 'NCR-08-00132-19', 'NCR-08-00856-19', 'NCR-08-01462-19', 
        'NCR-09-00484-19', 'NCR-09-00714-19', 'NCR-10-00311-19', 'NCR-10-00484-19', 'NCR-10-00554-19', 
        'NCR-10-00564-19', 'NCR-10-01792-19', 'NCR-10-01956-19', 'NCR-11-01088-19', 'NCR-01-01384-20', 
        'NCR-01-01604-20', 'NCR-01-01782-20', 'NCR-02-00153-20', 'NCR-02-00851-20', 'NCR-02-01547-20', 
        'NCR-03-00238-20', 'NCR-03-00427-20', 'NCR-07-00152-20', 'NCR-07-00252-20', 'NCR-09-00163-20', 
        'NCR-09-00464-20', 'NCR-10-00198-20', 'NCR-11-00485-20', 'NCR-11-00749-20', 'NCR-01-00508-21', 
        'NCR-02-00411-21', 'NCR-02-00511-21', 'NCR-02-00608-21', 'NCR-03-00390-21', 'NCR-03-01253-21', 
        'NCR-05-00413-21', 'NCR-06-00229-21', 'NCR-08-00046-21', 'NCR-08-00481-21', 'NCR-02-00714-22', 
        'NCR-04-00875-22', 'NCR-06-00257-22', 'NCR-08-00975-22', 'NCR-10-00213-22', 'NCR-10-00800-22', 
        'NCR-11-00090-22', 'NCR-11-00652-22', 'NCR-11-00827-22', 'NCR-02-00196-23', 'NCR-02-00664-23', 
        'NCR-03-00073-23', 'NCR-03-00425-23', 'NCR-04-00593-23', 'NCR-05-00698-23', 'NCR-06-00825-23', 
        'NCR-07-00406-23', 'NCR-08-00259-23', 'NCR-08-00603-23', 'NCR-08-00635-23', 'NCR-08-00689-23', 
        'NCR-08-00754-23', 'NCR-08-00867-23', 'NCR-08-00904-23', 'NCR-08-00954-23', 'NCR-08-00975-23', 
        'NCR-08-01045-23', 'NCR-09-01115-23', 'NCR-09-01183-23', 'NCR-10-00256-23', 'NCR-11-00238-23', 
        'NCR-11-00274-23', 'NCR-11-00439-23', 'NCR-11-00508-23', 'NCR-11-00657-23', 'NCR-12-00643-23'
    )
GROUP BY 
    d.docket_number
ORDER BY 
    CASE
        WHEN d.docket_number = 'NCR-04-00613-23' THEN 1
        WHEN d.docket_number = 'NCR-08-00005-19' THEN 2
        WHEN d.docket_number = 'NCR-08-00132-19' THEN 3
        WHEN d.docket_number = 'NCR-08-00856-19' THEN 4
        WHEN d.docket_number = 'NCR-08-01462-19' THEN 5
        WHEN d.docket_number = 'NCR-09-00484-19' THEN 6
        WHEN d.docket_number = 'NCR-09-00714-19' THEN 7
        WHEN d.docket_number = 'NCR-10-00311-19' THEN 8
        WHEN d.docket_number = 'NCR-10-00484-19' THEN 9
        WHEN d.docket_number = 'NCR-10-00554-19' THEN 10
        WHEN d.docket_number = 'NCR-10-00564-19' THEN 11
        WHEN d.docket_number = 'NCR-10-01792-19' THEN 12
        WHEN d.docket_number = 'NCR-10-01956-19' THEN 13
        WHEN d.docket_number = 'NCR-11-01088-19' THEN 14
        WHEN d.docket_number = 'NCR-01-01384-20' THEN 15
        WHEN d.docket_number = 'NCR-01-01604-20' THEN 16
        WHEN d.docket_number = 'NCR-01-01782-20' THEN 17
        WHEN d.docket_number = 'NCR-02-00153-20' THEN 18
        WHEN d.docket_number = 'NCR-02-00851-20' THEN 19
        WHEN d.docket_number = 'NCR-02-01547-20' THEN 20
        WHEN d.docket_number = 'NCR-03-00238-20' THEN 21
        WHEN d.docket_number = 'NCR-03-00427-20' THEN 22
        WHEN d.docket_number = 'NCR-07-00152-20' THEN 23
        WHEN d.docket_number = 'NCR-07-00252-20' THEN 24
        WHEN d.docket_number = 'NCR-09-00163-20' THEN 25
        WHEN d.docket_number = 'NCR-09-00464-20' THEN 26
        WHEN d.docket_number = 'NCR-10-00198-20' THEN 27
        WHEN d.docket_number = 'NCR-11-00485-20' THEN 28
        WHEN d.docket_number = 'NCR-11-00749-20' THEN 29
        WHEN d.docket_number = 'NCR-01-00508-21' THEN 30
        WHEN d.docket_number = 'NCR-02-00411-21' THEN 31
        WHEN d.docket_number = 'NCR-02-00511-21' THEN 32
        WHEN d.docket_number = 'NCR-02-00608-21' THEN 33
        WHEN d.docket_number = 'NCR-03-00390-21' THEN 34
        WHEN d.docket_number = 'NCR-03-01253-21' THEN 35
        WHEN d.docket_number = 'NCR-05-00413-21' THEN 36
        WHEN d.docket_number = 'NCR-06-00229-21' THEN 37
        WHEN d.docket_number = 'NCR-08-00046-21' THEN 38
        WHEN d.docket_number = 'NCR-08-00481-21' THEN 39
        WHEN d.docket_number = 'NCR-02-00714-22' THEN 40
        WHEN d.docket_number = 'NCR-04-00875-22' THEN 41
        WHEN d.docket_number = 'NCR-06-00257-22' THEN 42
        WHEN d.docket_number = 'NCR-08-00975-22' THEN 43
        WHEN d.docket_number = 'NCR-10-00213-22' THEN 44
        WHEN d.docket_number = 'NCR-10-00800-22' THEN 45
        WHEN d.docket_number = 'NCR-11-00090-22' THEN 46
        WHEN d.docket_number = 'NCR-11-00652-22' THEN 47
        WHEN d.docket_number = 'NCR-11-00827-22' THEN 48
        WHEN d.docket_number = 'NCR-02-00196-23' THEN 49
        WHEN d.docket_number = 'NCR-02-00664-23' THEN 50
        WHEN d.docket_number = 'NCR-03-00073-23' THEN 51
        WHEN d.docket_number = 'NCR-03-00425-23' THEN 52
        WHEN d.docket_number = 'NCR-04-00593-23' THEN 53
        WHEN d.docket_number = 'NCR-05-00698-23' THEN 54
        WHEN d.docket_number = 'NCR-06-00825-23' THEN 55
        WHEN d.docket_number = 'NCR-07-00406-23' THEN 56
        WHEN d.docket_number = 'NCR-08-00259-23' THEN 57
        WHEN d.docket_number = 'NCR-08-00603-23' THEN 58
        WHEN d.docket_number = 'NCR-08-00635-23' THEN 59
        WHEN d.docket_number = 'NCR-08-00689-23' THEN 60
        WHEN d.docket_number = 'NCR-08-00754-23' THEN 61
        WHEN d.docket_number = 'NCR-08-00867-23' THEN 62
        WHEN d.docket_number = 'NCR-08-00904-23' THEN 63
        WHEN d.docket_number = 'NCR-08-00954-23' THEN 64
        WHEN d.docket_number = 'NCR-08-00975-23' THEN 65
        WHEN d.docket_number = 'NCR-08-01045-23' THEN 66
        WHEN d.docket_number = 'NCR-09-01115-23' THEN 67
        WHEN d.docket_number = 'NCR-09-01183-23' THEN 68
        WHEN d.docket_number = 'NCR-10-00256-23' THEN 69
        WHEN d.docket_number = 'NCR-11-00238-23' THEN 70
        WHEN d.docket_number = 'NCR-11-00274-23' THEN 71
        WHEN d.docket_number = 'NCR-11-00439-23' THEN 72
        WHEN d.docket_number = 'NCR-11-00508-23' THEN 73
        WHEN d.docket_number = 'NCR-11-00657-23' THEN 74
        WHEN d.docket_number = 'NCR-12-00643-23' THEN 75
    END
;


-- select * from docket_tasks where docket_id = 143770;

-- select * from docket_disposition where docket_id in(
-- 143770
-- ); 2024-05-20 09:30:39

-- select * from docket_disposition where docket_id in(
-- 234002,233368,233232,233082,232555,231994,231553,231361,231309,230861,230494,230368,230257,229949,229499,229007,228847,227055,226626,225871,225200,225145,224676,224536,224043,223663,223392,222762,222428,222177,221916,221673,221414,221007,220670,220327,220161,219785,219522,219502,219226,218851,218274,218087,217997,217623,216571,214770,214611,213896,213827,213285,213045,212973,212464,212063,211566,211191,210928,210360,209655,209467,208997,208760,207898,207851,206893,206111,205898,204802,204585,204159,203078,202871,202294,202281,202234,201808,201254,200605,199632,198711,197782,196588,195892,194046,193591,192545,189629,189463
-- );
SELECT 
	d.docket_number, 
    d.docket_id,
    c.filed_date,
    sch.available_date,
    dd.date_disposed,
    pdt.disposition_type,
    pdt.disposition_type_id,
    c.process_by
FROM 
    dockets d 
    LEFT JOIN docket_tasks dt ON dt.docket_id = d.docket_id AND dt.activity_name like '%First con%'
    LEFT JOIN param_availability_schedule sch ON sch.availability_schedule_id = dt.availability_schedule_id
    JOIN cases c on c.docket_id = d.docket_id
    LEFT JOIN case_parties cp on cp.case_id = c.case_id and cp.case_party_type like 'C%'
    LEFT JOIN parties p on p.party_id = cp.party_id 
    left join docket_disposition dd on dd.docket_id = d.docket_id
    left join param_disposition_types pdt on pdt.disposition_type_id = dd.disposition_type_id
    
WHERE 
    d.docket_number IN (
    'NLRC-NCR-01-01168-24','NLRC-NCR-01-01167-24','NLRC-NCR-01-01166-24','NLRC-NCR-01-01165-24','NLRC-NCR-01-01145-24','NLRC-NCR-01-01144-24','NLRC-NCR-01-01126-24','NLRC-NCR-01-01075-24','NLRC-NCR-01-01059-24','NLRC-NCR-01-01024-24','NLRC-NCR-01-00997-24','NLRC-NCR-01-00956-24','NLRC-NCR-01-00955-24','NLRC-NCR-01-00954-24','NLRC-NCR-01-00953-24','NLRC-NCR-01-00901-24','NLRC-NCR-01-00884-24','NLRC-NCR-01-00883-24','NLRC-NCR-01-00882-24','NLRC-NCR-01-00881-24','NLRC-NCR-01-00880-24','NLRC-NCR-01-00875-24','NLRC-NCR-01-00874-24','NLRC-NCR-01-00873-24','NLRC-NCR-01-00872-24','NLRC-NCR-01-00871-24','NLRC-NCR-01-00836-24','NLRC-NCR-01-00816-24','NLRC-NCR-01-00753-24','NLRC-NCR-01-00745-24','NLRC-NCR-01-00743-24','NLRC-NCR-01-00739-24','NLRC-NCR-01-00727-24','NLRC-NCR-01-00726-24','NLRC-NCR-01-00725-24','NLRC-NCR-01-00724-24','NLRC-NCR-01-00723-24','NLRC-NCR-01-00722-24','NLRC-NCR-01-00669-24','NLRC-NCR-01-00667-24','NLRC-NCR-01-00609-24','NLRC-NCR-01-00608-24','NLRC-NCR-01-00607-24','NLRC-NCR-01-00606-24','NLRC-NCR-01-00594-24','NLRC-NCR-01-00593-24','NLRC-NCR-01-00591-24','NLRC-NCR-01-00590-24','NLRC-NCR-01-00565-24','NLRC-NCR-01-00561-24','NLRC-NCR-01-00551-24','NLRC-NCR-01-00547-24','NLRC-NCR-01-00546-24','NLRC-NCR-01-00545-24','NLRC-NCR-01-00544-24','NLRC-NCR-01-00543-24','NLRC-NCR-01-00542-24','NLRC-NCR-01-00541-24','NLRC-NCR-01-00540-24','NLRC-NCR-01-00538-24','NLRC-NCR-01-00537-24','NLRC-NCR-01-00535-24','NLRC-NCR-01-00534-24','NLRC-NCR-01-00533-24','NLRC-NCR-01-00531-24','NLRC-NCR-01-00530-24','NLRC-NCR-01-00504-24','NLRC-NCR-01-00446-24','NLRC-NCR-01-00337-24','NLRC-NCR-01-00336-24','NLRC-NCR-01-00315-24','NLRC-NCR-01-00314-24','NLRC-NCR-01-00308-24','NLRC-NCR-01-00184-24','NLRC-NCR-01-00183-24','NLRC-NCR-01-00181-24','NLRC-NCR-01-00137-24','NLRC-NCR-01-00136-24','NLRC-NCR-01-00100-24','NLRC-NCR-02-00872-24','NLRC-NCR-02-00859-24','NLRC-NCR-02-00857-24','NLRC-NCR-02-00364-24','NLRC-NCR-02-00148-24','NLRC-NCR-02-00100-24','NLRC-NCR-03-00036-24'
    )  and c.process_by = 227
GROUP BY 
    d.docket_number;


SELECT 
	d.docket_number, 
	d.docket_id, 
	IF(GROUP_CONCAT(DATE_FORMAT(sch.available_date, '%Y-%m-%d')) IS NULL, DATE_FORMAT(dt.actual_start_date, '%Y-%m-%d'), GROUP_CONCAT(DATE_FORMAT(sch.available_date, '%Y-%m-%d'))), 
	IF(g.total IS NULL, '0', g.total) AS male_count,
	IF(f.total IS NULL, '0', f.total) AS female_count
FROM 
    dockets d 
    LEFT JOIN cases a ON a.docket_id = d.docket_id
    LEFT JOIN docket_tasks dt ON dt.docket_id = d.docket_id AND dt.activity_name = 'First mandatory conference'
    LEFT JOIN param_availability_schedule sch ON sch.availability_schedule_id = dt.availability_schedule_id
    LEFT JOIN (
        SELECT 
            aaa.case_id, 
            COUNT(*) AS Total 
        FROM 
            case_parties AS aaa 
            LEFT JOIN parties AS bbb ON aaa.party_id = bbb.party_id 
        WHERE 
            bbb.sex_flag = 'M' 
        GROUP BY 
            aaa.case_id
    ) AS g ON g.case_id = a.case_id 
    LEFT JOIN (
        SELECT 
            aaa.case_id, 
            COUNT(*) AS Total 
        FROM 
            case_parties AS aaa 
            LEFT JOIN parties AS bbb ON aaa.party_id = bbb.party_id 
        WHERE 
            bbb.sex_flag = 'F' 
        GROUP BY 
            aaa.case_id
    ) AS f ON f.case_id = a.case_id
WHERE 
    d.docket_id IN (
          234002,233368,233232,233082,232555,231994,231553,231361,231309,230861,230494,230368,230257,229949,229499,229007,228847,227055,226626,225871,225200,225145,224676,224536,224043,223663,223392,222762,222428,222177,221916,221673,221414,221007,220670,220327,220161,219785,219522,219502,219226,218851,218274,218087,217997,217623,216571,214770,214611,213896,213827,213285,213045,212973,212464,212063,211566,211191,210928,210360,209655,209467,208997,208760,207898,207851,206893,206111,205898,204802,204585,204159,203078,202871,202294,202281,202234,201808,201254,200605,199632,198711,197782,196588,195892,194046,193591,192545,189629,189463
          )
GROUP BY 
    d.docket_number
ORDER BY 
    CASE
        WHEN d.docket_id = '234002' THEN 1
        WHEN d.docket_id = '233368' THEN 2
        WHEN d.docket_id = '233232' THEN 3
        WHEN d.docket_id = '233082' THEN 4
        WHEN d.docket_id = '232555' THEN 5
        WHEN d.docket_id = '231994' THEN 6
        WHEN d.docket_id = '231553' THEN 7
        WHEN d.docket_id = '231361' THEN 8
        WHEN d.docket_id = '231309' THEN 9
        WHEN d.docket_id = '230861' THEN 10
        WHEN d.docket_id = '230494' THEN 11
        WHEN d.docket_id = '230368' THEN 12
        WHEN d.docket_id = '230257' THEN 13
        WHEN d.docket_id = '229949' THEN 14
        WHEN d.docket_id = '229499' THEN 15
        WHEN d.docket_id = '229007' THEN 16
        WHEN d.docket_id = '228847' THEN 17
        WHEN d.docket_id = '227055' THEN 18
        WHEN d.docket_id = '226626' THEN 19
        WHEN d.docket_id = '225871' THEN 20
        WHEN d.docket_id = '225200' THEN 21
        WHEN d.docket_id = '225145' THEN 22
        WHEN d.docket_id = '224676' THEN 23
        WHEN d.docket_id = '224536' THEN 24
        WHEN d.docket_id = '224043' THEN 25
        WHEN d.docket_id = '223663' THEN 26
        WHEN d.docket_id = '223392' THEN 27
        WHEN d.docket_id = '222762' THEN 28
        WHEN d.docket_id = '222428' THEN 29
        WHEN d.docket_id = '222177' THEN 30
        WHEN d.docket_id = '221916' THEN 31
        WHEN d.docket_id = '221673' THEN 32
        WHEN d.docket_id = '221414' THEN 33
        WHEN d.docket_id = '221007' THEN 34
        WHEN d.docket_id = '220670' THEN 35
        WHEN d.docket_id = '220327' THEN 36
        WHEN d.docket_id = '220161' THEN 37
        WHEN d.docket_id = '219785' THEN 38
        WHEN d.docket_id = '219522' THEN 39
        WHEN d.docket_id = '219502' THEN 40
        WHEN d.docket_id = '219226' THEN 41
        WHEN d.docket_id = '218851' THEN 42
        WHEN d.docket_id = '218274' THEN 43
        WHEN d.docket_id = '218087' THEN 44
        WHEN d.docket_id = '217997' THEN 45
        WHEN d.docket_id = '217623' THEN 46
        WHEN d.docket_id = '216571' THEN 47
        WHEN d.docket_id = '214770' THEN 48
        WHEN d.docket_id = '214611' THEN 49
        WHEN d.docket_id = '213896' THEN 50
        WHEN d.docket_id = '213827' THEN 51
        WHEN d.docket_id = '213285' THEN 52
        WHEN d.docket_id = '213045' THEN 53
        WHEN d.docket_id = '212973' THEN 54
        WHEN d.docket_id = '212464' THEN 55
        WHEN d.docket_id = '212063' THEN 56
        WHEN d.docket_id = '211566' THEN 57
        WHEN d.docket_id = '211191' THEN 58
        WHEN d.docket_id = '210928' THEN 59
        WHEN d.docket_id = '210360' THEN 60
        WHEN d.docket_id = '209655' THEN 61
        WHEN d.docket_id = '209467' THEN 62
        WHEN d.docket_id = '208997' THEN 63
        WHEN d.docket_id = '208760' THEN 64
        WHEN d.docket_id = '207898' THEN 65
        WHEN d.docket_id = '207851' THEN 66
        WHEN d.docket_id = '206893' THEN 67
        WHEN d.docket_id = '206111' THEN 68
        WHEN d.docket_id = '205898' THEN 69
        WHEN d.docket_id = '204802' THEN 70
        WHEN d.docket_id = '204585' THEN 71
        WHEN d.docket_id = '204159' THEN 72
        WHEN d.docket_id = '203078' THEN 73
        WHEN d.docket_id = '202871' THEN 74
        WHEN d.docket_id = '202294' THEN 75
        WHEN d.docket_id = '202281' THEN 76
        WHEN d.docket_id = '202234' THEN 77
        WHEN d.docket_id = '201808' THEN 78
        WHEN d.docket_id = '201254' THEN 79
        WHEN d.docket_id = '200605' THEN 80
        WHEN d.docket_id = '199632' THEN 81
        WHEN d.docket_id = '198711' THEN 82
        WHEN d.docket_id = '197782' THEN 83
        WHEN d.docket_id = '196588' THEN 84
        WHEN d.docket_id = '195892' THEN 85
        WHEN d.docket_id = '194046' THEN 86
        WHEN d.docket_id = '193591' THEN 87
        WHEN d.docket_id = '192545' THEN 88
        WHEN d.docket_id = '189629' THEN 89
        WHEN d.docket_id = '189463' THEN 90
    END;
    
    
-- select * from docket_disposition dd where dd.docket_id in(
-- 170401,113129,113589,116909,144162,145302,149064,184437,152065,152901,154448,155026,157098,159696,161068,128461,97491,130483,163774,165541,101607,101957,102764,166283,133673,168934,169171
-- );

-- select * from dockets d 
-- where d.docket_number in('NCR-01-00017-22','NCR-01-01883-20','NCR-02-00156-20','NCR-02-01953-20','NCR-03-00623-21','NCR-03-01071-21','NCR-05-00033-21','NCR-05-00927-22','NCR-05-01177-21','NCR-06-00467-21','NCR-06-01067-21','NCR-07-00052-21','NCR-07-00771-21','NCR-08-00384-21','NCR-09-00262-21','NCR-09-00297-20','NCR-09-01106-19','NCR-10-00177-20','NCR-10-00301-21','NCR-10-00959-21','NCR-10-01352-19','NCR-10-01532-19','NCR-10-01950-19','NCR-11-00209-21','NCR-11-00271-20','NCR-12-00290-21','NCR-12-00397-21');

-- SELECT 
-- 	d.docket_number, 
-- 	d.docket_id, 
-- 	IF(GROUP_CONCAT(DATE_FORMAT(sch.available_date, '%Y-%m-%d')) IS NULL, DATE_FORMAT(dt.actual_start_date, '%Y-%m-%d'), GROUP_CONCAT(DATE_FORMAT(sch.available_date, '%Y-%m-%d'))), 
-- 	IF(g.total IS NULL, '0', g.total) AS male_count,
-- 	IF(f.total IS NULL, '0', f.total) AS female_count
-- FROM 
--     dockets d 
--     LEFT JOIN cases a ON a.docket_id = d.docket_id
--     LEFT JOIN docket_tasks dt ON dt.docket_id = d.docket_id AND dt.activity_name = 'First mandatory conference'
--     LEFT JOIN param_availability_schedule sch ON sch.availability_schedule_id = dt.availability_schedule_id
--     LEFT JOIN (
--         SELECT 
--             aaa.case_id, 
--             COUNT(*) AS Total 
--         FROM 
--             case_parties AS aaa 
--             LEFT JOIN parties AS bbb ON aaa.party_id = bbb.party_id 
--         WHERE 
--             bbb.sex_flag = 'M' 
--         GROUP BY 
--             aaa.case_id
--     ) AS g ON g.case_id = a.case_id 
--     LEFT JOIN (
--         SELECT 
--             aaa.case_id, 
--             COUNT(*) AS Total 
--         FROM 
--             case_parties AS aaa 
--             LEFT JOIN parties AS bbb ON aaa.party_id = bbb.party_id 
--         WHERE 
--             bbb.sex_flag = 'F' 
--         GROUP BY 
--             aaa.case_id
--     ) AS f ON f.case_id = a.case_id
-- WHERE 
--     d.docket_number IN (
--           'NCR-04-00613-23','NCR-04-00531-23','NCR-04-00500-23','NCR-04-00455-23','NCR-04-00366-23','NCR-04-00286-23','NCR-04-00186-23','NCR-04-00137-23','NCR-04-00126-23','NCR-04-00049-23','NCR-03-01301-23','NCR-03-01259-23','NCR-03-01222-23','NCR-03-01155-23','NCR-03-01096-23','NCR-03-00999-23','NCR-03-00944-23','NCR-03-00863-23','NCR-03-00842-23','NCR-03-00799-23','NCR-03-00726-23','NCR-03-00708-23','NCR-03-00583-23','NCR-03-00553-23','NCR-03-00457-23','NCR-03-00368-23','NCR-03-00348-23','NCR-03-00199-23','NCR-03-00097-23','NCR-03-00016-23','NCR-02-01129-23','NCR-02-01056-23','NCR-02-00986-23','NCR-02-00890-23','NCR-02-00826-23','NCR-02-00766-23','NCR-02-00723-23','NCR-02-00617-23','NCR-02-00559-23','NCR-02-00554-23','NCR-02-00487-23','NCR-02-00348-23','NCR-02-00208-23','NCR-02-00174-23','NCR-02-00138-23','NCR-02-00039-23','NCR-01-01114-23','NCR-01-01024-23','NCR-01-00996-23','NCR-01-00948-23','NCR-01-00930-23','NCR-01-00761-23','NCR-01-00698-23','NCR-01-00680-23','NCR-01-00525-23','NCR-01-00443-23','NCR-01-00290-23','NCR-01-00179-23','NCR-01-00131-23','NCR-01-00027-23','NCR-12-00736-22','NCR-12-00683-22','NCR-12-00539-22','NCR-12-00465-22','NCR-12-00218-22','NCR-12-00203-22','NCR-11-00993-22','NCR-11-00789-22','NCR-11-00719-22','NCR-11-00507-22','NCR-11-00431-22','NCR-11-00308-22','NCR-10-00974-22','NCR-10-00898-22','NCR-10-00737-22','NCR-10-00733-22','NCR-10-00713-22','NCR-10-00580-22','NCR-10-00446-22','NCR-10-00248-22','NCR-09-01047-22','NCR-09-00717-22','NCR-09-00427-22','NCR-09-00081-22','NCR-08-00942-22','NCR-08-00347-22','NCR-08-00229-22','NCR-07-00955-22','NCR-07-00088-22','NCR-07-00031-22'
--     )
-- GROUP BY 
--     d.docket_number
-- ORDER BY 
--     CASE
--         WHEN d.docket_number = 'NCR-04-00613-23' THEN 1
--         WHEN d.docket_number = 'NCR-04-00531-23' THEN 2
--         WHEN d.docket_number = 'NCR-04-00500-23' THEN 3
--         WHEN d.docket_number = 'NCR-04-00455-23' THEN 4
--         WHEN d.docket_number = 'NCR-04-00366-23' THEN 5
--         WHEN d.docket_number = 'NCR-04-00286-23' THEN 6
--         WHEN d.docket_number = 'NCR-04-00186-23' THEN 7
--         WHEN d.docket_number = 'NCR-04-00137-23' THEN 8
--         WHEN d.docket_number = 'NCR-04-00126-23' THEN 9
--         WHEN d.docket_number = 'NCR-04-00049-23' THEN 10
--         WHEN d.docket_number = 'NCR-03-01301-23' THEN 11
--         WHEN d.docket_number = 'NCR-03-01259-23' THEN 12
--         WHEN d.docket_number = 'NCR-03-01222-23' THEN 13
--         WHEN d.docket_number = 'NCR-03-01155-23' THEN 14
--         WHEN d.docket_number = 'NCR-03-01096-23' THEN 15
--         WHEN d.docket_number = 'NCR-03-00999-23' THEN 16
--         WHEN d.docket_number = 'NCR-03-00944-23' THEN 17
--         WHEN d.docket_number = 'NCR-03-00863-23' THEN 18
--         WHEN d.docket_number = 'NCR-03-00842-23' THEN 19
--         WHEN d.docket_number = 'NCR-03-00799-23' THEN 20
--         WHEN d.docket_number = 'NCR-03-00726-23' THEN 21
--         WHEN d.docket_number = 'NCR-03-00708-23' THEN 22
--         WHEN d.docket_number = 'NCR-03-00583-23' THEN 23
--         WHEN d.docket_number = 'NCR-03-00553-23' THEN 24
--         WHEN d.docket_number = 'NCR-03-00457-23' THEN 25
--         WHEN d.docket_number = 'NCR-03-00368-23' THEN 26
--         WHEN d.docket_number = 'NCR-03-00348-23' THEN 27
--         WHEN d.docket_number = 'NCR-03-00199-23' THEN 28
--         WHEN d.docket_number = 'NCR-03-00097-23' THEN 29
--         WHEN d.docket_number = 'NCR-03-00016-23' THEN 30
--         WHEN d.docket_number = 'NCR-02-01129-23' THEN 31
--         WHEN d.docket_number = 'NCR-02-01056-23' THEN 32
--         WHEN d.docket_number = 'NCR-02-00986-23' THEN 33
--         WHEN d.docket_number = 'NCR-02-00890-23' THEN 34
--         WHEN d.docket_number = 'NCR-02-00826-23' THEN 35
--         WHEN d.docket_number = 'NCR-02-00766-23' THEN 36
--         WHEN d.docket_number = 'NCR-02-00723-23' THEN 37
--         WHEN d.docket_number = 'NCR-02-00617-23' THEN 38
--         WHEN d.docket_number = 'NCR-02-00559-23' THEN 39
--         WHEN d.docket_number = 'NCR-02-00554-23' THEN 40
--         WHEN d.docket_number = 'NCR-02-00487-23' THEN 41
--         WHEN d.docket_number = 'NCR-02-00348-23' THEN 42
--         WHEN d.docket_number = 'NCR-02-00208-23' THEN 43
--         WHEN d.docket_number = 'NCR-02-00174-23' THEN 44
--         WHEN d.docket_number = 'NCR-02-00138-23' THEN 45
--         WHEN d.docket_number = 'NCR-02-00039-23' THEN 46
--         WHEN d.docket_number = 'NCR-01-01114-23' THEN 47
--         WHEN d.docket_number = 'NCR-01-01024-23' THEN 48
--         WHEN d.docket_number = 'NCR-01-00996-23' THEN 49
--         WHEN d.docket_number = 'NCR-01-00948-23' THEN 50
--         WHEN d.docket_number = 'NCR-01-00930-23' THEN 51
--         WHEN d.docket_number = 'NCR-01-00761-23' THEN 52
--         WHEN d.docket_number = 'NCR-01-00698-23' THEN 53
--         WHEN d.docket_number = 'NCR-01-00680-23' THEN 54
--         WHEN d.docket_number = 'NCR-01-00525-23' THEN 55
--         WHEN d.docket_number = 'NCR-01-00443-23' THEN 56
--         WHEN d.docket_number = 'NCR-01-00290-23' THEN 57
--         WHEN d.docket_number = 'NCR-01-00179-23' THEN 58
--         WHEN d.docket_number = 'NCR-01-00131-23' THEN 59
--         WHEN d.docket_number = 'NCR-01-00027-23' THEN 60
--         WHEN d.docket_number = 'NCR-12-00736-22' THEN 61
--         WHEN d.docket_number = 'NCR-12-00683-22' THEN 62
--         WHEN d.docket_number = 'NCR-12-00539-22' THEN 63
--         WHEN d.docket_number = 'NCR-12-00465-22' THEN 64
--         WHEN d.docket_number = 'NCR-12-00218-22' THEN 65
--         WHEN d.docket_number = 'NCR-12-00203-22' THEN 66
--         WHEN d.docket_number = 'NCR-11-00993-22' THEN 67
--         WHEN d.docket_number = 'NCR-11-00789-22' THEN 68
--         WHEN d.docket_number = 'NCR-11-00719-22' THEN 69
-- 		WHEN d.docket_number = 'NCR-11-00507-22' THEN 70
-- 		WHEN d.docket_number = 'NCR-11-00431-22' THEN 71
-- 		WHEN d.docket_number = 'NCR-11-00308-22' THEN 72
-- 		WHEN d.docket_number = 'NCR-10-00974-22' THEN 73
-- 		WHEN d.docket_number = 'NCR-10-00898-22' THEN 74
-- 		WHEN d.docket_number = 'NCR-10-00737-22' THEN 75
-- 		WHEN d.docket_number = 'NCR-10-00733-22' THEN 76
-- 		WHEN d.docket_number = 'NCR-10-00713-22' THEN 77
-- 		WHEN d.docket_number = 'NCR-10-00580-22' THEN 78
-- 		WHEN d.docket_number = 'NCR-10-00446-22' THEN 79
-- 		WHEN d.docket_number = 'NCR-10-00248-22' THEN 80
-- 		WHEN d.docket_number = 'NCR-09-01047-22' THEN 81
-- 		WHEN d.docket_number = 'NCR-09-00717-22' THEN 82
-- 		WHEN d.docket_number = 'NCR-09-00427-22' THEN 83
-- 		WHEN d.docket_number = 'NCR-09-00081-22' THEN 84
-- 		WHEN d.docket_number = 'NCR-08-00942-22' THEN 85
-- 		WHEN d.docket_number = 'NCR-08-00347-22' THEN 86
-- 		WHEN d.docket_number = 'NCR-08-00229-22' THEN 87
-- 		WHEN d.docket_number = 'NCR-07-00955-22' THEN 88
-- 		WHEN d.docket_number = 'NCR-07-00088-22' THEN 89
-- 		WHEN d.docket_number = 'NCR-07-00031-22' THEN 90
-- 		ELSE NULL
-- 		END;


-- select * from cases;

-- SELECT * FROM dockets where docket_number = 'RABVII-09-00119-23';
-- select * from docket_disposition where docket_id = 256947; -- removed
-- SELECT * FROM docket_decision where docket_id = 256947; -- removed
-- SELECT * FROM docket_entry_finality where docket_id = 256947; -- removed

-- SELECT * FROM dockets where docket_number = 'RABVII-09-00079-23';
-- select * from docket_disposition where docket_id = 255770; -- removed
-- SELECT * FROM docket_decision where docket_id = 255770; -- no data
-- SELECT * FROM docket_entry_finality where docket_id = 255770; -- no data


-- SELECT 
--     d.docket_number, 
--     d.docket_id, 
--     GROUP_CONCAT(DATE_FORMAT(sch.available_date, '%Y-%m-%d')), 
--     IF(g.total IS NULL, '0', g.total) AS male_count,
--     IF(f.total IS NULL, '0', f.total) AS female_count
-- FROM 
--     dockets d 
--     LEFT JOIN cases a ON a.docket_id = d.docket_id
--     LEFT JOIN docket_tasks dt ON dt.docket_id = d.docket_id AND dt.activity_name = 'First mandatory conference'
--     LEFT JOIN param_availability_schedule sch ON sch.availability_schedule_id = dt.availability_schedule_id
--     LEFT JOIN (
--         SELECT 
--             aaa.case_id, 
--             COUNT(*) AS Total 
--         FROM 
--             case_parties AS aaa 
--             LEFT JOIN parties AS bbb ON aaa.party_id = bbb.party_id 
--         WHERE 
--             bbb.sex_flag = 'M' 
--         GROUP BY 
--             aaa.case_id
--     ) AS g ON g.case_id = a.case_id 
--     LEFT JOIN (
--         SELECT 
--             aaa.case_id, 
--             COUNT(*) AS Total 
--         FROM 
--             case_parties AS aaa 
--             LEFT JOIN parties AS bbb ON aaa.party_id = bbb.party_id 
--         WHERE 
--             bbb.sex_flag = 'F' 
--         GROUP BY 
--             aaa.case_id
--     ) AS f ON f.case_id = a.case_id
-- WHERE 
--     d.docket_number IN (
--       'NCR-08-01005-19','NCR-09-00657-19','NCR-09-01302-19','NCR-01-00027-20','NCR-01-01515-20','NCR-03-00051-20','NCR-03-00576-20','NCR-10-00570-20','NCR-03-01352-21','NCR-04-00207-21','NCR-04-00618-21','NCR-05-00267-21','NCR-05-00532-21','NCR-05-00677-21','NCR-05-00735-21','NCR-05-00780-21','NCR-05-01064-21','NCR-05-01093-21','NCR-06-00189-21','NCR-06-00406-21','NCR-06-00605-21','NCR-06-00664-21','NCR-06-00853-21','NCR-06-00914-21','NCR-06-01170-21','NCR-07-00053-21','NCR-07-00122-21','NCR-06-00339-21','NCR-07-00377-21','NCR-07-00518-21','NCR-07-00530-21','NCR-07-00652-21','NCR-07-00718-21','NCR-07-00803-21','NCR-07-00852-21','NCR-07-00895-21','NCR-08-00055-21','NCR-08-00271-21','NCR-08-00412-21','NCR-08-00476-21','NCR-09-00363-21','NCR-09-00526-21','NCR-09-00733-21','NCR-09-00785-21','NCR-10-00333-21','NCR-10-00385-21','NCR-10-00472-21','NCR-10-00568-21','NCR-10-00755-21','NCR-10-00979-21','NCR-10-00984-21','NCR-11-00163-21','NCR-11-00151-21','NCR-11-00315-21','NCR-11-00389-21','NCR-11-00449-21','NCR-11-00591-21','NCR-11-00735-21','NCR-12-00049-21','NCR-12-00106-21','NCR-12-00199-21','NCR-12-00307-21','NCR-12-00507-21','NCR-12-00571-21','NCR-12-00621-21','NCR-12-00629-21','NCR-12-00710-21','NCR-12-00797-21','NCR-12-00845-21','NCR-12-00944-21','NCR-01-00381-22','NCR-03-00647-22','NCR-06-00487-22','NCR-06-00650-22','NCR-06-01021-22'
--     )
-- GROUP BY 
--     d.docket_number
-- ORDER BY 
--     CASE
--         WHEN d.docket_number = 'NCR-08-01005-19' THEN 1
--         WHEN d.docket_number = 'NCR-09-00657-19' THEN 2
--         WHEN d.docket_number = 'NCR-09-01302-19' THEN 3
--         WHEN d.docket_number = 'NCR-01-00027-20' THEN 4
--         WHEN d.docket_number = 'NCR-01-01515-20' THEN 5
--         WHEN d.docket_number = 'NCR-03-00051-20' THEN 6
--         WHEN d.docket_number = 'NCR-03-00576-20' THEN 7
--         WHEN d.docket_number = 'NCR-10-00570-20' THEN 8
--         WHEN d.docket_number = 'NCR-03-01352-21' THEN 9
--         WHEN d.docket_number = 'NCR-04-00207-21' THEN 10
--         WHEN d.docket_number = 'NCR-04-00618-21' THEN 11
--         WHEN d.docket_number = 'NCR-05-00267-21' THEN 12
--         WHEN d.docket_number = 'NCR-05-00532-21' THEN 13
--         WHEN d.docket_number = 'NCR-05-00677-21' THEN 14
--         WHEN d.docket_number = 'NCR-05-00735-21' THEN 15
--         WHEN d.docket_number = 'NCR-05-00780-21' THEN 16
--         WHEN d.docket_number = 'NCR-05-01064-21' THEN 17
--         WHEN d.docket_number = 'NCR-05-01093-21' THEN 18
--         WHEN d.docket_number = 'NCR-06-00189-21' THEN 19
--         WHEN d.docket_number = 'NCR-06-00406-21' THEN 20
--         WHEN d.docket_number = 'NCR-06-00605-21' THEN 21
--         WHEN d.docket_number = 'NCR-06-00664-21' THEN 22
--         WHEN d.docket_number = 'NCR-06-00853-21' THEN 23
--         WHEN d.docket_number = 'NCR-06-00914-21' THEN 24
--         WHEN d.docket_number = 'NCR-06-01170-21' THEN 25
--         WHEN d.docket_number = 'NCR-07-00053-21' THEN 26
--         WHEN d.docket_number = 'NCR-07-00122-21' THEN 27
--         WHEN d.docket_number = 'NCR-06-00339-21' THEN 28
--         WHEN d.docket_number = 'NCR-07-00377-21' THEN 29
--         WHEN d.docket_number = 'NCR-07-00518-21' THEN 30
--         WHEN d.docket_number = 'NCR-07-00530-21' THEN 31
--         WHEN d.docket_number = 'NCR-07-00652-21' THEN 32
--         WHEN d.docket_number = 'NCR-07-00718-21' THEN 33
--         WHEN d.docket_number = 'NCR-07-00803-21' THEN 34
--         WHEN d.docket_number = 'NCR-07-00852-21' THEN 35
--         WHEN d.docket_number = 'NCR-07-00895-21' THEN 36
--         WHEN d.docket_number = 'NCR-08-00055-21' THEN 37
--         WHEN d.docket_number = 'NCR-08-00271-21' THEN 38
--         WHEN d.docket_number = 'NCR-08-00412-21' THEN 39
--         WHEN d.docket_number = 'NCR-08-00476-21' THEN 40
--         WHEN d.docket_number = 'NCR-09-00363-21' THEN 41
--         WHEN d.docket_number = 'NCR-09-00526-21' THEN 42
--         WHEN d.docket_number = 'NCR-09-00733-21' THEN 43
--         WHEN d.docket_number = 'NCR-09-00785-21' THEN 44
--         WHEN d.docket_number = 'NCR-10-00333-21' THEN 45
--         WHEN d.docket_number = 'NCR-10-00385-21' THEN 46
--         WHEN d.docket_number = 'NCR-10-00472-21' THEN 47
--         WHEN d.docket_number = 'NCR-10-00568-21' THEN 48
--         WHEN d.docket_number = 'NCR-10-00755-21' THEN 49
--         WHEN d.docket_number = 'NCR-10-00979-21' THEN 50
--         WHEN d.docket_number = 'NCR-10-00984-21' THEN 51
--         WHEN d.docket_number = 'NCR-11-00163-21' THEN 52
--         WHEN d.docket_number = 'NCR-11-00151-21' THEN 53
--         WHEN d.docket_number = 'NCR-11-00315-21' THEN 54
--         WHEN d.docket_number = 'NCR-11-00389-21' THEN 55
--         WHEN d.docket_number = 'NCR-11-00449-21' THEN 56
--         WHEN d.docket_number = 'NCR-11-00591-21' THEN 57
--         WHEN d.docket_number = 'NCR-11-00735-21' THEN 58
--         WHEN d.docket_number = 'NCR-12-00049-21' THEN 59
--         WHEN d.docket_number = 'NCR-12-00106-21' THEN 60
--         WHEN d.docket_number = 'NCR-12-00199-21' THEN 61
--         WHEN d.docket_number = 'NCR-12-00307-21' THEN 62
--         WHEN d.docket_number = 'NCR-12-00507-21' THEN 63
--         WHEN d.docket_number = 'NCR-12-00571-21' THEN 64
--         WHEN d.docket_number = 'NCR-12-00621-21' THEN 65
--         WHEN d.docket_number = 'NCR-12-00629-21' THEN 66
--         WHEN d.docket_number = 'NCR-12-00710-21' THEN 67
--         WHEN d.docket_number = 'NCR-12-00797-21' THEN 68
--         WHEN d.docket_number = 'NCR-12-00845-21' THEN 69
--         WHEN d.docket_number = 'NCR-12-00944-21' THEN 70
--         WHEN d.docket_number = 'NCR-01-00381-22' THEN 71
--         WHEN d.docket_number = 'NCR-03-00647-22' THEN 72
--         WHEN d.docket_number = 'NCR-06-00487-22' THEN 73
--         WHEN d.docket_number = 'NCR-06-00650-22' THEN 74
--         WHEN d.docket_number = 'NCR-06-01021-22' THEN 75
--         ELSE NULL
--     END;



-- SELECT 
--     d.docket_number, 
--     d.docket_id, 
--     GROUP_CONCAT(DATE_FORMAT(sch.available_date, '%Y-%m-%d')), 
--     IF(g.total IS NULL, '0', g.total) AS male_count,
--     IF(f.total IS NULL, '0', f.total) AS female_count
-- FROM 
--     dockets d 
--     LEFT JOIN cases a ON a.docket_id = d.docket_id
--     LEFT JOIN docket_tasks dt ON dt.docket_id = d.docket_id AND dt.activity_name = 'First mandatory conference'
--     LEFT JOIN param_availability_schedule sch ON sch.availability_schedule_id = dt.availability_schedule_id
--     LEFT JOIN (
--         SELECT 
--             aaa.case_id, 
--             COUNT(*) AS Total 
--         FROM 
--             case_parties AS aaa 
--             LEFT JOIN parties AS bbb ON aaa.party_id = bbb.party_id 
--         WHERE 
--             bbb.sex_flag = 'M' 
--         GROUP BY 
--             aaa.case_id
--     ) AS g ON g.case_id = a.case_id 
--     LEFT JOIN (
--         SELECT 
--             aaa.case_id, 
--             COUNT(*) AS Total 
--         FROM 
--             case_parties AS aaa 
--             LEFT JOIN parties AS bbb ON aaa.party_id = bbb.party_id 
--         WHERE 
--             bbb.sex_flag = 'F' 
--         GROUP BY 
--             aaa.case_id
--     ) AS f ON f.case_id = a.case_id
-- WHERE 
--     d.docket_number IN (
--         'NCR-02-00436-21', 'NCR-01-00300-22', 'NCR-01-00078-22', 'NCR-01-00534-22', 
--         'NCR-02-00047-22', 'NCR-02-00505-22', 'NCR-02-00529-22', 'NCR-02-00659-22', 
--         'NCR-02-00685-22', 'NCR-02-00749-22', 'NCR-02-00901-22', 'NCR-03-00042-22', 
--         'NCR-03-00080-22', 'NCR-03-00307-22', 'NCR-03-00379-22', 'NCR-03-00479-22', 
--         'NCR-03-00685-22', 'NCR-03-00756-22', 'NCR-03-00820-22', 'NCR-03-01079-22', 
--         'NCR-03-01286-22', 'NCR-03-01335-22', 'NCR-02-00959-22', 'NCR-04-00156-22', 
--         'NCR-04-00276-22', 'NCR-04-00459-22', 'NCR-04-00616-22', 'NCR-04-00803-22', 
--         'NCR-04-00863-22', 'NCR-04-00864-22', 'NCR-04-00214-22', 'NCR-05-00070-22', 
--         'NCR-05-00126-22', 'NCR-05-00228-22', 'NCR-05-00484-22', 'NCR-05-00684-22', 
--         'NCR-05-00735-22', 'NCR-05-00864-22', 'NCR-06-00053-22', 'NCR-06-00121-22', 
--         'NCR-06-00284-22', 'NCR-06-00342-22', 'NCR-06-00638-22', 'NCR-05-00923-22', 
--         'NCR-07-00335-22', 'NCR-07-00728-22'
--     )
-- GROUP BY 
--     d.docket_number
-- ORDER BY 
--     CASE
--         WHEN d.docket_number = 'NCR-02-00436-21' THEN 1
--         WHEN d.docket_number = 'NCR-01-00300-22' THEN 2
--         WHEN d.docket_number = 'NCR-01-00078-22' THEN 3
--         WHEN d.docket_number = 'NCR-01-00534-22' THEN 4
--         WHEN d.docket_number = 'NCR-02-00047-22' THEN 5
--         WHEN d.docket_number = 'NCR-02-00505-22' THEN 6
--         WHEN d.docket_number = 'NCR-02-00529-22' THEN 7
--         WHEN d.docket_number = 'NCR-02-00659-22' THEN 8
--         WHEN d.docket_number = 'NCR-02-00685-22' THEN 9
--         WHEN d.docket_number = 'NCR-02-00749-22' THEN 10
--         WHEN d.docket_number = 'NCR-02-00901-22' THEN 11
--         WHEN d.docket_number = 'NCR-03-00042-22' THEN 12
--         WHEN d.docket_number = 'NCR-03-00080-22' THEN 13
--         WHEN d.docket_number = 'NCR-03-00307-22' THEN 14
--         WHEN d.docket_number = 'NCR-03-00379-22' THEN 15
--         WHEN d.docket_number = 'NCR-03-00479-22' THEN 16
--         WHEN d.docket_number = 'NCR-03-00685-22' THEN 17
--         WHEN d.docket_number = 'NCR-03-00756-22' THEN 18
--         WHEN d.docket_number = 'NCR-03-00820-22' THEN 19
--         WHEN d.docket_number = 'NCR-03-01079-22' THEN 20
--         WHEN d.docket_number = 'NCR-03-01286-22' THEN 21
--         WHEN d.docket_number = 'NCR-03-01335-22' THEN 22
--         WHEN d.docket_number = 'NCR-02-00959-22' THEN 23
--         WHEN d.docket_number = 'NCR-04-00156-22' THEN 24
--         WHEN d.docket_number = 'NCR-04-00276-22' THEN 25
--         WHEN d.docket_number = 'NCR-04-00459-22' THEN 26
--         WHEN d.docket_number = 'NCR-04-00616-22' THEN 27
--         WHEN d.docket_number = 'NCR-04-00803-22' THEN 28
--         WHEN d.docket_number = 'NCR-04-00863-22' THEN 29
--         WHEN d.docket_number = 'NCR-04-00864-22' THEN 30
--         WHEN d.docket_number = 'NCR-04-00214-22' THEN 31
--         WHEN d.docket_number = 'NCR-05-00070-22' THEN 32
--         WHEN d.docket_number = 'NCR-05-00126-22' THEN 33
--         WHEN d.docket_number = 'NCR-05-00228-22' THEN 34
--         WHEN d.docket_number = 'NCR-05-00484-22' THEN 35
--         WHEN d.docket_number = 'NCR-05-00684-22' THEN 36
--         WHEN d.docket_number = 'NCR-05-00735-22' THEN 37
--         WHEN d.docket_number = 'NCR-05-00864-22' THEN 38
--         WHEN d.docket_number = 'NCR-06-00053-22' THEN 39
--         WHEN d.docket_number = 'NCR-06-00121-22' THEN 40
--         WHEN d.docket_number = 'NCR-06-00284-22' THEN 41
--         WHEN d.docket_number = 'NCR-06-00342-22' THEN 42
--         WHEN d.docket_number = 'NCR-06-00638-22' THEN 43
--         WHEN d.docket_number = 'NCR-05-00923-22' THEN 44
--         WHEN d.docket_number = 'NCR-07-00335-22' THEN 45
--         WHEN d.docket_number = 'NCR-07-00728-22' THEN 46
--         ELSE NULL
--     END;


--  SELECT * FROM dockets where docket_number = 'RABVII-04-00030-24';
-- select * from docket_disposition where docket_id = 288159;

-- SELECT * FROM docket_decision where docket_id = 288159;

-- SELECT * FROM docket_entry_finality where docket_id = 288159;

-- select d.docket_number, c.case_title from cases c 
-- left join dockets d on d.docket_id = c.docket_id
-- where c.docket_id = 288159 or c.docket_number = 'RABVII-04-00030-24';

-- SELECT 
--     d.docket_number, 
--     d.docket_id, 
--     GROUP_CONCAT(DATE_FORMAT(sch.available_date, '%Y-%m-%d')), 
--     IF(g.total IS NULL, '0', g.total) AS male_count,
--     IF(f.total IS NULL, '0', f.total) AS female_count
-- FROM 
--     dockets d 
--     LEFT JOIN cases a ON a.docket_id = d.docket_id
--     LEFT JOIN docket_tasks dt ON dt.docket_id = d.docket_id AND dt.activity_name = 'First mandatory conference'
--     LEFT JOIN param_availability_schedule sch ON sch.availability_schedule_id = dt.availability_schedule_id
--     LEFT JOIN (
--         SELECT 
--             aaa.case_id, 
--             COUNT(*) AS Total 
--         FROM 
--             case_parties AS aaa 
--             LEFT JOIN parties AS bbb ON aaa.party_id = bbb.party_id 
--         WHERE 
--             bbb.sex_flag = 'M' 
--         GROUP BY 
--             aaa.case_id
--     ) AS g ON g.case_id = a.case_id 
--     LEFT JOIN (
--         SELECT 
--             aaa.case_id, 
--             COUNT(*) AS Total 
--         FROM 
--             case_parties AS aaa 
--             LEFT JOIN parties AS bbb ON aaa.party_id = bbb.party_id 
--         WHERE 
--             bbb.sex_flag = 'F' 
--         GROUP BY 
--             aaa.case_id
--     ) AS f ON f.case_id = a.case_id
-- WHERE 
--     d.docket_number IN (
--       'NCR-10-01352-19','NCR-11-00680-19','NCR-10-01950-19','NCR-08-01502-19','NCR-10-01532-19','NCR-09-00657-19','NCR-03-00013-20','NCR-03-00051-20','NCR-08-01005-19','NCR-09-01302-19','NCR-01-01883-20','NCR-01-01515-20','NCR-09-01106-19','NCR-02-00173-20','NCR-02-00651-20','NCR-09-00297-20','NCR-02-00436-21','NCR-02-01953-20','NCR-11-00271-20','NCR-01-00027-20','NCR-09-00441-20','NCR-03-00576-20','NCR-05-00511-21','NCR-06-01067-21','NCR-10-00570-20','NCR-07-00061-20','NCR-09-00437-21','NCR-02-00156-20','NCR-10-00177-20','NCR-03-00231-21','NCR-03-00623-21','NCR-03-01071-21','NCR-04-00311-21','NCR-05-00033-21','NCR-05-00178-21','NCR-05-01177-21','NCR-06-00229-21','NCR-06-00467-21','NCR-07-00771-21','NCR-06-00406-21','NCR-08-00384-21','NCR-10-00301-21','NCR-11-00913-21','NCR-12-00397-21','NCR-07-00052-21','NCR-09-00262-21','NCR-01-00300-22','NCR-10-00959-21','NCR-11-00840-21','NCR-11-00209-21','NCR-03-01352-21','NCR-04-00207-21','NCR-04-00618-21','NCR-05-00267-21','NCR-05-00532-21','NCR-05-00735-21','NCR-05-01064-21','NCR-05-00780-21','NCR-06-00189-21','NCR-06-00339-21','NCR-06-00605-21','NCR-06-00664-21','NCR-06-00853-21','NCR-06-00914-21','NCR-05-01093-21','NCR-05-00677-21','NCR-06-01170-21','NCR-07-00053-21','NCR-07-00122-21','NCR-07-00377-21','NCR-07-00518-21','NCR-07-00530-21','NCR-07-00652-21','NCR-07-00718-21','NCR-07-00852-21','NCR-07-00803-21','NCR-07-00895-21','NCR-08-00055-21','NCR-08-00271-21','NCR-08-00476-21','NCR-09-00363-21','NCR-09-00526-21','NCR-09-00733-21','NCR-09-00785-21','NCR-10-00333-21','NCR-10-00385-21','NCR-10-00568-21','NCR-10-00755-21','NCR-10-00979-21','NCR-10-00984-21','NCR-11-00151-21','NCR-11-00163-21','NCR-11-00315-21','NCR-11-00389-21','NCR-11-00449-21','NCR-11-00591-21','NCR-11-00735-21','NCR-12-00049-21','NCR-12-00106-21','NCR-12-00199-21','NCR-12-00507-21','NCR-12-00571-21','NCR-12-00621-21','NCR-12-00797-21','NCR-12-00845-21','NCR-12-00629-21','NCR-01-00078-22','NCR-01-00534-22','NCR-02-00047-22','NCR-02-00505-22','NCR-02-00529-22','NCR-02-00659-22','NCR-02-00685-22','NCR-02-00749-22','NCR-02-00901-22','NCR-09-00588-21','NCR-10-00472-21','NCR-10-00535-21','NCR-03-00042-22','NCR-03-00080-22','NCR-03-00307-22','NCR-03-00379-22','NCR-03-00479-22','NCR-03-00685-22','NCR-03-00756-22','NCR-03-00820-22','NCR-03-01079-22','NCR-03-01286-22','NCR-03-01335-22','NCR-02-00959-22','NCR-12-00290-21','NCR-03-00647-22','NCR-04-00156-22','NCR-04-00276-22','NCR-04-00459-22','NCR-04-00616-22','NCR-04-00803-22','NCR-04-00863-22','NCR-04-00864-22','NCR-08-00412-21','NCR-04-00214-22','NCR-12-00307-21','NCR-12-00922-21','NCR-05-00070-22','NCR-05-00126-22','NCR-05-00228-22','NCR-05-00484-22','NCR-05-00684-22','NCR-05-00735-22','NCR-05-00864-22','NCR-06-00053-22','NCR-06-00121-22','NCR-06-00284-22','NCR-06-00342-22','NCR-06-00638-22','NCR-05-00923-22','NCR-07-00335-22','NCR-07-00728-22','NCR-06-00650-22','NCR-06-01021-22','NCR-11-00636-21','NCR-12-00710-21','NCR-12-00802-21','NCR-12-00944-21','NCR-01-00381-22','NCR-01-00017-22','NCR-07-00451-22','NCR-05-00927-22','NCR-06-00487-22'
--     )
-- GROUP BY 
--     d.docket_number
-- ORDER BY 
--     CASE
--         WHEN d.docket_number = 'NCR-10-01352-19' THEN 1
--         WHEN d.docket_number = 'NCR-11-00680-19' THEN 2
--         WHEN d.docket_number = 'NCR-10-01950-19' THEN 3
--         WHEN d.docket_number = 'NCR-08-01502-19' THEN 4
--         WHEN d.docket_number = 'NCR-10-01532-19' THEN 5
--         WHEN d.docket_number = 'NCR-09-00657-19' THEN 6
--         WHEN d.docket_number = 'NCR-03-00013-20' THEN 7
--         WHEN d.docket_number = 'NCR-03-00051-20' THEN 8
--         WHEN d.docket_number = 'NCR-08-01005-19' THEN 9
--         WHEN d.docket_number = 'NCR-09-01302-19' THEN 10
--         WHEN d.docket_number = 'NCR-01-01883-20' THEN 11
--         WHEN d.docket_number = 'NCR-01-01515-20' THEN 12
--         WHEN d.docket_number = 'NCR-09-01106-19' THEN 13
--         WHEN d.docket_number = 'NCR-02-00173-20' THEN 14
--         WHEN d.docket_number = 'NCR-02-00651-20' THEN 15
--         WHEN d.docket_number = 'NCR-09-00297-20' THEN 16
--         WHEN d.docket_number = 'NCR-02-00436-21' THEN 17
--         WHEN d.docket_number = 'NCR-02-01953-20' THEN 18
--         WHEN d.docket_number = 'NCR-11-00271-20' THEN 19
--         WHEN d.docket_number = 'NCR-01-00027-20' THEN 20
--         WHEN d.docket_number = 'NCR-09-00441-20' THEN 21
--         WHEN d.docket_number = 'NCR-03-00576-20' THEN 22
--         WHEN d.docket_number = 'NCR-05-00511-21' THEN 23
--         WHEN d.docket_number = 'NCR-06-01067-21' THEN 24
--         WHEN d.docket_number = 'NCR-10-00570-20' THEN 25
--         WHEN d.docket_number = 'NCR-07-00061-20' THEN 26
--         WHEN d.docket_number = 'NCR-09-00437-21' THEN 27
--         WHEN d.docket_number = 'NCR-02-00156-20' THEN 28
--         WHEN d.docket_number = 'NCR-10-00177-20' THEN 29
--         WHEN d.docket_number = 'NCR-03-00231-21' THEN 30
--         WHEN d.docket_number = 'NCR-03-00623-21' THEN 31
--         WHEN d.docket_number = 'NCR-03-01071-21' THEN 32
--         WHEN d.docket_number = 'NCR-04-00311-21' THEN 33
--         WHEN d.docket_number = 'NCR-05-00033-21' THEN 34
--         WHEN d.docket_number = 'NCR-05-00178-21' THEN 35
--         WHEN d.docket_number = 'NCR-05-01177-21' THEN 36
--         WHEN d.docket_number = 'NCR-06-00229-21' THEN 37
--         WHEN d.docket_number = 'NCR-06-00467-21' THEN 38
--         WHEN d.docket_number = 'NCR-07-00771-21' THEN 39
--         WHEN d.docket_number = 'NCR-06-00406-21' THEN 40
--         WHEN d.docket_number = 'NCR-08-00384-21' THEN 41
--         WHEN d.docket_number = 'NCR-10-00301-21' THEN 42
--         WHEN d.docket_number = 'NCR-11-00913-21' THEN 43
--         WHEN d.docket_number = 'NCR-12-00397-21' THEN 44
--         WHEN d.docket_number = 'NCR-07-00052-21' THEN 45
--         WHEN d.docket_number = 'NCR-09-00262-21' THEN 46
--         WHEN d.docket_number = 'NCR-01-00300-22' THEN 47
--         WHEN d.docket_number = 'NCR-10-00959-21' THEN 48
--         WHEN d.docket_number = 'NCR-11-00840-21' THEN 49
--         WHEN d.docket_number = 'NCR-11-00209-21' THEN 50
--         WHEN d.docket_number = 'NCR-03-01352-21' THEN 51
--         WHEN d.docket_number = 'NCR-04-00207-21' THEN 52
--         WHEN d.docket_number = 'NCR-04-00618-21' THEN 53
--         WHEN d.docket_number = 'NCR-05-00267-21' THEN 54
--         WHEN d.docket_number = 'NCR-05-00532-21' THEN 55
--         WHEN d.docket_number = 'NCR-05-00735-21' THEN 56
--         WHEN d.docket_number = 'NCR-05-01064-21' THEN 57
--         WHEN d.docket_number = 'NCR-05-00780-21' THEN 58
--         WHEN d.docket_number = 'NCR-06-00189-21' THEN 59
--         WHEN d.docket_number = 'NCR-06-00339-21' THEN 60
--         WHEN d.docket_number = 'NCR-06-00605-21' THEN 61
--         WHEN d.docket_number = 'NCR-06-00664-21' THEN 62
--         WHEN d.docket_number = 'NCR-06-00853-21' THEN 63
--         WHEN d.docket_number = 'NCR-06-00914-21' THEN 64
--         WHEN d.docket_number = 'NCR-05-01093-21' THEN 65
--         WHEN d.docket_number = 'NCR-05-00677-21' THEN 66
--         WHEN d.docket_number = 'NCR-06-01170-21' THEN 67
--         WHEN d.docket_number = 'NCR-07-00053-21' THEN 68
--         WHEN d.docket_number = 'NCR-07-00122-21' THEN 69
--         WHEN d.docket_number = 'NCR-07-00377-21' THEN 70
--         WHEN d.docket_number = 'NCR-07-00518-21' THEN 71
--         WHEN d.docket_number = 'NCR-07-00530-21' THEN 72
--         WHEN d.docket_number = 'NCR-07-00652-21' THEN 73
--         WHEN d.docket_number = 'NCR-07-00718-21' THEN 74
--         WHEN d.docket_number = 'NCR-07-00852-21' THEN 75
--         WHEN d.docket_number = 'NCR-07-00803-21' THEN 76
--         WHEN d.docket_number = 'NCR-07-00895-21' THEN 77
--         WHEN d.docket_number = 'NCR-08-00055-21' THEN 78
--         WHEN d.docket_number = 'NCR-08-00271-21' THEN 79
--         WHEN d.docket_number = 'NCR-08-00476-21' THEN 80
--         WHEN d.docket_number = 'NCR-09-00363-21' THEN 81
--         WHEN d.docket_number = 'NCR-09-00526-21' THEN 82
--         WHEN d.docket_number = 'NCR-09-00733-21' THEN 83
--         WHEN d.docket_number = 'NCR-09-00785-21' THEN 84
--         WHEN d.docket_number = 'NCR-10-00333-21' THEN 85
--         WHEN d.docket_number = 'NCR-10-00385-21' THEN 86
--         WHEN d.docket_number = 'NCR-10-00568-21' THEN 87
--         WHEN d.docket_number = 'NCR-10-00755-21' THEN 88
--         WHEN d.docket_number = 'NCR-10-00979-21' THEN 89
--         WHEN d.docket_number = 'NCR-10-00984-21' THEN 90
--         WHEN d.docket_number = 'NCR-11-00151-21' THEN 91
--         WHEN d.docket_number = 'NCR-11-00163-21' THEN 92
--         WHEN d.docket_number = 'NCR-11-00315-21' THEN 93
--         WHEN d.docket_number = 'NCR-11-00389-21' THEN 94
--         WHEN d.docket_number = 'NCR-11-00449-21' THEN 95
--         WHEN d.docket_number = 'NCR-11-00591-21' THEN 96
--         WHEN d.docket_number = 'NCR-11-00735-21' THEN 97
--         WHEN d.docket_number = 'NCR-12-00049-21' THEN 98
--         WHEN d.docket_number = 'NCR-12-00106-21' THEN 99
--         WHEN d.docket_number = 'NCR-12-00199-21' THEN 100
--         WHEN d.docket_number = 'NCR-12-00507-21' THEN 101
--         WHEN d.docket_number = 'NCR-12-00571-21' THEN 102
--         WHEN d.docket_number = 'NCR-12-00621-21' THEN 103
--         WHEN d.docket_number = 'NCR-12-00797-21' THEN 104
--         WHEN d.docket_number = 'NCR-12-00845-21' THEN 105
--         WHEN d.docket_number = 'NCR-12-00629-21' THEN 106
--         WHEN d.docket_number = 'NCR-01-00078-22' THEN 107
--         WHEN d.docket_number = 'NCR-01-00534-22' THEN 108
--         WHEN d.docket_number = 'NCR-02-00047-22' THEN 109
--         WHEN d.docket_number = 'NCR-02-00505-22' THEN 110
--         WHEN d.docket_number = 'NCR-02-00529-22' THEN 111
--         WHEN d.docket_number = 'NCR-02-00659-22' THEN 112
--         WHEN d.docket_number = 'NCR-02-00685-22' THEN 113
--         WHEN d.docket_number = 'NCR-02-00749-22' THEN 114
--         WHEN d.docket_number = 'NCR-02-00901-22' THEN 115
--         WHEN d.docket_number = 'NCR-09-00588-21' THEN 116
--         WHEN d.docket_number = 'NCR-10-00472-21' THEN 117
--         WHEN d.docket_number = 'NCR-10-00535-21' THEN 118
--         WHEN d.docket_number = 'NCR-03-00042-22' THEN 119
--         WHEN d.docket_number = 'NCR-03-00080-22' THEN 120
--         WHEN d.docket_number = 'NCR-03-00307-22' THEN 121
--         WHEN d.docket_number = 'NCR-03-00379-22' THEN 122
--         WHEN d.docket_number = 'NCR-03-00479-22' THEN 123
--         WHEN d.docket_number = 'NCR-03-00685-22' THEN 124
--         WHEN d.docket_number = 'NCR-03-00756-22' THEN 125
--         WHEN d.docket_number = 'NCR-03-00820-22' THEN 126
--         WHEN d.docket_number = 'NCR-03-01079-22' THEN 127
--         WHEN d.docket_number = 'NCR-03-01286-22' THEN 128
--         WHEN d.docket_number = 'NCR-03-01335-22' THEN 129
--         WHEN d.docket_number = 'NCR-02-00959-22' THEN 130
--         WHEN d.docket_number = 'NCR-12-00290-21' THEN 131
--         WHEN d.docket_number = 'NCR-03-00647-22' THEN 132
--         WHEN d.docket_number = 'NCR-04-00156-22' THEN 133
--         WHEN d.docket_number = 'NCR-04-00276-22' THEN 134
--         WHEN d.docket_number = 'NCR-04-00459-22' THEN 135
--         WHEN d.docket_number = 'NCR-04-00616-22' THEN 136
--         WHEN d.docket_number = 'NCR-04-00803-22' THEN 137
--         WHEN d.docket_number = 'NCR-04-00863-22' THEN 138
--         WHEN d.docket_number = 'NCR-04-00864-22' THEN 139
--         WHEN d.docket_number = 'NCR-08-00412-21' THEN 140
--         WHEN d.docket_number = 'NCR-04-00214-22' THEN 141
--         WHEN d.docket_number = 'NCR-12-00307-21' THEN 142
--         WHEN d.docket_number = 'NCR-12-00922-21' THEN 143
--         WHEN d.docket_number = 'NCR-05-00070-22' THEN 144
--         WHEN d.docket_number = 'NCR-05-00126-22' THEN 145
--         WHEN d.docket_number = 'NCR-05-00228-22' THEN 146
--         WHEN d.docket_number = 'NCR-05-00484-22' THEN 147
--         WHEN d.docket_number = 'NCR-05-00684-22' THEN 148
--         WHEN d.docket_number = 'NCR-05-00735-22' THEN 149
--         WHEN d.docket_number = 'NCR-05-00864-22' THEN 150
--         WHEN d.docket_number = 'NCR-06-00053-22' THEN 151
--         WHEN d.docket_number = 'NCR-06-00121-22' THEN 152
--         WHEN d.docket_number = 'NCR-06-00284-22' THEN 153
--         WHEN d.docket_number = 'NCR-06-00342-22' THEN 154
--         WHEN d.docket_number = 'NCR-06-00638-22' THEN 155
--         WHEN d.docket_number = 'NCR-05-00923-22' THEN 156
--         WHEN d.docket_number = 'NCR-07-00335-22' THEN 157
--         WHEN d.docket_number = 'NCR-07-00728-22' THEN 158
--         WHEN d.docket_number = 'NCR-06-00650-22' THEN 159
--         WHEN d.docket_number = 'NCR-06-01021-22' THEN 160
--         WHEN d.docket_number = 'NCR-11-00636-21' THEN 161
--         WHEN d.docket_number = 'NCR-12-00710-21' THEN 162
--         WHEN d.docket_number = 'NCR-12-00802-21' THEN 163
--         WHEN d.docket_number = 'NCR-12-00944-21' THEN 164
--         WHEN d.docket_number = 'NCR-01-00381-22' THEN 165
--         WHEN d.docket_number = 'NCR-01-00017-22' THEN 166
--         WHEN d.docket_number = 'NCR-07-00451-22' THEN 167
--         WHEN d.docket_number = 'NCR-05-00927-22' THEN 168
--         WHEN d.docket_number = 'NCR-06-00487-22' THEN 169
--         ELSE NULL
--     END;


-- SELECT 
--     d.docket_number, 
--     d.docket_id, 
--     GROUP_CONCAT(DATE_FORMAT(sch.available_date, '%Y-%m-%d')), 
--     IF(g.total IS NULL, '0', g.total) AS male_count,
--     IF(f.total IS NULL, '0', f.total) AS female_count
-- FROM 
--     dockets d 
--     LEFT JOIN cases a ON a.docket_id = d.docket_id
--     LEFT JOIN docket_tasks dt ON dt.docket_id = d.docket_id AND dt.activity_name = 'First mandatory conference'
--     LEFT JOIN param_availability_schedule sch ON sch.availability_schedule_id = dt.availability_schedule_id
--     LEFT JOIN (
--         SELECT 
--             aaa.case_id, 
--             COUNT(*) AS Total 
--         FROM 
--             case_parties AS aaa 
--             LEFT JOIN parties AS bbb ON aaa.party_id = bbb.party_id 
--         WHERE 
--             bbb.sex_flag = 'M' 
--         GROUP BY 
--             aaa.case_id
--     ) AS g ON g.case_id = a.case_id 
--     LEFT JOIN (
--         SELECT 
--             aaa.case_id, 
--             COUNT(*) AS Total 
--         FROM 
--             case_parties AS aaa 
--             LEFT JOIN parties AS bbb ON aaa.party_id = bbb.party_id 
--         WHERE 
--             bbb.sex_flag = 'F' 
--         GROUP BY 
--             aaa.case_id
--     ) AS f ON f.case_id = a.case_id
-- WHERE 
--     d.docket_number IN (
--         'NCR-12-00710-21',
--         'NCR-12-00802-21',
--         'NCR-12-00944-21',
--         'NCR-01-00381-22',
--         'NCR-01-00017-22',
--         'NCR-01-00130-22',
--         'NCR-07-00852-21',
--         'NCR-06-00487-22'
--     )
-- GROUP BY 
--     d.docket_number
-- ORDER BY 
--     CASE
--         WHEN d.docket_number = 'NCR-12-00710-21' THEN 1
--         WHEN d.docket_number = 'NCR-12-00802-21' THEN 2
--         WHEN d.docket_number = 'NCR-12-00944-21' THEN 3
--         WHEN d.docket_number = 'NCR-01-00381-22' THEN 4
--         WHEN d.docket_number = 'NCR-01-00017-22' THEN 5
--         WHEN d.docket_number = 'NCR-01-00130-22' THEN 6
--         WHEN d.docket_number = 'NCR-07-00852-21' THEN 7
--         WHEN d.docket_number = 'NCR-06-00487-22' THEN 8
--         ELSE NULL
--     END;

-- SELECT docket_number, docket_id FROM dockets
-- WHERE docket_number in('NCR-07-00236-19', 'NCR-07-00365-19', 'NCR-07-00724-19', 'NCR-07-00696-19', 'NCR-07-00874-19', 'NCR-07-01009-19', 'NCR-08-01367-19', 'NCR-08-01240-19', 'NCR-08-01026-19', 'NCR-08-00950-19', 'NCR-08-00719-19', 'NCR-08-00555-19', 'NCR-08-00022-19', 'NCR-09-01115-19', 'NCR-09-01081-19', 'NCR-09-00848-19', 'NCR-09-00759-19', 'NCR-09-00515-19', 'NCR-09-00175-19', 'NCR-09-00046-19', 'NCR-09-00018-19', 'NCR-09-00975-19', 'NCR-10-01244-19', 'NCR-10-00933-19', 'NCR-10-00869-19', 'NCR-10-00753-19', 'NCR-10-00682-19', 'NCR-10-00629-19', 'NCR-10-00439-19', 'NCR-10-00128-19', 'NCR-11-01594-19', 'NCR-11-01532-19', 'NCR-11-01415-19', 'NCR-11-01317-19', 'NCR-11-01256-19', 'NCR-11-01137-19', 'NCR-11-00762-19', 'NCR-11-00650-19', 'NCR-11-00481-19', 'NCR-11-00455-19', 'NCR-11-00383-19', 'NCR-11-00250-19', 'NCR-11-00219-19', 'NCR-11-01350-19', 'NCR-12-01213-19', 'NCR-12-01075-19', 'NCR-12-00995-19', 'NCR-12-00851-19', 'NCR-12-00770-19', 'NCR-12-00719-19', 'NCR-12-00693-19', 'NCR-12-00378-19', 'NCR-12-00319-19', 'NCR-12-00222-19', 'NCR-12-00135-19', 'NCR-12-00025-19', 'NCR-12-00011-19', 'NCR-01-01925-20', 'NCR-01-01693-20', 'NCR-01-01249-20', 'NCR-01-00315-20', 'NCR-02-01554-20', 'NCR-03-00286-20', 'NCR-07-00286-20', 'NCR-07-00163-20', 'NCR-08-00126-20')
-- ;

-- SELECT d.docket_number, d.docket_id, group_concat(date_format(sch.available_date, '%Y-%m-%d')), if(g.total is null, '0', g.total) as male_count,
-- if(f.total is null, '0', f.total) as female_count
-- FROM dockets d 
-- LEFT JOIN cases a on a.docket_id = d.docket_id
-- LEFT JOIN docket_tasks dt on dt.docket_id = d.docket_id and dt.activity_name = 'First mandatory conference'
-- LEFT JOIN param_availability_schedule sch on sch.availability_schedule_id = dt.availability_schedule_id
-- left join (select aaa.case_id, COUNT(*) AS Total from case_parties as aaa left join parties as bbb on aaa.party_id = bbb.party_id where bbb.sex_flag = 'M' group by aaa.case_id) as g on g.case_id = a.case_id 
-- left join (select aaa.case_id, COUNT(*) AS Total from case_parties as aaa left join parties as bbb on aaa.party_id = bbb.party_id where bbb.sex_flag = 'F' group by aaa.case_id) as f on f.case_id = a.case_id
-- WHERE
--     d.docket_number IN (
--         'NCR-07-00486-19', 'NCR-09-00910-19', 'NCR-11-01579-19', 'NCR-11-00187-19', 'NCR-08-01038-19', 'NCR-09-00851-19', 'NCR-11-00255-19', 'NCR-12-00553-19', 'NCR-01-01597-20', 'NCR-01-00145-20', 'NCR-03-00727-20', 'NCR-03-00600-20', 'NCR-03-00013-20', 'NCR-02-01655-20', 'NCR-02-01304-20', 'NCR-02-00957-20', 'NCR-02-00708-20', 'NCR-02-00430-20', 'NCR-02-01830-20', 'NCR-02-01132-20', 'NCR-10-00662-20', 'NCR-03-00731-20', 'NCR-02-01954-20', 'NCR-07-00166-20', 'NCR-08-00004-20', 'NCR-09-00004-20', 'NCR-09-00090-20', 'NCR-07-00034-20', 'NCR-07-00061-20', 'NCR-10-00227-20', 'NCR-11-00072-20', 'NCR-11-00254-20', 'NCR-11-00440-20', 'NCR-11-00517-20', 'NCR-11-00589-20', 'NCR-10-00720-20', 'NCR-12-00211-20', 'NCR-12-00290-20', 'NCR-11-00821-20', 'NCR-11-00886-20', 'NCR-10-00420-20', 'NCR-12-00479-20', 'NCR-01-00336-21', 'NCR-01-00424-21', 'NCR-01-00635-21', 'NCR-01-00644-21', 'NCR-01-00718-21', 'NCR-12-00810-20', 'NCR-02-00072-21', 'NCR-02-00146-21', 'NCR-02-00276-21', 'NCR-02-00363-21', 'NCR-02-00509-21', 'NCR-02-00598-21', 'NCR-02-00783-21', 'NCR-03-00123-21', 'NCR-03-00191-21', 'NCR-03-00315-21', 'NCR-03-00380-21', 'NCR-03-00445-21', 'NCR-03-00575-21', 'NCR-03-00692-21', 'NCR-02-00879-21', 'NCR-02-00941-21', 'NCR-02-01005-21', 'NCR-03-00905-21', 'NCR-03-00966-21', 'NCR-03-01031-21', 'NCR-04-00337-21', 'NCR-05-00058-21', 'NCR-05-00201-21', 'NCR-05-00601-21', 'NCR-05-00992-21', 'NCR-03-01205-21', 'NCR-05-00322-21', 'NCR-06-01107-21', 'NCR-07-00179-21', 'NCR-07-00773-21', 'NCR-06-01204-21', 'NCR-07-00249-21', 'NCR-01-00134-21', 'NCR-01-00352-21', 'NCR-08-00318-21', 'NCR-09-00114-21', 'NCR-09-00298-21', 'NCR-10-00112-21', 'NCR-10-00347-21', 'NCR-10-00587-21', 'NCR-10-00592-21', 'NCR-11-00927-21', 'NCR-12-00148-21'
--     )
-- GROUP BY 
--     d.docket_number
-- ORDER BY 
--     CASE 
--         WHEN d.docket_number = 'NCR-09-00241-19' THEN 1
--         WHEN d.docket_number = 'NCR-07-00546-19' THEN 2
--         WHEN d.docket_number = 'NCR-09-01405-19' THEN 3
--         WHEN d.docket_number = 'NCR-09-01182-19' THEN 4
--         WHEN d.docket_number = 'NCR-07-00486-19' THEN 5
--         WHEN d.docket_number = 'NCR-09-00910-19' THEN 6
--         WHEN d.docket_number = 'NCR-11-01579-19' THEN 7
--         WHEN d.docket_number = 'NCR-11-00187-19' THEN 8
--         WHEN d.docket_number = 'NCR-08-01038-19' THEN 9
--         WHEN d.docket_number = 'NCR-09-00851-19' THEN 10
--         WHEN d.docket_number = 'NCR-11-00255-19' THEN 11
--         WHEN d.docket_number = 'NCR-12-00553-19' THEN 12
--         WHEN d.docket_number = 'NCR-01-01597-20' THEN 13
--         WHEN d.docket_number = 'NCR-01-00145-20' THEN 14
--         WHEN d.docket_number = 'NCR-03-00727-20' THEN 15
--         WHEN d.docket_number = 'NCR-03-00600-20' THEN 16
--         WHEN d.docket_number = 'NCR-03-00013-20' THEN 17
--         WHEN d.docket_number = 'NCR-02-01655-20' THEN 18
--         WHEN d.docket_number = 'NCR-02-01304-20' THEN 19
--         WHEN d.docket_number = 'NCR-02-00957-20' THEN 20
--         WHEN d.docket_number = 'NCR-02-00708-20' THEN 21
--         WHEN d.docket_number = 'NCR-02-00430-20' THEN 22
--         WHEN d.docket_number = 'NCR-02-01830-20' THEN 23
--         WHEN d.docket_number = 'NCR-02-01132-20' THEN 24
--         WHEN d.docket_number = 'NCR-10-00662-20' THEN 25
--         WHEN d.docket_number = 'NCR-03-00731-20' THEN 26
--         WHEN d.docket_number = 'NCR-02-01954-20' THEN 27
--         WHEN d.docket_number = 'NCR-07-00166-20' THEN 28
--         WHEN d.docket_number = 'NCR-08-00004-20' THEN 29
--         WHEN d.docket_number = 'NCR-09-00004-20' THEN 30
--         WHEN d.docket_number = 'NCR-09-00090-20' THEN 31
--         WHEN d.docket_number = 'NCR-07-00034-20' THEN 32
--         WHEN d.docket_number = 'NCR-07-00061-20' THEN 33
--         WHEN d.docket_number = 'NCR-10-00227-20' THEN 34
--         WHEN d.docket_number = 'NCR-11-00072-20' THEN 35
--         WHEN d.docket_number = 'NCR-11-00254-20' THEN 36
--         WHEN d.docket_number = 'NCR-11-00440-20' THEN 37
--         WHEN d.docket_number = 'NCR-11-00517-20' THEN 38
--         WHEN d.docket_number = 'NCR-11-00589-20' THEN 39
--         WHEN d.docket_number = 'NCR-10-00720-20' THEN 40
--         WHEN d.docket_number = 'NCR-12-00211-20' THEN 41
--         WHEN d.docket_number = 'NCR-12-00290-20' THEN 42
--         WHEN d.docket_number = 'NCR-11-00821-20' THEN 43
--         WHEN d.docket_number = 'NCR-11-00886-20' THEN 44
--         WHEN d.docket_number = 'NCR-10-00420-20' THEN 45
--         WHEN d.docket_number = 'NCR-12-00479-20' THEN 46
--         WHEN d.docket_number = 'NCR-01-00336-21' THEN 47
--         WHEN d.docket_number = 'NCR-01-00424-21' THEN 48
--         WHEN d.docket_number = 'NCR-01-00635-21' THEN 49
--         WHEN d.docket_number = 'NCR-01-00644-21' THEN 50
--         WHEN d.docket_number = 'NCR-01-00718-21' THEN 51
--         WHEN d.docket_number = 'NCR-12-00810-20' THEN 52
--         WHEN d.docket_number = 'NCR-02-00072-21' THEN 53
--         WHEN d.docket_number = 'NCR-02-00146-21' THEN 54
--         WHEN d.docket_number = 'NCR-02-00276-21' THEN 55
--         WHEN d.docket_number = 'NCR-02-00363-21' THEN 56
--         WHEN d.docket_number = 'NCR-02-00509-21' THEN 57
--         WHEN d.docket_number = 'NCR-02-00598-21' THEN 58
--         WHEN d.docket_number = 'NCR-02-00783-21' THEN 59
--         WHEN d.docket_number = 'NCR-03-00123-21' THEN 60
--         WHEN d.docket_number = 'NCR-03-00191-21' THEN 61
--         WHEN d.docket_number = 'NCR-03-00315-21' THEN 62
--         WHEN d.docket_number = 'NCR-03-00380-21' THEN 63
--         WHEN d.docket_number = 'NCR-03-00445-21' THEN 64
--         WHEN d.docket_number = 'NCR-03-00575-21' THEN 65
--         WHEN d.docket_number = 'NCR-03-00692-21' THEN 66
--         WHEN d.docket_number = 'NCR-02-00879-21' THEN 67
--         WHEN d.docket_number = 'NCR-02-00941-21' THEN 68
--         WHEN d.docket_number = 'NCR-02-01005-21' THEN 69
--         WHEN d.docket_number = 'NCR-03-00905-21' THEN 70
--         WHEN d.docket_number = 'NCR-03-00966-21' THEN 71
--         WHEN d.docket_number = 'NCR-03-01031-21' THEN 72
--         WHEN d.docket_number = 'NCR-04-00337-21' THEN 73
--         WHEN d.docket_number = 'NCR-05-00058-21' THEN 74
--         WHEN d.docket_number = 'NCR-05-00201-21' THEN 75
--         WHEN d.docket_number = 'NCR-05-00601-21' THEN 76
--         WHEN d.docket_number = 'NCR-05-00992-21' THEN 77
--         WHEN d.docket_number = 'NCR-03-01205-21' THEN 78
--         WHEN d.docket_number = 'NCR-05-00322-21' THEN 79
--         WHEN d.docket_number = 'NCR-06-01107-21' THEN 80
--         WHEN d.docket_number = 'NCR-07-00179-21' THEN 81
--         WHEN d.docket_number = 'NCR-07-00773-21' THEN 82
--         WHEN d.docket_number = 'NCR-06-01204-21' THEN 83
--         WHEN d.docket_number = 'NCR-07-00249-21' THEN 84
--         WHEN d.docket_number = 'NCR-01-00134-21' THEN 85
--         WHEN d.docket_number = 'NCR-01-00352-21' THEN 86
--         WHEN d.docket_number = 'NCR-08-00318-21' THEN 87
--         WHEN d.docket_number = 'NCR-09-00114-21' THEN 88
--         WHEN d.docket_number = 'NCR-09-00298-21' THEN 89
--         WHEN d.docket_number = 'NCR-10-00112-21' THEN 90
--         WHEN d.docket_number = 'NCR-10-00347-21' THEN 91
--         WHEN d.docket_number = 'NCR-10-00587-21' THEN 92
--         WHEN d.docket_number = 'NCR-10-00592-21' THEN 93
--         WHEN d.docket_number = 'NCR-11-00927-21' THEN 94
--         WHEN d.docket_number = 'NCR-12-00148-21' THEN 95
--     END;


-- COMM RAMOS
--  SELECT d.docket_number, d.docket_id, group_concat(date_format(sch.available_date, '%Y-%m-%d')), if(g.total is null, '0', g.total) as male_count,
-- if(f.total is null, '0', f.total) as female_count
-- FROM dockets d 
-- LEFT JOIN cases a on a.docket_id = d.docket_id
-- LEFT JOIN docket_tasks dt on dt.docket_id = d.docket_id and dt.activity_name = 'First mandatory conference'
-- LEFT JOIN param_availability_schedule sch on sch.availability_schedule_id = dt.availability_schedule_id
-- left join (select aaa.case_id, COUNT(*) AS Total from case_parties as aaa left join parties as bbb on aaa.party_id = bbb.party_id where bbb.sex_flag = 'M' group by aaa.case_id) as g on g.case_id = a.case_id 
-- left join (select aaa.case_id, COUNT(*) AS Total from case_parties as aaa left join parties as bbb on aaa.party_id = bbb.party_id where bbb.sex_flag = 'F' group by aaa.case_id) as f on f.case_id = a.case_id
-- WHERE d.docket_number IN ('NCR-08-01502-19')
-- GROUP BY d.docket_number

 -- SELECT d.docket_number, d.docket_id, if(date_format(sch.available_date, '%Y-%m-%d') is null, date_format(dt.actual_end_date, '%Y-%m-%d'), date_format(sch.available_date, '%Y-%m-%d')), if(g.total is null, '0', g.total) as male_count,
-- if(f.total is null, '0', f.total) as female_count
-- FROM dockets d 
-- LEFT JOIN cases a on a.docket_id = d.docket_id
-- LEFT JOIN docket_tasks dt on dt.docket_id = d.docket_id and dt.activity_name = 'First mandatory conference'
-- LEFT JOIN param_availability_schedule sch on sch.availability_schedule_id = dt.availability_schedule_id
-- left join (select aaa.case_id, COUNT(*) AS Total from case_parties as aaa left join parties as bbb on aaa.party_id = bbb.party_id where bbb.sex_flag = 'M' group by aaa.case_id) as g on g.case_id = a.case_id 
-- left join (select aaa.case_id, COUNT(*) AS Total from case_parties as aaa left join parties as bbb on aaa.party_id = bbb.party_id where bbb.sex_flag = 'F' group by aaa.case_id) as f on f.case_id = a.case_id
-- WHERE d.docket_number IN ('NCR-09-00241-19', 'NCR-07-00546-19', 'NCR-09-01405-19', 'NCR-09-01182-19', 'NCR-09-00920-19', 'NCR-09-00982-19', 'NCR-09-00213-19', 'NCR-07-00288-19', 'NCR-07-00411-19', 'NCR-07-00450-19', 'NCR-07-00969-19', 'NCR-07-01165-19', 'NCR-07-01356-19', 'NCR-08-01413-19', 'NCR-08-01380-19', 'NCR-08-01270-19', 'NCR-08-01067-19', 'NCR-08-01024-19', 'NCR-08-00969-19', 'NCR-08-00957-19', 'NCR-08-00745-19', 'NCR-08-00565-19', 'NCR-08-00529-19', 'NCR-08-00207-19', 'NCR-09-01799-19', 'NCR-09-01516-19', 'NCR-09-01397-19', 'NCR-09-01049-19', 'NCR-09-00861-19', 'NCR-09-00412-19', 'NCR-09-00143-19', 'NCR-10-01719-19', 'NCR-10-01598-19', 'NCR-10-01465-19', 'NCR-10-01298-19', 'NCR-10-01200-19', 'NCR-10-01123-19', 'NCR-10-01062-19', 'NCR-10-00948-19', 'NCR-10-00931-19', 'NCR-10-00857-19', 'NCR-10-00831-19', 'NCR-10-00688-19', 'NCR-10-00572-19', 'NCR-10-00516-19', 'NCR-10-00346-19', 'NCR-10-00239-19', 'NCR-10-00182-19', 'NCR-11-01518-19', 'NCR-11-01503-19', 'NCR-11-01247-19', 'NCR-11-01166-19', 'NCR-11-00978-19', 'NCR-11-00893-19', 'NCR-11-00637-19', 'NCR-11-00611-19', 'NCR-11-00494-19', 'NCR-11-00400-19', 'NCR-11-00393-19', 'NCR-11-00353-19', 'NCR-11-00308-19', 'NCR-11-00210-19', 'NCR-11-00105-19', 'NCR-01-00747-20', 'NCR-11-00115-20', 'NCR-09-01613-19', 'NCR-09-01283-19', 'NCR-10-01790-19', 'NCR-10-01672-19', 'NCR-10-01407-19', 'NCR-11-01089-19', 'NCR-11-00854-19', 'NCR-11-00779-19', 'NCR-01-01760-20', 'NCR-01-01669-20', 'NCR-01-01483-20', 'NCR-01-01431-20', 'NCR-01-01182-20', 'NCR-01-01084-20', 'NCR-01-00830-20', 'NCR-01-00488-20', 'NCR-01-00430-20', 'NCR-01-00357-20', 'NCR-01-00147-20', 'NCR-01-00127-20', 'NCR-01-00054-20', 'NCR-12-00964-19', 'NCR-12-00887-19', 'NCR-12-00458-19', 'NCR-12-00154-19', 'NCR-12-00131-19', 'NCR-11-01412-19', 'NCR-03-00679-20', 'NCR-03-00502-20', 'NCR-03-00372-20', 'NCR-03-00342-20', 'NCR-03-00234-20', 'NCR-03-00191-20', 'NCR-03-00172-20', 'NCR-03-00089-20', 'NCR-02-02045-20', 'NCR-02-01939-20', 'NCR-02-01850-20', 'NCR-02-01773-20', 'NCR-02-01600-20', 'NCR-02-01567-20', 'NCR-02-01558-20', 'NCR-02-01453-20', 'NCR-02-01394-20', 'NCR-02-01283-20', 'NCR-02-01152-20', 'NCR-02-01014-20', 'NCR-02-00919-20', 'NCR-02-00838-20', 'NCR-02-00752-20', 'NCR-02-00687-20', 'NCR-02-00646-20', 'NCR-02-00627-20', 'NCR-02-00548-20', 'NCR-02-00513-20', 'NCR-02-00444-20', 'NCR-02-00339-20', 'NCR-07-00224-20', 'NCR-07-00134-20', 'NCR-07-00069-20', 'NCR-08-00055-20', 'NCR-09-00055-20', 'NCR-09-00148-20', 'NCR-09-00223-20', 'NCR-12-00261-20', 'NCR-12-00337-20', 'NCR-12-00639-20', 'NCR-12-00712-20', 'NCR-12-00750-20', 'NCR-12-00786-20', 'NCR-05-01115-21')
-- GROUP BY d.docket_number
-- ORDER BY CASE
--  WHEN d.docket_number = 'NCR-09-00241-19' THEN 1
--     WHEN d.docket_number = 'NCR-07-00546-19' THEN 2
--     WHEN d.docket_number = 'NCR-09-01405-19' THEN 3
--     WHEN d.docket_number = 'NCR-09-01182-19' THEN 4
--     WHEN d.docket_number = 'NCR-09-00920-19' THEN 5
--     WHEN d.docket_number = 'NCR-09-00982-19' THEN 6
--     WHEN d.docket_number = 'NCR-09-00213-19' THEN 7
--     WHEN d.docket_number = 'NCR-07-00288-19' THEN 8
--     WHEN d.docket_number = 'NCR-07-00411-19' THEN 9
--     WHEN d.docket_number = 'NCR-07-00450-19' THEN 10
--     WHEN d.docket_number = 'NCR-07-00969-19' THEN 11
--     WHEN d.docket_number = 'NCR-07-01165-19' THEN 12
--     WHEN d.docket_number = 'NCR-07-01356-19' THEN 13
--     WHEN d.docket_number = 'NCR-08-01413-19' THEN 14
--     WHEN d.docket_number = 'NCR-08-01380-19' THEN 15
--     WHEN d.docket_number = 'NCR-08-01270-19' THEN 16
--     WHEN d.docket_number = 'NCR-08-01067-19' THEN 17
--     WHEN d.docket_number = 'NCR-08-01024-19' THEN 18
--     WHEN d.docket_number = 'NCR-08-00969-19' THEN 19
--     WHEN d.docket_number = 'NCR-08-00957-19' THEN 20
--     WHEN d.docket_number = 'NCR-08-00745-19' THEN 21
--     WHEN d.docket_number = 'NCR-08-00565-19' THEN 22
--     WHEN d.docket_number = 'NCR-08-00529-19' THEN 23
--     WHEN d.docket_number = 'NCR-08-00207-19' THEN 24
--     WHEN d.docket_number = 'NCR-09-01799-19' THEN 25
--     WHEN d.docket_number = 'NCR-09-01516-19' THEN 26
--     WHEN d.docket_number = 'NCR-09-01397-19' THEN 27
--     WHEN d.docket_number = 'NCR-09-01049-19' THEN 28
--     WHEN d.docket_number = 'NCR-09-00861-19' THEN 29
--     WHEN d.docket_number = 'NCR-09-00412-19' THEN 30
--     WHEN d.docket_number = 'NCR-09-00143-19' THEN 31
--     WHEN d.docket_number = 'NCR-10-01719-19' THEN 32
--     WHEN d.docket_number = 'NCR-10-01598-19' THEN 33
--     WHEN d.docket_number = 'NCR-10-01465-19' THEN 34
--     WHEN d.docket_number = 'NCR-10-01298-19' THEN 35
--     WHEN d.docket_number = 'NCR-10-01200-19' THEN 36
--     WHEN d.docket_number = 'NCR-10-01123-19' THEN 37
--     WHEN d.docket_number = 'NCR-10-01062-19' THEN 38
--     WHEN d.docket_number = 'NCR-10-00948-19' THEN 39
--     WHEN d.docket_number = 'NCR-10-00931-19' THEN 40
--     WHEN d.docket_number = 'NCR-10-00857-19' THEN 41
--     WHEN d.docket_number = 'NCR-10-00831-19' THEN 42
--     WHEN d.docket_number = 'NCR-10-00688-19' THEN 43
--     WHEN d.docket_number = 'NCR-10-00572-19' THEN 44
--     WHEN d.docket_number = 'NCR-10-00516-19' THEN 45
--     WHEN d.docket_number = 'NCR-10-00346-19' THEN 46
--     WHEN d.docket_number = 'NCR-10-00239-19' THEN 47
--     WHEN d.docket_number = 'NCR-10-00182-19' THEN 48
--     WHEN d.docket_number = 'NCR-11-01518-19' THEN 49
--     WHEN d.docket_number = 'NCR-11-01503-19' THEN 50
--     WHEN d.docket_number = 'NCR-11-01247-19' THEN 51
--     WHEN d.docket_number = 'NCR-11-01166-19' THEN 52
--     WHEN d.docket_number = 'NCR-11-00978-19' THEN 53
--     WHEN d.docket_number = 'NCR-11-00893-19' THEN 54
--     WHEN d.docket_number = 'NCR-11-00637-19' THEN 55
--     WHEN d.docket_number = 'NCR-11-00611-19' THEN 56
--     WHEN d.docket_number = 'NCR-11-00494-19' THEN 57
--     WHEN d.docket_number = 'NCR-11-00400-19' THEN 58
--     WHEN d.docket_number = 'NCR-11-00393-19' THEN 59
--     WHEN d.docket_number = 'NCR-11-00353-19' THEN 60
--     WHEN d.docket_number = 'NCR-11-00308-19' THEN 61
--     WHEN d.docket_number = 'NCR-11-00210-19' THEN 62
--     WHEN d.docket_number = 'NCR-11-00105-19' THEN 63
--     WHEN d.docket_number = 'NCR-01-00747-20' THEN 64
--     WHEN d.docket_number = 'NCR-11-00115-20' THEN 65
--     WHEN d.docket_number = 'NCR-09-01613-19' THEN 66
--     WHEN d.docket_number = 'NCR-09-01283-19' THEN 67
--     WHEN d.docket_number = 'NCR-10-01790-19' THEN 68
--     WHEN d.docket_number = 'NCR-10-01672-19' THEN 69
--     WHEN d.docket_number = 'NCR-10-01407-19' THEN 70
--     WHEN d.docket_number = 'NCR-11-01089-19' THEN 71
--     WHEN d.docket_number = 'NCR-11-00854-19' THEN 72
--     WHEN d.docket_number = 'NCR-11-00779-19' THEN 73
--     WHEN d.docket_number = 'NCR-01-01760-20' THEN 74
--     WHEN d.docket_number = 'NCR-01-01669-20' THEN 75
--     WHEN d.docket_number = 'NCR-01-01483-20' THEN 76
--     WHEN d.docket_number = 'NCR-01-01431-20' THEN 77
--     WHEN d.docket_number = 'NCR-01-01182-20' THEN 78
--     WHEN d.docket_number = 'NCR-01-01084-20' THEN 79
--     WHEN d.docket_number = 'NCR-01-00830-20' THEN 80
--     WHEN d.docket_number = 'NCR-01-00488-20' THEN 81
--     WHEN d.docket_number = 'NCR-01-00430-20' THEN 82
--     WHEN d.docket_number = 'NCR-01-00357-20' THEN 83
--     WHEN d.docket_number = 'NCR-01-00147-20' THEN 84
--     WHEN d.docket_number = 'NCR-01-00127-20' THEN 85
--     WHEN d.docket_number = 'NCR-01-00054-20' THEN 86
--     WHEN d.docket_number = 'NCR-12-00964-19' THEN 87
--     WHEN d.docket_number = 'NCR-12-00887-19' THEN 88
--     WHEN d.docket_number = 'NCR-12-00458-19' THEN 89
--     WHEN d.docket_number = 'NCR-12-00154-19' THEN 90
--     WHEN d.docket_number = 'NCR-12-00131-19' THEN 91
--     WHEN d.docket_number = 'NCR-11-01412-19' THEN 92
--     WHEN d.docket_number = 'NCR-03-00679-20' THEN 93
--     WHEN d.docket_number = 'NCR-03-00502-20' THEN 94
--     WHEN d.docket_number = 'NCR-03-00372-20' THEN 95
--     WHEN d.docket_number = 'NCR-03-00342-20' THEN 96
--     WHEN d.docket_number = 'NCR-03-00234-20' THEN 97
--     WHEN d.docket_number = 'NCR-03-00191-20' THEN 98
--     WHEN d.docket_number = 'NCR-03-00172-20' THEN 99
--     WHEN d.docket_number = 'NCR-03-00089-20' THEN 100
--     WHEN d.docket_number = 'NCR-02-02045-20' THEN 101
--     WHEN d.docket_number = 'NCR-02-01939-20' THEN 102
--     WHEN d.docket_number = 'NCR-02-01850-20' THEN 103
--     WHEN d.docket_number = 'NCR-02-01773-20' THEN 104
--     WHEN d.docket_number = 'NCR-02-01600-20' THEN 105
--     WHEN d.docket_number = 'NCR-02-01567-20' THEN 106
--     WHEN d.docket_number = 'NCR-02-01558-20' THEN 107
--     WHEN d.docket_number = 'NCR-02-01453-20' THEN 108
--     WHEN d.docket_number = 'NCR-02-01394-20' THEN 109
--     WHEN d.docket_number = 'NCR-02-01283-20' THEN 110
--     WHEN d.docket_number = 'NCR-02-01152-20' THEN 111
--     WHEN d.docket_number = 'NCR-02-01014-20' THEN 112
--     WHEN d.docket_number = 'NCR-02-00919-20' THEN 113
--     WHEN d.docket_number = 'NCR-02-00838-20' THEN 114
--     WHEN d.docket_number = 'NCR-02-00752-20' THEN 115
--     WHEN d.docket_number = 'NCR-02-00687-20' THEN 116
--     WHEN d.docket_number = 'NCR-02-00646-20' THEN 117
--     WHEN d.docket_number = 'NCR-02-00627-20' THEN 118
--     WHEN d.docket_number = 'NCR-02-00548-20' THEN 119
--     WHEN d.docket_number = 'NCR-02-00513-20' THEN 120
--     WHEN d.docket_number = 'NCR-02-00444-20' THEN 121
--     WHEN d.docket_number = 'NCR-02-00339-20' THEN 122
--     WHEN d.docket_number = 'NCR-07-00224-20' THEN 123
--     WHEN d.docket_number = 'NCR-07-00134-20' THEN 124
--     WHEN d.docket_number = 'NCR-07-00069-20' THEN 125
--     WHEN d.docket_number = 'NCR-08-00055-20' THEN 126
--     WHEN d.docket_number = 'NCR-09-00055-20' THEN 127
--     WHEN d.docket_number = 'NCR-09-00148-20' THEN 128
--     WHEN d.docket_number = 'NCR-09-00223-20' THEN 129
--     WHEN d.docket_number = 'NCR-12-00261-20' THEN 130
--     WHEN d.docket_number = 'NCR-12-00337-20' THEN 131
--     WHEN d.docket_number = 'NCR-12-00639-20' THEN 132
--     WHEN d.docket_number = 'NCR-12-00712-20' THEN 133
--     WHEN d.docket_number = 'NCR-12-00750-20' THEN 134
--     WHEN d.docket_number = 'NCR-12-00786-20' THEN 135
--     WHEN d.docket_number = 'NCR-05-01115-21' THEN 136
--     ELSE NULL
-- END;


-- SELECT d.docket_number, d.docket_id, group_concat(date_format(sch.available_date, '%Y-%m-%d')), if(g.total is null, '0', g.total) as male_count,
-- if(f.total is null, '0', f.total) as female_count
-- FROM dockets d 
-- LEFT JOIN cases a on a.docket_id = d.docket_id
-- LEFT JOIN docket_tasks dt on dt.docket_id = d.docket_id and dt.activity_name = 'First mandatory conference'
-- LEFT JOIN param_availability_schedule sch on sch.availability_schedule_id = dt.availability_schedule_id
-- left join (select aaa.case_id, COUNT(*) AS Total from case_parties as aaa left join parties as bbb on aaa.party_id = bbb.party_id where bbb.sex_flag = 'M' group by aaa.case_id) as g on g.case_id = a.case_id 
-- left join (select aaa.case_id, COUNT(*) AS Total from case_parties as aaa left join parties as bbb on aaa.party_id = bbb.party_id where bbb.sex_flag = 'F' group by aaa.case_id) as f on f.case_id = a.case_id
-- WHERE d.docket_number IN ('NCR-07-00236-19', 'NCR-07-00365-19', 'NCR-07-00724-19', 'NCR-07-00696-19', 'NCR-07-00874-19', 'NCR-07-01009-19', 'NCR-08-01367-19', 'NCR-08-01240-19', 'NCR-08-01026-19', 'NCR-08-00950-19', 'NCR-08-00719-19', 'NCR-08-00555-19', 'NCR-08-00022-19', 'NCR-09-01115-19', 'NCR-09-01081-19', 'NCR-09-00848-19', 'NCR-09-00759-19', 'NCR-09-00515-19', 'NCR-09-00175-19', 'NCR-09-00046-19', 'NCR-09-00018-19', 'NCR-09-00975-19', 'NCR-10-01244-19', 'NCR-10-00933-19', 'NCR-10-00869-19', 'NCR-10-00753-19', 'NCR-10-00682-19', 'NCR-10-00629-19', 'NCR-10-00439-19', 'NCR-10-00128-19', 'NCR-11-01594-19', 'NCR-11-01532-19', 'NCR-11-01415-19', 'NCR-11-01317-19', 'NCR-11-01256-19', 'NCR-11-01137-19', 'NCR-11-00762-19', 'NCR-11-00650-19', 'NCR-11-00481-19', 'NCR-11-00455-19', 'NCR-11-00383-19', 'NCR-11-00250-19', 'NCR-11-00219-19', 'NCR-11-01350-19', 'NCR-12-01213-19', 'NCR-12-01075-19', 'NCR-12-00995-19', 'NCR-12-00851-19', 'NCR-12-00770-19', 'NCR-12-00719-19', 'NCR-12-00693-19', 'NCR-12-00378-19', 'NCR-12-00319-19', 'NCR-12-00222-19', 'NCR-12-00135-19', 'NCR-12-00025-19', 'NCR-12-00011-19', 'NCR-01-01925-20', 'NCR-01-01693-20', 'NCR-01-01249-20', 'NCR-01-00315-20', 'NCR-02-01554-20', 'NCR-03-00286-20', 'NCR-07-00286-20', 'NCR-07-00163-20', 'NCR-08-00126-20')
-- GROUP BY d.docket_number
-- ORDER BY CASE
-- 	WHEN d.docket_number = 'NCR-07-00236-19' THEN 1
--     WHEN d.docket_number = 'NCR-07-00365-19' THEN 2
--     WHEN d.docket_number = 'NCR-07-00724-19' THEN 3
--     WHEN d.docket_number = 'NCR-07-00696-19' THEN 4
--     WHEN d.docket_number = 'NCR-07-00874-19' THEN 5
--     WHEN d.docket_number = 'NCR-07-01009-19' THEN 6
--     WHEN d.docket_number = 'NCR-08-01367-19' THEN 7
--     WHEN d.docket_number = 'NCR-08-01240-19' THEN 8
--     WHEN d.docket_number = 'NCR-08-01026-19' THEN 9
--     WHEN d.docket_number = 'NCR-08-00950-19' THEN 10
--     WHEN d.docket_number = 'NCR-08-00719-19' THEN 11
--     WHEN d.docket_number = 'NCR-08-00555-19' THEN 12
--     WHEN d.docket_number = 'NCR-08-00022-19' THEN 13
--     WHEN d.docket_number = 'NCR-09-01115-19' THEN 14
--     WHEN d.docket_number = 'NCR-09-01081-19' THEN 15
--     WHEN d.docket_number = 'NCR-09-00848-19' THEN 16
--     WHEN d.docket_number = 'NCR-09-00759-19' THEN 17
--     WHEN d.docket_number = 'NCR-09-00515-19' THEN 18
--     WHEN d.docket_number = 'NCR-09-00175-19' THEN 19
--     WHEN d.docket_number = 'NCR-09-00046-19' THEN 20
--     WHEN d.docket_number = 'NCR-09-00018-19' THEN 21
--     WHEN d.docket_number = 'NCR-09-00975-19' THEN 22
--     WHEN d.docket_number = 'NCR-10-01244-19' THEN 23
--     WHEN d.docket_number = 'NCR-10-00933-19' THEN 24
--     WHEN d.docket_number = 'NCR-10-00869-19' THEN 25
--     WHEN d.docket_number = 'NCR-10-00753-19' THEN 26
--     WHEN d.docket_number = 'NCR-10-00682-19' THEN 27
--     WHEN d.docket_number = 'NCR-10-00629-19' THEN 28
--     WHEN d.docket_number = 'NCR-10-00439-19' THEN 29
--     WHEN d.docket_number = 'NCR-10-00128-19' THEN 30
--     WHEN d.docket_number = 'NCR-11-01594-19' THEN 31
--     WHEN d.docket_number = 'NCR-11-01532-19' THEN 32
--     WHEN d.docket_number = 'NCR-11-01415-19' THEN 33
--     WHEN d.docket_number = 'NCR-11-01317-19' THEN 34
--     WHEN d.docket_number = 'NCR-11-01256-19' THEN 35
--     WHEN d.docket_number = 'NCR-11-01137-19' THEN 36
--     WHEN d.docket_number = 'NCR-11-00762-19' THEN 37
--     WHEN d.docket_number = 'NCR-11-00650-19' THEN 38
--     WHEN d.docket_number = 'NCR-11-00481-19' THEN 39
--     WHEN d.docket_number = 'NCR-11-00455-19' THEN 40
--     WHEN d.docket_number = 'NCR-11-00383-19' THEN 41
--     WHEN d.docket_number = 'NCR-11-00250-19' THEN 42
--     WHEN d.docket_number = 'NCR-11-00219-19' THEN 43
--     WHEN d.docket_number = 'NCR-11-01350-19' THEN 44
--     WHEN d.docket_number = 'NCR-12-01213-19' THEN 45
--     WHEN d.docket_number = 'NCR-12-01075-19' THEN 46
--     WHEN d.docket_number = 'NCR-12-00995-19' THEN 47
--     WHEN d.docket_number = 'NCR-12-00851-19' THEN 48
--     WHEN d.docket_number = 'NCR-12-00770-19' THEN 49
--     WHEN d.docket_number = 'NCR-12-00719-19' THEN 50
--     WHEN d.docket_number = 'NCR-12-00693-19' THEN 51
--     WHEN d.docket_number = 'NCR-12-00378-19' THEN 52
--     WHEN d.docket_number = 'NCR-12-00319-19' THEN 53
--     WHEN d.docket_number = 'NCR-12-00222-19' THEN 54
--     WHEN d.docket_number = 'NCR-12-00135-19' THEN 55
--     WHEN d.docket_number = 'NCR-12-00025-19' THEN 56
--     WHEN d.docket_number = 'NCR-12-00011-19' THEN 57
--     WHEN d.docket_number = 'NCR-01-01925-20' THEN 58
--     WHEN d.docket_number = 'NCR-01-01693-20' THEN 59
--     WHEN d.docket_number = 'NCR-01-01249-20' THEN 60
--     WHEN d.docket_number = 'NCR-01-00315-20' THEN 61
--     WHEN d.docket_number = 'NCR-02-01554-20' THEN 62
--     WHEN d.docket_number = 'NCR-03-00286-20' THEN 63
--     WHEN d.docket_number = 'NCR-07-00286-20' THEN 64
--     WHEN d.docket_number = 'NCR-07-00163-20' THEN 65
--     WHEN d.docket_number = 'NCR-08-00126-20' THEN 66
--     ELSE NULL
-- END;
