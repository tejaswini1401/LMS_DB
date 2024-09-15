CREATE DATABASE lms_db;
USE lms_db;
CREATE TABLE UserDetails(
	Id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    email VARCHAR(50) NOT NULL UNIQUE,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    password VARCHAR(50) NOT NULL,
    contact_number VARCHAR(10) NOT NULL,
    verified BOOLEAN DEFAULT FALSE,
    creator_stamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(Id)
);

CREATE TABLE HiredCandidate(
	Id INT UNSIGNED NOT NULL AUTO_INCREMENT,
	first_name VARCHAR(50) NOT NULL,
    middle_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    hired_city VARCHAR(50),
    degree VARCHAR(50),
    hired_date DATE,
    mobile_number VARCHAR(15),
	permanent_pincode VARCHAR(10),
    hired_lab VARCHAR(10),
    attitude_remark TEXT,
    communication_remark TEXT,
    knowledge_remark TEXT,
    aggregate_remark TEXT,
    status ENUM("Pending","Accepted","Rejected") DEFAULT "Pending",
	creator_stamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	creator_user INT UNSIGNED,
    PRIMARY KEY(Id),
    FOREIGN KEY (creator_user) REFERENCES UserDetails(Id)
);

CREATE TABLE FellowshipCandidate(
	candidate_id INT AUTO_INCREMENT PRIMARY KEY,
    cic_id VARCHAR(50) NOT NULL,
    
    first_name VARCHAR(50) NOT NULL,
    middle_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    hired_city VARCHAR(50),
	degree VARCHAR(50),
    hired_date DATE,
	mobile_number VARCHAR(15),
	permanent_pincode VARCHAR(10),
    hired_lab VARCHAR(10),
    attitude_remark TEXT,
    communication_remark TEXT,
    knowledge_remark TEXT,
    aggregate_remark TEXT,
	creator_stamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	creator_user INT UNSIGNED,
    
    birth_date DATE,
    is_birth_date_verified BOOLEAN,
    parent_name VARCHAR(50),
    parent_occupation VARCHAR(50),
    parent_mobile_number VARCHAR(15),
    parent_annual_salary DECIMAL(10,2),
    local_address VARCHAR(100),
    permanent_address VARCHAR(100),
    photo_path VARCHAR(100),
    joining_date DATE,
	candidate_status ENUM("Pending","Accepted","Rejected") DEFAULT "Pending",
	personal_information TEXT,
    bank_information TEXT,
    educational_information TEXT,
    document_status VARCHAR(50),
    remark VARCHAR(50),
    FOREIGN KEY (creator_user) REFERENCES UserDetails(id)
);

CREATE TABLE CandidateBankDetails(
	Id INT AUTO_INCREMENT PRIMARY KEY,
    candidate_id INT NOT NULL,
    bank_name VARCHAR(50),
    account_number VARCHAR(10),
    is_account_number_verified BOOLEAN,
    ifsc_code VARCHAR(10),
    is_ifsc_code_verified BOOLEAN,
    pan_number VARCHAR(10),
    is_pan_number_verified BOOLEAN,
    addhaar_number VARCHAR(12),
    is_addhaar_number_verified BOOLEAN,
    creator_stamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    creator_user INT UNSIGNED,
    FOREIGN KEY (candidate_id) REFERENCES FellowshipCandidate(candidate_id),
    FOREIGN KEY (creator_user) REFERENCES UserDetails(Id)    
);

CREATE TABLE CandidateQualification(
	Id INT AUTO_INCREMENT PRIMARY KEY,
    candidate_id INT NOT NULL,
    diploma VARCHAR(50),
    degree_name VARCHAR(50),
    is_degree_name_verified BOOLEAN,
    employee_disipline VARCHAR(50),
    is_employee_disipline_verified VARCHAR(50),
    passing_year INT,
    is_passing_year_verified BOOLEAN,
    agg_per DECIMAL(5,2),
    is_agg_per_verified BOOLEAN,
    final_year_percentage DECIMAL(5,2),
    is_final_year_per_verified BOOLEAN,
    training_institute VARCHAR(50),
    is_training_institute_verified BOOLEAN,
    training_duration_month INT,
    is_training_duration_month_verified BOOLEAN,
    other_training VARCHAR(50),
    is_other_training_verified BOOLEAN,
    creator_stamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	creator_user INT UNSIGNED,
    FOREIGN KEY (candidate_id) REFERENCES FellowshipCandidate(candidate_id),
    FOREIGN KEY (creator_user) REFERENCES UserDetails(Id)    
);

