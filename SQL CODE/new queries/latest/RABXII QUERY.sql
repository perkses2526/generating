USE ects; 

SELECT DISTINCT
	c.case_type_code as `Case type`,
    c.docket_number AS `Case number`, 
    c.case_title AS `Case title`, 
    p.last_name AS `Last name`, 
    p.first_name AS `First name`, 
    p.middle_name AS `Middle name`, 
    GROUP_CONCAT(DISTINCT pc.contact_info SEPARATOR ', ') AS `Contact info`
FROM 
    cases c
JOIN 
    dockets d ON d.docket_id = c.docket_id
JOIN 
    case_parties cp ON cp.case_id = c.case_id AND cp.case_party_type LIKE 'P%'
JOIN 
    parties p ON p.party_id = cp.party_id
JOIN 
    party_contacts pc ON pc.party_id = p.party_id
WHERE 
    c.process_by IS NOT NULL and c.case_type_code = 'CASE'    
    -- AND c.filed_date BETWEEN '2024-01-01' AND '2024-09-30'
    AND d.org_code = 'RABXII' AND
    c.docket_number in (
'RABXII-01-00001-24',
'NLRC-RABXII-01-00001-24',
'NLRC-RABXII-01-00002-24',
'NLRC-RABXII-01-00003-24',
'NLRC-RABXII-01-00004-24',
'RABXII-01-00002-24',
'NLRC-RABXII-01-00005-24',
'RABXII-01-00003-24',
'RABXII-01-00004-24',
'NLRC-RABXII-01-00006-24',
'NLRC-RABXII-01-00007-24',
'NLRC-RABXII-01-00008-24',
'NLRC-RABXII-01-00009-24',
'NLRC-RABXII-01-00010-24',
'NLRC-RABXII-01-00011-24',
'NLRC-RABXII-01-00012-24',
'NLRC-RABXII-01-00013-24',
'RABXII-01-00005-24',
'RABXII-01-00006-24',
'RABXII-01-00007-24',
'NLRC-RABXII-01-00014-24',
'NLRC-RABXII-01-00015-24',
'RABXII-01-00008-24',
'NLRC-RABXII-01-00016-24',
'NLRC-RABXII-01-00017-24',
'RABXII-01-00009-24',
'NLRC-RABXII-01-00018-24',
'RABXII-01-00010-24',
'RABXII-01-00011-24',
'NLRC-RABXII-01-00019-24',
'RABXII-01-00012-24',
'RABXII-01-00013-24',
'RABXII-01-00014-24',
'RABXII-01-00015-24',
'RABXII-01-00016-24',
'RABXII-01-00017-24',
'NLRC-RABXII-01-00020-24',
'NLRC-RABXII-01-00021-24',
'RABXII-01-00018-24',
'NLRC-RABXII-01-00022-24',
'RABXII-01-00019-24',
'RABXII-01-00020-24',
'RABXII-01-00021-24',
'RABXII-01-00022-24',
'NLRC-RABXII-01-00023-24',
'RABXII-01-00023-24',
'RABXII-02-00001-24',
'NLRC-RABXII-02-00001-24',
'NLRC-RABXII-02-00002-24',
'NLRC-RABXII-02-00003-24',
'NLRC-RABXII-02-00004-24',
'NLRC-RABXII-02-00005-24',
'NLRC-RABXII-02-00006-24',
'NLRC-RABXII-02-00007-24',
'NLRC-RABXII-02-00008-24',
'NLRC-RABXII-02-00009-24',
'NLRC-RABXII-02-00010-24',
'RABXII-02-00002-24',
'NLRC-RABXII-02-00011-24',
'RABXII-02-00003-24',
'NLRC-RABXII-02-00012-24',
'NLRC-RABXII-02-00013-24',
'NLRC-RABXII-02-00014-24',
'RABXII-02-00004-24',
'RABXII-02-00005-24',
'NLRC-RABXII-02-00015-24',
'NLRC-RABXII-02-00016-24',
'NLRC-RABXII-02-00017-24',
'RABXII-02-00006-24',
'NLRC-RABXII-02-00018-24',
'RABXII-02-00007-24',
'NLRC-RABXII-02-00019-24',
'NLRC-RABXII-02-00020-24',
'RABXII-02-00008-24',
'RABXII-02-00009-24',
'RABXII-02-00010-24',
'RABXII-02-00011-24',
'RABXII-02-00012-24',
'NLRC-RABXII-02-00021-24',
'RABXII-02-00013-24',
'RABXII-02-00014-24',
'RABXII-02-00015-24',
'RABXII-02-00016-24',
'NLRC-RABXII-02-00022-24',
'NLRC-RABXII-03-00001-24',
'NLRC-RABXII-03-00002-24',
'NLRC-RABXII-03-00006-24',
'NLRC-RABXII-03-00003-24',
'NLRC-RABXII-03-00004-24',
'NLRC-RABXII-03-00005-24',
'NLRC-RABXII-03-00007-24',
'RABXII-03-00001-24',
'NLRC-RABXII-03-00008-24',
'NLRC-RABXII-03-00009-24',
'NLRC-RABXII-03-00010-24',
'RABXII-03-00002-24',
'RABXII-03-00003-24',
'NLRC-RABXII-03-00011-24',
'RABXII-03-00004-24',
'NLRC-RABXII-03-00012-24',
'NLRC-RABXII-03-00013-24',
'NLRC-RABXII-03-00014-24',
'NLRC-RABXII-03-00015-24',
'NLRC-RABXII-03-00016-24',
'NLRC-RABXII-03-00017-24',
'NLRC-RABXII-03-00018-24',
'NLRC-RABXII-03-00019-24',
'NLRC-RABXII-03-00020-24',
'NLRC-RABXII-03-00021-24',
'NLRC-RABXII-03-00022-24',
'NLRC-RABXII-03-00023-24',
'NLRC-RABXII-03-00024-24',
'NLRC-RABXII-03-00025-24',
'NLRC-RABXII-03-00026-24',
'RABXII-03-00005-24',
'RABXII-03-00006-24',
'RABXII-03-00007-24',
'RABXII-03-00008-24',
'RABXII-03-00009-24',
'RABXII-03-00010-24',
'NLRC-RABXII-04-00001-24',
'RABXII-04-00001-24',
'NLRC-RABXII-04-00002-24',
'NLRC-RABXII-04-00003-24',
'RABXII-04-00002-24',
'NLRC-RABXII-04-00004-24',
'NLRC-RABXII-04-00005-24',
'NLRC-RABXII-04-00006-24',
'RABXII-04-00003-24',
'NLRC-RABXII-04-00007-24',
'NLRC-RABXII-04-00008-24',
'NLRC-RABXII-04-00009-24',
'NLRC-RABXII-04-00010-24',
'NLRC-RABXII-04-00011-24',
'RABXII-04-00004-24',
'RABXII-04-00005-24',
'NLRC-RABXII-04-00012-24',
'RABXII-04-00006-24',
'NLRC-RABXII-04-00013-24',
'RABXII-04-00007-24',
'NLRC-RABXII-04-00014-24',
'RABXII-04-00008-24',
'NLRC-RABXII-04-00015-24',
'RABXII-04-00009-24',
'RABXII-04-00010-24',
'NLRC-RABXII-04-00016-24',
'NLRC-RABXII-04-00017-24',
'RABXII-04-00011-24',
'NLRC-RABXII-04-00018-24',
'NLRC-RABXII-04-00019-24',
'NLRC-RABXII-04-00020-24',
'RABXII-04-00012-24',
'RABXII-04-00013-24',
'NLRC-RABXII-04-00021-24',
'NLRC-RABXII-04-00022-24',
'NLRC-RABXII-04-00023-24',
'RABXII-04-00014-24',
'NLRC-RABXII-05-00001-24',
'NLRC-RABXII-05-00002-24',
'NLRC-RABXII-05-00003-24',
'NLRC-RABXII-05-00004-24',
'RABXII-05-00001-24',
'RABXII-05-00002-24',
'RABXII-05-00003-24',
'RABXII-05-00004-24',
'RABXII-05-00005-24',
'RABXII-05-00006-24',
'RABXII-05-00007-24',
'NLRC-RABXII-05-00005-24',
'RABXII-05-00008-24',
'RABXII-05-00009-24',
'NLRC-RABXII-05-00006-24',
'NLRC-RABXII-05-00007-24',
'RABXII-05-00010-24',
'NLRC-RABXII-05-00008-24',
'RABXII-05-00011-24',
'NLRC-RABXII-05-00009-24',
'NLRC-RABXII-05-00010-24',
'RABXII-05-00012-24',
'NLRC-RABXII-06-00001-24',
'RABXII-06-00001-24',
'RABXII-06-00002-24',
'RABXII-06-00003-24',
'NLRC-RABXII-06-00002-24',
'NLRC-RABXII-06-00003-24',
'RABXII-06-00004-24',
'RABXII-06-00005-24',
'RABXII-06-00006-24',
'NLRC-RABXII-06-00004-24',
'RABXII-06-00007-24',
'NLRC-RABXII-06-00005-24',
'NLRC-RABXII-06-00006-24',
'RABXII-06-00008-24',
'NLRC-RABXII-06-00007-24',
'NLRC-RABXII-06-00008-24',
'RABXII-06-00009-24',
'RABXII-06-00010-24',
'NLRC-RABXII-06-00011-24',
'NLRC-RABXII-06-00012-24',
'NLRCRABXII-06-00001-24(M)',
'NLRCRABXII-06-00002-24(M)',
'XII-06-00009-24',
'XII-06-00010-24',
'RABXII-06-00011-24',
'NLRCRABXII-06-00003-24(M)',
'NLRCRABXII-06-00004-24(M)',
'NLRCRABXII-06-00005-24(M)',
'NLRCRABXII-07-00001-24(M)',
'RABXII-07-00001-24-OFF',
'NLRC-RABXII-07-00001-24',
'NLRC-RABXII-07-00002-24',
'NLRC-RABXII-07-00003-24',
'NLRC-RABXII-07-00004-24',
'RABXII-07-00001-24',
'NLRC-RABXII-07-00005-24',
'RABXII-07-00002-24',
'RABXII-07-00003-24',
'RABXII-07-00004-24',
'NLRC-RABXII-07-00006-24',
'NLRC-RABXII-07-00007-24',
'NLRC-RABXII-07-00008-24',
'NLRC-RABXII-07-00009-24',
'NLRC-RABXII-07-00010-24',
'RABXII-07-00005-24',
'RABXII-07-00006-24',
'RABXII-07-00007-24',
'RABXII-07-00008-24',
'NLRC-RABXII-07-00011-24',
'NLRC-RABXII-07-00012-24',
'RABXII-07-00009-24',
'NLRC-RABXII-07-00013-24',
'NLRC-RABXII-07-00014-24',
'NLRC-RABXII-07-00015-24',
'NLRC-RABXII-07-00016-24',
'NLRC-RABXII-07-00017-24',
'NLRC-RABXII-07-00018-24',
'RABXII-07-00010-24',
'RABXII-07-00011-24',
'RABXII-07-00012-24',
'NLRC-RABXII-07-00019-24',
'NLRC-RABXII-07-00020-24',
'NLRC-RABXII-08-00001-24',
'NLRC-RABXII-08-00002-24',
'NLRC-RABXII-08-00003-24',
'RABXII-08-00001-24',
'NLRC-RABXII-08-00004-24',
'NLRC-RABXII-08-00005-24',
'RABXII-08-00002-24',
'NLRC-RABXII-08-00006-24',
'NLRC-RABXII-08-00007-24',
'RABXII-08-00003-24',
'NLRC-RABXII-08-00008-24',
'RABXII-08-00004-24',
'NLRC-RABXII-08-00009-24',
'RABXII-08-00005-24',
'RABXII-08-00006-24',
'NLRC-RABXII-08-00010-24',
'NLRC-RABXII-08-00011-24',
'NLRC-RABXII-08-00012-24',
'NLRC-RABXII-08-00013-24',
'NLRC-RABXII-08-00014-24',
'RABXII-08-00007-24',
'RABXII-08-00008-24',
'NLRC-RABXII-08-00015-24',
'NLRC-RABXII-08-00016-24',
'RABXII-08-00009-24',
'NLRC-RABXII-08-00017-24',
'NLRC-RABXII-09-00001-24',
'NLRC-RABXII-09-00002-24',
'RABXII-09-00001-24',
'RABXII-09-00002-24',
'NLRC-RABXII-09-00003-24',
'NLRC-RABXII-09-00004-24',
'NLRC-RABXII-09-00005-24',
'NLRC-RABXII-09-00006-24',
'NLRC-RABXII-09-00007-24',
'NLRC-RABXII-09-00008-24',
'RABXII-09-00003-24',
'RABXII-09-00004-24',
'RABXII-09-00005-24',
'NLRC-RABXII-09-00009-24',
'NLRC-RABXII-09-00010-24',
'NLRC-RABXII-09-00011-24',
'RABXII-09-00006-24',
'RABXII-09-00007-24'
) 
GROUP BY p.party_id
;