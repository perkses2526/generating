USE ects; 

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