CREATE TABLE Candidate_documents(
	Id INT AUTO_INCREMENT PRIMARY KEY,
    candidate_id INT NOT NULL,
    doc_type ENUM("Pancard", "Addhaar Card", "Cerificate") NOT NULL,
    doc_path VARCHAR(50),
    status ENUM("Pending", "Recieved") DEFAULT "Pending",
    creator_stamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    creator_user INT UNSIGNED,
    FOREIGN KEY (candidate_id) REFERENCES FellowshipCandidate(candidate_id),
    FOREIGN KEY (creator_user) REFERENCES UserDetails(Id)
);

CREATE TABLE Company(
	Id INT AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(50),
    address VARCHAR(50),
    location VARCHAR(50),
    status ENUM("Active", "Inactive") DEFAULT "Active",
    creator_stamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	creator_user INT UNSIGNED,
    FOREIGN KEY (creator_user) REFERENCES UserDetails(Id)
);

CREATE TABLE MakerProgram(
	Id INT AUTO_INCREMENT PRIMARY KEY,
	program_name VARCHAR(50),
    program_type ENUM("Java_Full_Stack+SpringBoot+Angular","Full Stack", "SDET") NOT NULL,
    program_link VARCHAR(50),
    tech_stack_id INT,
    tech_type_id INT,
    is_program_approved BOOLEAN,
    description TEXT,
    status ENUM("Active", "Inactive") DEFAULT "Active",
    creator_stamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	creator_user INT UNSIGNED,
	FOREIGN KEY (creator_user) REFERENCES UserDetails(Id)
);

CREATE TABLE AppParameters(
	Id INT AUTO_INCREMENT PRIMARY KEY,
	key_type VARCHAR(50) NOT NULL,
    key_value VARCHAR(50) NOT NULL,
    key_text VARCHAR(50),
    cur_status ENUM("ACTV", "IACTV") DEFAULT "ACTV",
    lastupd_user INT UNSIGNED,
    lastupd_stamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    creator_stamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    creator_user INT UNSIGNED,
    seq_num INT NOT NULL,
    FOREIGN KEY (lastupd_user) REFERENCES UserDetails(Id),
    FOREIGN KEY (creator_user) REFERENCES UserDetails(Id)
);
SELECT * FROM AppParameters WHERE key_type = "CUR_STATUS" ORDER BY seq_num;

CREATE TABLE Mentor(
	Id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    mentor_type ENUM("Main/Lead Mentor", "Practice_head", "Support_mentor", "Buddy Mentor") NOT NULL,
    lab_id INT NOT NULL, 
	status ENUM("ACTV", "IACTV") DEFAULT "ACTV",
    creator_stamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	creator_user INT UNSIGNED,
	FOREIGN KEY (creator_user) REFERENCES UserDetails(Id)
);

CREATE TABLE MentorIdeationMap(
	Id INT AUTO_INCREMENT PRIMARY KEY,
    parent_mentor_id INT NOT NULL,
    mentor_id INT NOT NULL,
	status ENUM("ACTV", "IACTV") DEFAULT "ACTV",
	creator_stamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	creator_user INT UNSIGNED,
    FOREIGN KEY (parent_mentor_id) REFERENCES Mentor(Id),
    FOREIGN KEY (mentor_id) REFERENCES Mentor(Id),
    FOREIGN KEY (creator_user) REFERENCES UserDetails(Id)
);

CREATE TABLE TechStack(
	Id INT AUTO_INCREMENT PRIMARY KEY,
    tech_name VARCHAR(50),	-- Java, Mobile, PHP, Phython  etc..
    image_path VARCHAR(50),
    framework VARCHAR(50),
    cur_status TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	creator_stamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    creator_user INT UNSIGNED,
	FOREIGN KEY (creator_user) REFERENCES UserDetails(Id)
);

