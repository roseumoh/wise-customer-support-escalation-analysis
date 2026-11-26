DESCRIBE case_table;
USE cs_assignment;

SELECT 
    CASE__CS_FIRST_OFFICE_LOCATION,
    COUNT(*) AS total_cases,
    SUM(CASE__HAS_ESCALATION = 'TRUE') AS escalated_cases,
    ROUND(AVG(CASE__HAS_ESCALATION = 'TRUE') * 100, 2) AS esc_rate
FROM case_table
GROUP BY CASE__CS_FIRST_OFFICE_LOCATION;

USE cs_assignment;
DESCRIBE case_table;
DESCRIBE survey_table;

SELECT TABLE_NAME, COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'cs_assignment'
  AND TABLE_NAME IN ('case_table', 'survey_table');
  
  SELECT
    COUNT(*) AS total_cases,
    COUNT(s.SURVEY__SOLVED_ISSUE) AS surveys_returned,
    ROUND(100.0 * AVG(s.SURVEY__SOLVED_ISSUE = 'TRUE'), 2) AS resolution_rate_pct,
    ROUND(100.0 * AVG(c.CASE__HAS_ESCALATION = 'TRUE'), 2) AS total_esc_pct,
    ROUND(100.0 * AVG(c.CASE__HAS_L2_OR_NATIVE_ESCALATION = 'TRUE'), 2) AS l2_native_esc_pct
FROM case_table c
LEFT JOIN survey_table s
    ON c.CASE__ID = s.CASE__ID
    
    
SELECT
    CASE
        WHEN c.CASE_CONTACT_COUNT = 1 THEN '1 Contact'
        WHEN c.CASE_CONTACT_COUNT = 2 THEN '2 Contacts'
        WHEN c.CASE_CONTACT_COUNT = 3 THEN '3 Contacts'
        ELSE '4+ Contacts'
    END AS contact_bucket,
    COUNT(*) AS total_cases,
    ROUND(100.0 * AVG(s.SURVEY__SOLVED_ISSUE = 'TRUE'), 2) AS resolution_rate_pct
FROM case_table c
LEFT JOIN survey_table s
    ON c.CASE__ID = s.CASE__ID
GROUP BY contact_bucket;

SELECT
    c.CASE__CS_FIRST_EMPLOYEE_SUPPORT_TYPE AS support_type,
    COUNT(*) AS total_cases,
    ROUND(100.0 * AVG(s.SURVEY__SOLVED_ISSUE = 'TRUE'), 2) AS resolution_rate_pct,
    ROUND(100.0 * AVG(c.CASE__HAS_ESCALATION = 'TRUE'), 2) AS total_esc_pct
FROM case_table c
LEFT JOIN survey_table s
    ON c.CASE__ID = s.CASE__ID
GROUP BY c.CASE__CS_FIRST_EMPLOYEE_SUPPORT_TYPE
ORDER BY total_cases DESC;

SELECT
    c.CASE__CS_FIRST_EMPLOYEE_IS_NEWBIE AS is_newbie,
    COUNT(*) AS total_cases,
    ROUND(100.0 * AVG(s.SURVEY__SOLVED_ISSUE = 'TRUE'), 2) AS resolution_rate_pct,
    ROUND(100.0 * AVG(c.CASE__HAS_ESCALATION = 'TRUE'), 2) AS total_esc_pct
FROM case_table c
LEFT JOIN survey_table s
    ON c.CASE__ID = s.CASE__ID
GROUP BY c.CASE__CS_FIRST_EMPLOYEE_IS_NEWBIE;

SELECT
    c.CASE__CS_FIRST_OFFICE_LOCATION AS office_location,
    COUNT(*) AS total_cases,
    ROUND(100.0 * AVG(s.SURVEY__SOLVED_ISSUE = 'TRUE'), 2) AS resolution_rate_pct,
    ROUND(100.0 * AVG(c.CASE__HAS_ESCALATION = 'TRUE'), 2) AS total_esc_pct
FROM case_table c
LEFT JOIN survey_table s
    ON c.CASE__ID = s.CASE__ID
GROUP BY c.CASE__CS_FIRST_OFFICE_LOCATION
ORDER BY total_cases DESC;

SELECT
    COALESCE(c.CASE__FIRST_OUTSOURCE_VENDOR_NAME, 'In-House / None') AS outsource_vendor,
    COUNT(*) AS total_cases,
    ROUND(100.0 * AVG(s.SURVEY__SOLVED_ISSUE = 'TRUE'), 2) AS resolution_rate_pct,
    ROUND(100.0 * AVG(c.CASE__HAS_ESCALATION = 'TRUE'), 2) AS total_esc_pct
FROM case_table c
LEFT JOIN survey_table s
    ON c.CASE__ID = s.CASE__ID
GROUP BY COALESCE(c.CASE__FIRST_OUTSOURCE_VENDOR_NAME, 'In-House / None')
ORDER BY total_cases DESC;