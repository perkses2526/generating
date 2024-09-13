USE ects;

SET SQL_SAFE_UPDATES = 0;

UPDATE docket_tasks dt
SET dt.task_status_id = 4
WHERE dt.docket_task_id IN (
1140440,
1166839,
1175854);

SET SQL_SAFE_UPDATES = 1;


SELECT 
	d.docket_number, 
	d.docket_id, 
	DATE_FORMAT(sch.available_date, '%Y-%m-%d'),
    dt.task_status_id
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
    a.process_by = 940
GROUP BY 
    d.docket_number;

SELECT 
	c.case_title,
   dt.*
FROM 
    cases c
JOIN 
    dockets d ON d.docket_id = c.docket_id
JOIN 
    docket_tasks dt ON dt.docket_id = d.docket_id
LEFT JOIN 
    param_availability_schedule pas ON pas.availability_schedule_id = dt.availability_schedule_id
WHERE 
    c.process_by = 940 
    AND c.filed_date < '2024-01-01' 
	and dt.availability_schedule_id is not null
  --   d.docket_id in (204075
-- ,210925
-- ,213129)
    
    
-- and dt.actual_end_date is null and dt.task_name = 'First mandatory conference'
order by c.filed_date asc

;

SELECT distinct task_status_id FROM docket_tasks;
