--TASKS(CarrerHub)

--1. Provide a SQL script that initializes the database for the Job Board scenario “CareerHub”. 
CREATE DATABASE CareerHub
USE CareerHub

--2. Create tables for Companies, Jobs, Applicants and Applications. 
--Creating Company Table
CREATE TABLE Companies(
	CompanyId INT IDENTITY(1,1)PRIMARY KEY,
	CompanyName VARCHAR(255),
	Locations VARCHAR(255)
)
--Creating Table Jobs
CREATE TABLE Jobs (
    JobID INT IDENTITY(1,1) PRIMARY KEY,
    CompanyID INT,
    JobTitle VARCHAR(255),
    JobDescription TEXT,
    JobLocation VARCHAR(255),
    Salary DECIMAL(10, 2),
    JobType VARCHAR(50),
    PostedDate DATETIME,
    FOREIGN KEY (CompanyID) REFERENCES Companies(CompanyID)
)

-- Creating Applicants table
CREATE TABLE Applicants (
    ApplicantID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(255),
    LastName VARCHAR(255),
    Email VARCHAR(255),
    Phone VARCHAR(255),
    Resumes TEXT
)

-- Creating Applications table
CREATE TABLE Applications (
    ApplicationID INT IDENTITY(1,1) PRIMARY KEY,
    JobID INT,
    ApplicantID INT,
    ApplicationDate DATETIME,
    CoverLetter TEXT,
    FOREIGN KEY (JobID) REFERENCES Jobs(JobID),
    FOREIGN KEY (ApplicantID) REFERENCES Applicants(ApplicantID)
)
--Insering values into tables
INSERT INTO Companies (CompanyName, Locations)
VALUES 
    ('Company A', 'Kanchipuram'),
    ('Company B', 'Guindy'),
    ('Company C', 'Tamabaram'),
    ('Company D', 'Siruseri'),
    ('Company E', 'Thoraipakkam'),
    ('Company F', 'Chennai')
	SELECT * FROM Companies

INSERT INTO Jobs (CompanyID, JobTitle, JobDescription, JobLocation, Salary, JobType, PostedDate)
VALUES 
    (1, 'Senior Developer', 'Description', 'Kanchipuram', 70000, 'Full-time', '2024-02-01'),
    (1, 'Junior Developer', 'Description', 'Chennai', 80000, 'Part-time', '2024-02-11'),
    (2, 'Associate Mnager', 'Description', 'Guindy', 75000, 'Contract', '2024-03-03'),
    (4, 'Jnr Software Engineer', 'Description', 'Thoraipakkam', 85000, 'Full-time', '2024-03-05'),
    (3, '.NET Developer', 'Description', 'Kanchipuram', 90000, 'Full-time', '2024-03-05'),
    (5, 'Senior Manager ', 'Description', 'Tamabaram', 95000, 'Part-time', '2024-03-08')
SELECT * FROM Jobs

INSERT INTO Applicants ( FirstName, LastName, Email, Phone, Resumes)
VALUES 
    ('Naruto', 'Uzumaki', 'Naruto@gmail.com', '9867489783', 'Resume '),
    ('Minato', 'Namikaze', 'Minato@gmail.com', '9876543210', 'Resume '),
    ('Master', 'Jiraya', 'Jiraya@gmail.com', '4567890123', 'Resume'),
    ('Nagato', 'Uzumaki', 'Nagato@gmail.com', '7890123456', 'Resume'),
    ('Itachi', 'Uchicha', 'Itachi@gmail.com', '3216549870', 'Resume'),
    ('Madara', 'Uchiha', 'Madara@gmail.com', '9123456789', 'Resume')
SELECT * FROM Applicants

INSERT INTO Applications ( JobID, ApplicantID, ApplicationDate, CoverLetter)
VALUES 
    (1, 1, '2024-03-08', 'Cover letter for Job Junior Developer '),
    (2, 2, '2024-03-08', 'Cover letter for Job Jnr Software Engineer'),
    (3, 1, '2024-03-08', 'Cover letter for Job Senior Developer '),
    (4, 3, '2024-03-08', 'Cover letter for Job .NET Developer'),
    (5, 4, '2024-03-08', 'Cover letter for Job Senior Developer '),
    (6, 5, '2024-03-08', 'Cover letter for Job .NET Developer')
SELECT * FROM Applications

--3. Define appropriate primary keys, foreign keys, and constraints.
--The constarints are added in the creations

--4. Ensure the script handles potential errors, such as if the database or tables already exist.
-- To check databse exists or not?
IF NOT EXISTS (SELECT 1 FROM sys.databases WHERE name = 'CarrerHubDB')
BEGIN
    -- Create the database if not
    CREATE DATABASE CareerHubDB
END
ELSE
    PRINT 'Database already exists.'


--5. Write an SQL query to count the number of applications received for each job listing in the
--"Jobs" table. Display the job title and the corresponding application count. Ensure that it lists all
--jobs, even if they have no applications
SELECT j.JobID, j.JobTitle, COUNT(a.ApplicationID) AS ApplicationCount
FROM Jobs j
LEFT JOIN Applications a ON j.JobID = a.JobID
GROUP BY j.JobID, j.JobTitle

--6. Develop an SQL query that retrieves job listings from the "Jobs" table within a specified salary
--range. Allow parameters for the minimum and maximum salary values. Display the job title,
--company name, location, and salary for each matching job.
DECLARE @MinSalary DECIMAL(10, 2) = 60000--To declare salary ranges
DECLARE @MaxSalary DECIMAL(10, 2) = 80000

