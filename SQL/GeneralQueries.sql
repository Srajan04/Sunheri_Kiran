use sunheri_kiran;
SELECT * FROM Owner WHERE state = 'DL';

SELECT * FROM Owner WHERE date_of_ownership BETWEEN '2019-01-01' AND '2023-12-31'; 

SELECT * FROM Senior_Manager WHERE date_of_appointment BETWEEN '2022-01-01' AND '2022-12-31';

SELECT * FROM Branch_Manager WHERE date_of_appointment BETWEEN '2023-01-01' AND '2023-12-31' ORDER BY date_of_appointment;

SELECT * FROM Branch WHERE established_date BETWEEN '2020-01-01' AND '2020-12-31' ORDER BY established_date;

SELECT * FROM Volunteer WHERE date_of_joining BETWEEN '2021-01-01' AND '2021-12-31' AND hours_worked > 20;

SELECT * FROM Worker WHERE salary > 60000 ORDER BY salary;

SELECT * FROM Donor WHERE donor_id IN (SELECT donor_id FROM Donation WHERE donation_type = 'CARD' AND date BETWEEN '2023-01-01' AND '2023-12-31');

SELECT * FROM Donor ORDER BY total_donations DESC;

SELECT * FROM BranchType WHERE branch_id = 1;
	
SELECT * FROM BranchType ORDER BY service_type;
