Use world;
# 1. List all countries in South America
SELECT name, region from country WHERE Region = 'South America';
# 2. Find the population of 'Germany'
SELECT name, population from country where name = 'Germany';
# 3. Retrieve all cities in the country 'Japan'.
SELECT name, countrycode from city where CountryCode = 'JPN';
# 4. Find the 3 most populated countries in the 'Africa' region
SELECT name, Population, continent from country where Continent = 'Africa' order by Population desc limit 3;
# 5. Retrieve the country and its life expectancy where the population is between 1 and 5 million.
SELECT name, lifeexpectancy, population from country where population > 1000000 and population < 5000000; 
# 6. List countries with an official language of 'French'
Select name, countrylanguage.Language, countrylanguage.IsOfficial from country JOIN countrylanguage ON country.code = countrylanguage.CountryCode WHERE countrylanguage.Language = 'French' AND countrylanguage.IsOfficial = 'T';

USE chinook_autoincrement;
# 8. Find the name and email of customers located in 'Brazil'.
SELECT firstname, lastname, email, country from customer where country = 'Brazil';
# 9. List all playlists in the database.
SELECT name from playlist;
# 10. Find the total number of tracks in the 'Rock' genre
select count(*) as TotalRockTracks from track join genre on track.GenreId = genre.genreid where genre.name = 'rock';
# 11. List all employees who report to 'Nancy Edwards'
select firstname, lastname, reportsto from employee where reportsto = (select employeeid from employee where firstname = 'nancy' and lastname = 'edwards');
# 12. Calculate the total sales per customer by summing the total amount in invoices
SELECT SUM(Total) / COUNT(DISTINCT customer.CustomerId) AS TotalSalesPerCustomer FROM Invoice JOIN Customer ON invoice.CustomerId = customer.CustomerId;

# Part 2: Database creation

#Ensuring the database is not already on the computer 
DROP Database `Small Business Of My Choice`;
#Creating and selecting the database for use
CREATE DATABASE `Small Business Of My Choice`;
use `Small Business Of My Choice`;

# Creating Columns
CREATE TABLE `Partners`
(
    `PartnerId` INT NOT NULL AUTO_INCREMENT,
    `Name` NVARCHAR(160),
    `Address` NVARCHAR(160),
    `ProjectID` INT,
    `POC` NVARCHAR(160),
    CONSTRAINT `PK_Partner` PRIMARY KEY  (`PartnerId`)
);

CREATE TABLE `Project`
(
    `ProjectId` INT NOT NULL AUTO_INCREMENT,
    `Name` NVARCHAR(160),
    `ProjectTypeId` INT,
    `ContractWorth` INT,
    `StartDate` NVARCHAR(10),
    `EndDate` NVARCHAR(10),
    CONSTRAINT `PK_Project` PRIMARY KEY (`ProjectId`)
);

CREATE TABLE `ProjectType`
(
    `ProjectTypeId` INT NOT NULL AUTO_INCREMENT,
    `Type` NVARCHAR(50),
    `SubType` NVARCHAR(50),
    `Priority` NVARCHAR(10),
    CONSTRAINT `PK_ProjectType` PRIMARY KEY (`ProjectTypeId`)
);

# Populating tables
INSERT INTO `Partners` (`Name`, `Address`, `ProjectId`, `POC`) VALUES
    (N'Sleepy', N'12742908 snow white road', 3, N'Thing 1'),
    (N'Grumpy', N'90538275 apple poison house', 4, N'Thing 2'),
    (N'Bashful', N'29038457 im running out of names', 1, N'Thing 3'),
    (N'Doc', N'52597 please help', 5, N'Thing 4'),
    (N'Dopey', N'42890347 yippee im done', 2, N'Thing 5');

INSERT INTO `Project` (`Name`, `ProjectTypeId`, `ContractWorth`, `StartDate`, `EndDate`) VALUES
    (N'Subway Surfers', 5, 5290589, N'1/1/01', N'2/2/02'),
    (N'Temple Run', 3, 2340897, N'3/3/03', N'4/4/04'),
    (N'Clash of Clans', 4, 2349085, N'5/5/05', N'6/6/06'),
    (N'Flappy Bird', 2, 5089273, N'7/7/07', N'8/8/08'),
    (N'Brawl Stars', 1, 6093867, N'9/9/09', N'10/10/10');

INSERT INTO `ProjectType` (`Type`, `SubType`, `Priority`) VALUES
    (N'Cool', N'Mellow', N'High'),
    (N'Annoying', N'Funky', N'Kinda High'),
    (N'Amazing', N'Audacious', N'Medium'),
    (N'Terrible', N'Pompous', N'Kinda Low'),
    (N'Ok', N'Adventurous', N'Low');

#Creating Foreign Keys
ALTER TABLE `Partners` ADD CONSTRAINT `FK_Project`
    FOREIGN KEY (`ProjectId`) REFERENCES `Project` (`ProjectId`);
    
ALTER TABLE `Project` ADD CONSTRAINT `FK_ProjectType`
    FOREIGN KEY (`ProjectTypeId`) REFERENCES `ProjectType` (`ProjectTypeId`);
    
# Give the name, type, and subtype of all the projects
SELECT  
    project.Name ,
    projecttype.Type,
    projecttype.SubType
FROM Project JOIN ProjectType ON project.ProjectTypeId = projecttype.ProjectTypeId;
#Find the names of projects with contracts that are worth over 4 million
select name from project where contractworth > 4000000;
# Find partners with projects that have low priority
SELECT Partners.Name, ProjectType.Priority AS ProjectPriority FROM Partners JOIN Project ON Partners.ProjectID = Project.ProjectId 
JOIN ProjectType ON Project.ProjectTypeId = ProjectType.ProjectTypeId WHERE ProjectType.Priority = 'Low';
