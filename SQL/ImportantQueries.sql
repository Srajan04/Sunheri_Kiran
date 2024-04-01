SELECT 
    Branch.branch_id, SUM(Donation.amount) AS total_donations
FROM
    Branch
        LEFT JOIN
    Donation ON Branch.branch_id = Donation.branch_id
GROUP BY Branch.branch_id;
-- Justification: This query helps the organization track the total donations received by each branch. 
-- It provides insights into which branches are performing well in terms of fundraising and can help in 
-- resource allocation and decision-making.

SELECT 
    Donor.donor_id,
    Donor.name,
    SUM(Donation.amount) AS total_donations
FROM
    Donor
        JOIN
    Donation ON Donor.donor_id = Donation.donor_id
GROUP BY Donor.donor_id , Donor.name
ORDER BY total_donations DESC
LIMIT 5;
-- Justification: Identifying the top donors is crucial for the organization to maintain good relationships
-- with them and potentially seek further support. This query helps in recognizing and appreciating the most generous donors.

SELECT 
    Branch.branch_id,
    COUNT(Beneficiary.beneficiary_id) AS beneficiaries_served
FROM
    Branch
        LEFT JOIN
    Beneficiary ON Branch.branch_id = Beneficiary.branch_id
GROUP BY Branch.branch_id;
-- Justification: This query provides insights into the impact of each branch in terms of the number of beneficiaries served.
-- It helps the organization assess the reach and effectiveness of their services across different branches.

SELECT 
    Volunteer.volunteer_id,
    Volunteer.name,
    Volunteer.hours_worked
FROM
    Volunteer
ORDER BY Volunteer.hours_worked DESC
LIMIT 10;
-- Justification: Recognizing and appreciating the most dedicated volunteers is important for maintaining 
-- their motivation and engagement.
-- This query identifies the top volunteers based on the hours they have contributed.

SELECT 
    Branch.branch_id, AVG(Worker.salary) AS average_salary
FROM
    Branch
        JOIN
    Worker ON Branch.branch_id = Worker.branch_id
GROUP BY Branch.branch_id;
-- Justification: This query provides insights into the average salary of workers in each branch.
-- It can help the organization assess the fairness and competitiveness of their compensation across different branches.

SELECT 
    Branch.branch_id,
    COUNT(Projects.project_id) AS ongoing_projects
FROM
    Branch
        JOIN
    Projects ON Branch.branch_id = Projects.branch_id
WHERE
    Projects.status = 'In Progress'
GROUP BY Branch.branch_id
ORDER BY ongoing_projects DESC
LIMIT 5;
-- Justification: Identifying the branches with the most ongoing projects helps the 
-- organization understand which branches are actively engaged in various initiatives.
-- It can assist in resource allocation and project management.


SELECT 
    Events.event_type, COUNT(Events.event_id) AS event_count
FROM
    Events
GROUP BY Events.event_type
ORDER BY event_count DESC
LIMIT 5;
-- Justification: Understanding the most popular event types helps the organization plan and organize future events effectively. 
-- It provides insights into the preferences and interests of the attendees.

SELECT 
    Volunteer.volunteer_id,
    Volunteer.name,
    Volunteer_Skills.skill_name
FROM
    Volunteer
        JOIN
    Volunteer_Skill_Mapping ON Volunteer.volunteer_id = Volunteer_Skill_Mapping.volunteer_id
        JOIN
    Volunteer_Skills ON Volunteer_Skill_Mapping.skill_id = Volunteer_Skills.skill_id
WHERE
    Volunteer_Skills.skill_name IN ('Communication Skills' , 'Teamwork', 'Problem Solving');
-- Justification: This query helps in identifying volunteers with specific skills that may be required 
-- for certain projects or initiatives. 
-- It enables the organization to effectively match volunteers with appropriate tasks based on their skill set.

SELECT 
    Branch.branch_id, AVG(Donation.amount) AS average_donation
FROM
    Branch
        JOIN
    Donation ON Branch.branch_id = Donation.branch_id
GROUP BY Branch.branch_id
ORDER BY average_donation DESC
LIMIT 5;
-- Justification: This query identifies the branches that receive the highest average donation amount. 
-- It helps the organization understand which branches are more effective in attracting larger donations 
-- and can guide fundraising strategies.

SELECT 
    b.branch_type,
    COUNT(DISTINCT v.volunteer_id) AS num_volunteers,
    COUNT(DISTINCT w.worker_id) AS num_workers,
    SUM(d.amount) AS total_donations