CREATE TABLE MentorTechStack(
	Id INT AUTO_INCREMENT PRIMARY KEY,
    mentor_id INT NOT NULL,
    tech_stack_id INT NOT NULL,
    status ENUM("ACTV", "IACTV") DEFAULT "ACTV",
    creator_stamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	creator_user INT UNSIGNED,
    FOREIGN KEY (mentor_id) REFERENCES Mentor(Id),
    FOREIGN KEY (tech_stack_id) REFERENCES TechStack(Id),
	FOREIGN KEY (creator_user) REFERENCES UserDetails(Id)
);

CREATE TABLE TechType(
	Id INT AUTO_INCREMENT PRIMARY KEY,
    type_name VARCHAR(50), -- Full Stack, Backend, Frontend
    cur_status TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	creator_stamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    creator_user INT UNSIGNED,
	FOREIGN KEY (creator_user) REFERENCES UserDetails(Id)
);

CREATE TABLE Lab(
	Id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50), -- Mumbai, Pune, Bengalore
    location VARCHAR(50),
    address VARCHAR(50),
	status ENUM("ACTV", "IACTV") DEFAULT "ACTV",
	creator_stamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    creator_user INT UNSIGNED,
    FOREIGN KEY (creator_user) REFERENCES UserDetails(Id)
);

CREATE TABLE LabThreshold(
	Id INT AUTO_INCREMENT PRIMARY KEY,
    lab_id INT NOT NULL,
    lab_capacity INT NOT NULL,
    lead_threshold INT NOT NULL,
    ideation_engg_threshold INT NOT NULL,
    buddy_engg_threshold INT NOT NULL,
    status ENUM("ACTV", "IACTV") DEFAULT "ACTV",
	creator_stamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    creator_user INT UNSIGNED,
    FOREIGN KEY (lab_id) REFERENCES Lab(id),
    FOREIGN KEY (creator_user) REFERENCES UserDetails(Id)
);

CREATE TABLE CompanyRequirement(
	Id INT AUTO_INCREMENT PRIMARY KEY,
    company_id INT NOT NULL,
    requested_month VARCHAR(7) NOT NULL, -- e.g 11-2024
    city VARCHAR(50) NOT NULL,
    is_doc_verification BOOLEAN DEFAULT FALSE,
    requirement_doc_path VARCHAR(50),
	no_of_engg INT NOT NULL,
    tech_stack_id INT NOT NULL,
    tech_type_id INT NOT NULL,
    maker_program_id INT NOT NULL,
    lead_id INT NOT NULL,
    ideation_engg_id INT NOT NULL,
    buddy_engg_id INT NOT NULL,
    speacial_remark TEXT,
    status ENUM("ACTV", "IACTV") DEFAULT "ACTV",
	creator_stamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    creator_user INT UNSIGNED,
    FOREIGN KEY (company_id) REFERENCES Company(Id),
    FOREIGN KEY (tech_stack_id) REFERENCES TechStack(Id),
    FOREIGN KEY (tech_type_id) REFERENCES TechType(Id),
    FOREIGN KEY (maker_program_id) REFERENCES MakerProgram(Id),
    FOREIGN KEY (lead_id) REFERENCES Mentor(Id),
    FOREIGN KEY (ideation_engg_id) REFERENCES Mentor(Id),
	FOREIGN KEY (buddy_engg_id) REFERENCES Mentor(Id),
	FOREIGN KEY (creator_user) REFERENCES UserDetails(Id)
);

CREATE TABLE CandidateStackAssignment(
	Id INT AUTO_INCREMENT PRIMARY KEY,
    requirement_id INT NOT NULL,
    candidate_id INT NOT NULL,
    assign_date DATE NOT NULL,
    complete_date DATE NOT NULL,
    status ENUM("ACTV", "IACTV") DEFAULT "ACTV",
	creator_stamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    creator_user INT UNSIGNED,
    FOREIGN KEY (requirement_id) REFERENCES CompanyRequirement(Id),
    FOREIGN KEY (candidate_id) REFERENCES FellowshipCandidate(candidate_id),
    FOREIGN KEY (creator_user) REFERENCES UserDetails(Id)
);
DROP TABLE Lab;
