use sunheri_kiran;
CREATE TABLE Owner (
    owner_id INT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255),
    phone_number VARCHAR(20),
    street VARCHAR(255),
    city VARCHAR(255),
    state VARCHAR(255),
    zip_code VARCHAR(10),
    date_of_ownership DATE
);

CREATE TABLE Senior_Manager (
    senior_manager_id INT PRIMARY KEY,
    owner_id INT,
    name VARCHAR(255),
    email VARCHAR(255),
    phone_number VARCHAR(20),
    street VARCHAR(255),
    city VARCHAR(255),
    state VARCHAR(255),
    zip_code VARCHAR(10),
    date_of_appointment DATE,
    FOREIGN KEY (owner_id) REFERENCES Owner(owner_id)
);

CREATE TABLE Branch_Manager (
    branch_manager_id INT PRIMARY KEY,
    senior_manager_id INT,
    name VARCHAR(255),
    email VARCHAR(255),
    phone_number VARCHAR(20),
    street VARCHAR(255),
    city VARCHAR(255),
    state VARCHAR(255),
    zip_code VARCHAR(10),
    date_of_appointment DATE,
    FOREIGN KEY (senior_manager_id) REFERENCES Senior_Manager(senior_manager_id)
);

CREATE TABLE Branch (
    branch_id INT PRIMARY KEY,
    branch_manager_id INT,
    branch_type VARCHAR(255),
    street VARCHAR(255),
    city VARCHAR(255),
    state VARCHAR(255),
    zip_code VARCHAR(10),
    established_date DATE,
    FOREIGN KEY (branch_manager_id) REFERENCES Branch_Manager(branch_manager_id)
);

CREATE TABLE Volunteer (
    volunteer_id INT PRIMARY KEY,
    branch_id INT,
    name VARCHAR(255),
    email VARCHAR(255),
    phone_number VARCHAR(20),
    street VARCHAR(255),
    city VARCHAR(255),
    state VARCHAR(255),
    zip_code VARCHAR(10),
    date_of_joining DATE,
    hours_worked INT,
    FOREIGN KEY (branch_id) REFERENCES Branch(branch_id)
);

CREATE TABLE Worker (
    worker_id INT PRIMARY KEY,
    branch_id INT,
    name VARCHAR(255),
    email VARCHAR(255),
    phone_number VARCHAR(20),
    street VARCHAR(255),
    city VARCHAR(255),
    state VARCHAR(255),
    zip_code VARCHAR(10),
    date_of_employment DATE,
    salary DECIMAL(10, 2),
    FOREIGN KEY (branch_id) REFERENCES Branch(branch_id)
);

CREATE TABLE Donor (
    donor_id INT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255),
    phone_number VARCHAR(20),
    street VARCHAR(255),
    city VARCHAR(255),
    state VARCHAR(255),
    zip_code VARCHAR(10),
    total_donations DECIMAL(10, 2) DEFAULT 0
);

CREATE TABLE Donation (
    donation_id INT PRIMARY KEY,
    donor_id INT,
    branch_id INT,
    amount DECIMAL(10, 2),
    date DATE,
    donation_type VARCHAR(255),
    FOREIGN KEY (donor_id) REFERENCES Donor(donor_id),
    FOREIGN KEY (branch_id) REFERENCES Branch(branch_id)
);

CREATE VIEW Donor_Total_Donations AS
    SELECT 
        Donor.donor_id, SUM(amount) AS total_donations
    FROM
        Donor
            JOIN
        Donation ON Donor.donor_id = Donation.donor_id
    GROUP BY Donor.donor_id;

CREATE TABLE Beneficiary (
    beneficiary_id INT PRIMARY KEY,
    branch_id INT,
    name VARCHAR(255),
    email VARCHAR(255),
    phone_number VARCHAR(20),
    street VARCHAR(255),
    city VARCHAR(255),
    state VARCHAR(255),
    zip_code VARCHAR(10),
    service_received VARCHAR(255),
    date_of_service DATE,
    FOREIGN KEY (branch_id) REFERENCES Branch(branch_id)
);

CREATE TABLE BranchType (
    branch_type_id INT PRIMARY KEY,
    branch_id INT,
    service_type VARCHAR(255),
    FOREIGN KEY (branch_id) REFERENCES Branch(branch_id)
);

CREATE TABLE Projects (
    project_id INT PRIMARY KEY,
    branch_id INT,
    project_name VARCHAR(255),
    project_description TEXT,
    start_date DATE,
    end_date DATE,
    budget DECIMAL(10, 2),
    status VARCHAR(50),
    FOREIGN KEY (branch_id) REFERENCES Branch(branch_id)
);

CREATE TABLE Events (
    event_id INT PRIMARY KEY,
    branch_id INT,
    event_name VARCHAR(255),
    event_description TEXT,
    event_date DATE,
    event_location VARCHAR(255),
    event_type VARCHAR(50),
    number_of_attendees INT,
    FOREIGN KEY (branch_id) REFERENCES Branch(branch_id)
);

CREATE TABLE Volunteer_Skills (
    skill_id INT PRIMARY KEY,
    skill_name VARCHAR(255)
);

CREATE TABLE Volunteer_Skill_Mapping (
    volunteer_id INT,
    skill_id INT,
    PRIMARY KEY (volunteer_id, skill_id),
    FOREIGN KEY (volunteer_id) REFERENCES Volunteer(volunteer_id),
    FOREIGN KEY (skill_id) REFERENCES Volunteer_Skills(skill_id)
);


desc Owner;
desc Senior_Manager;
desc Branch_Manager;
desc Branch;
desc Volunteer;
desc Worker;
desc Donor;
desc Donation;
desc Beneficiary;
desc BranchType;
desc Projects;
desc Events;
desc Volunteer_Skills;
desc Volunteer_Skill_Mapping;