SELECT j.JobTitle, c.CompanyName, j.JobLocation, j.Salary
FROM Jobs j
INNER JOIN Companies c ON j.CompanyID = c.CompanyID
WHERE j.Salary BETWEEN @MinSalary AND @MaxSalary

--7. Write an SQL query that retrieves the job application history for a specific applicant. Allow a
--parameter for the ApplicantID, and return a result set with the job titles, company names, and
--application dates for all the jobs the applicant has applied to.
DECLARE @ApplicantID INT = 1 --I already added to  2 entries for applicant 1

SELECT j.JobTitle, c.CompanyName, a.ApplicationDate
FROM Applications a
INNER JOIN Jobs j ON a.JobID = j.JobID
INNER JOIN Companies c ON j.CompanyID = c.CompanyID
WHERE a.ApplicantID = @ApplicantID

--8. Create an SQL query that calculates and displays the average salary offered by all companies for
--job listings in the "Jobs" table. Ensure that the query filters out jobs with a salary of zero.
SELECT c.CompanyId, AVG(Salary) as [Average Salary] 
FROM Jobs j, Companies c
WHERE Salary> 0 AND c.CompanyId =j.CompanyID
GROUP BY C.CompanyId

--9. Write an SQL query to identify the company that has posted the most job listings. Display the
--company name along with the count of job listings they have posted. Handle ties if multiple
--companies have the same maximum count.
SELECT 
    CompanyName,
    COUNT(JobID) AS JobCount
FROM Companies c
JOIN Jobs j
ON c.CompanyID = j.CompanyID
GROUP BY CompanyName

--10. Find the applicants who have applied for positions in companies located in 'CityX' and have at
--least 3 years of experience.
SELECT 
	a.ApplicantID, 
	CONCAT_WS(' ', a.FirstName, a.LastName) AS [Applicant Name],
	a.Experience
FROM Applicants a
join Applications app ON app.ApplicantID= a.ApplicantID
JOIN Jobs j on j.JobID = app.JobID
join Companies c on c.CompanyId = j.CompanyID
WHERE c.Locations = 'Guindy' AND a.Experience >= 3-- I created new column called experience for this

--11.Retrieve a list of distinct job titles with salaries between $60,000 and $80,000.
SELECT DISTINCT JobTitle
FROM Jobs
WHERE Salary BETWEEN 60000 AND 80000
SELECT * FROM Jobs

--12. Find the jobs that have not received any applications.
SELECT j.JobID, j.JobTitle
FROM Jobs j
LEFT JOIN Applications a ON j.JobID = a.JobID
WHERE a.JobID IS NULL

--13. Retrieve a list of job applicants along with the companies they have applied to and the positions
--they have applied for.
SELECT 
    CONCAT_WS(' ', A.FirstName,a.LastName) AS [Applicant Name], 
    c.CompanyName, 
    j.JobTitle
FROM Applicants a
JOIN Applications app 
ON a.ApplicantID = app.ApplicantID
JOIN Jobs j 
ON app.JobID = j.JobID
JOIN Companies c
ON j.CompanyID = c.CompanyID

--14.Retrieve a list of companies along with the count of jobs they have posted, even if they have not
--received any applications.
SELECT  c.CompanyName, COUNT(j.JobID) AS JobCount
FROM Companies c
LEFT JOIN Jobs j 
ON c.CompanyID = j.CompanyID
GROUP BY c.CompanyName

--15. List all applicants along with the companies and positions they have applied for, including those
--who have not applied.
SELECT 
    a.FirstName, 
    a.LastName, 
    Isnull(c.CompanyName, 'NO COMPANY') AS CompanyName, 
    COALESCE(j.JobTitle, 'NOT APPLIED') AS JobTitle
FROM  Applicants a
LEFT JOIN Applications app 
ON a.ApplicantID = app.ApplicantID
LEFT JOIN Jobs j 
ON app.JobID = j.JobID
LEFT JOIN Companies c 
ON j.CompanyID = c.CompanyID

--16. Find companies that have posted jobs with a salary higher than the average salary of all jobs
SELECT DISTINCT c.CompanyName, Salary
FROM Companies c
JOIN Jobs j ON c.CompanyID = j.CompanyID
WHERE j.Salary > (SELECT AVG(Salary) FROM Jobs)


--17. Display a list of applicants with their names and a concatenated string of their city and state.
SELECT 
    CONCAT(a.FirstName, ' ', a.LastName) AS FullName, -- I newly added city and state
    CONCAT(a.city, ', ', a.state) AS CityState
FROM 
    Applicants a;

--18. Retrieve a list of jobs with titles containing either 'Developer' or 'Engineer'.
SELECT *
FROM Jobs
WHERE JobTitle LIKE '%Developer%' OR JobTitle LIKE '%Engineer%'
SELECT * FROM Jobs

--19. Retrieve a list of applicants and the jobs they have applied for, including those who have not
--applied and jobs without applicants.
SELECT 
    CONCAT_WS(' ', a.FirstName,a.LastName) AS [Applicant Name], 
    j.JobTitle,
    c.CompanyName
FROM 
    Applicants a
LEFT JOIN Applications app 
ON a.ApplicantID = app.ApplicantID
LEFT JOIN Jobs j
ON app.JobID = j.JobID
LEFT JOIN Companies c 
ON j.CompanyID = c.CompanyID

--20. List all combinations of applicants and companies where the company is in a specific city and the
--applicant has more than 2 years of experience. For example: city=Chennai

SELECT 
    CONCAT_WS(' ', a.FirstName,a.LastName) AS [Applicant Name],
    c.CompanyName,
	c.Locations
FROM Applicants a
CROSS JOIN Companies c
WHERE c.Locations LIKE '%Chennai%' AND a.Experience > 2