FROM
    Branch b
        LEFT JOIN
    Volunteer v ON b.branch_id = v.branch_id
        LEFT JOIN
    Worker w ON b.branch_id = w.branch_id
        LEFT JOIN
    Donation d ON b.branch_id = d.branch_id
GROUP BY b.branch_type;

-- Justification: This query provides a summary of the number of volunteers, workers, and total donations 
-- received for each branch type. It helps the organization understand the distribution of resources 
-- and contributions across different types of branches.


SELECT 
    b.city,
    b.state,
    COUNT(DISTINCT ben.beneficiary_id) AS num_beneficiaries,
    GROUP_CONCAT(DISTINCT bt.service_type
        SEPARATOR ', ') AS services_offered
FROM
    Branch b
        JOIN
    Beneficiary ben ON b.branch_id = ben.branch_id
        JOIN
    BranchType bt ON b.branch_id = bt.branch_id
GROUP BY b.city , b.state;

-- Justification: This query gives a breakdown of the number 
-- of beneficiaries and the services offered by branches in each city and state. 
-- It helps the organization understand the reach and impact of their services across different geographical locations.


SELECT 
    v.name,
    v.email,
    v.phone_number,
    SUM(v.hours_worked) AS total_hours_worked,
    GROUP_CONCAT(DISTINCT vs.skill_name
        SEPARATOR ', ') AS skills
FROM
    Volunteer v
        LEFT JOIN
    Volunteer_Skill_Mapping vsm ON v.volunteer_id = vsm.volunteer_id
        LEFT JOIN
    Volunteer_Skills vs ON vsm.skill_id = vs.skill_id
GROUP BY v.volunteer_id
ORDER BY total_hours_worked DESC;

-- Justification: This query retrieves information about volunteers, including their contact details, 
-- total hours worked, and skills. It helps the organization recognize and appreciate the contributions
-- of dedicated volunteers and identify volunteers with specific skills for potential assignments or projects.


SELECT 
    p.project_name,
    p.project_description,
    p.start_date,
    p.end_date,
    p.budget,
    p.status,
    b.branch_type,
    b.city,
    b.state
FROM
    Projects p
        JOIN
    Branch b ON p.branch_id = b.branch_id
WHERE
    p.status = 'In Progress';

-- Justification: This query retrieves information about ongoing projects, including their names, 
-- descriptions, timelines, budgets, statuses, and the branch details where they are being carried out. 
-- It helps the organization monitor and manage active projects across different branches.

SELECT 
    e.event_name,
    e.event_description,
    e.event_date,
    e.event_location,
    e.event_type,
    e.number_of_attendees,
    b.branch_type,
    b.city,
    b.state
FROM
    Events e
        JOIN
    Branch b ON e.branch_id = b.branch_id
WHERE
    e.event_date >= CURDATE()
ORDER BY e.event_date;

-- Justification: This query retrieves information about upcoming events, including their names, descriptions, 
-- dates, locations, types, expected attendance, and the associated branch details. 
-- It helps the organization plan and manage upcoming events effectively across different branches.


SELECT 
    YEAR(don.date) AS year, SUM(don.amount) AS total_donations
FROM
    Donation don
GROUP BY YEAR(don.date)
ORDER BY year;

-- Justification: This query calculates the total donations received by the organization for each year.
-- It provides valuable insights into the organization's fundraising trends and performance over time,
-- which can inform future fundraising strategies and budgeting decisions.


SELECT 
    b.branch_type,
    AVG(DATEDIFF(CURDATE(), ben.date_of_service)) AS avg_days_since_service
FROM
    Branch b
        JOIN
    Beneficiary ben ON b.branch_id = ben.branch_id
GROUP BY b.branch_type;

-- Justification: This query calculates the average number of days since beneficiaries received services from each branch type.
-- It helps the organization monitor the frequency of service delivery and identify potential areas where more frequent
-- or follow-up services may be required for beneficiaries.


SELECT 
    sm.name AS senior_manager,
    COUNT(DISTINCT bm.branch_manager_id) AS num_branch_managers,
    SUM(don.amount) AS total_donations
FROM
    Senior_Manager sm
        LEFT JOIN
    Branch_Manager bm ON sm.senior_manager_id = bm.senior_manager_id
        LEFT JOIN
    Branch b ON bm.branch_manager_id = b.branch_manager_id
        LEFT JOIN
    Donation don ON b.branch_id = don.branch_id
GROUP BY sm.senior_manager_id;

-- Justification: This query provides a summary of the number of branch managers under each senior manager, 
-- along with the total donations received by branches managed by those branch managers. 
-- It helps the organization evaluate the performance and contributions of senior managers and their respective teams.
