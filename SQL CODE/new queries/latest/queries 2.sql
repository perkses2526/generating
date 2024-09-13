select  * from ects.param_party_types;

select c.docket_number, c.case_title from parties p
join case_parties cp on cp.party_id = p.party_id
join cases c on c.case_id = cp.case_id
where p.party_type_id = 3 and p.company_name is not null and c.case_type_code = 'CASE' AND c.process_by is not null
group by c.case_id
;
