create database nasa;

use nasa;

select * from astro;

-- 1. the status of the astronaut
SELECT Status, COUNT(*) AS Number
FROM astro
GROUP BY Status;

-- 2. the Military Branch of the astronaut.
SELECT Military_Branch, COUNT(*) AS Number
FROM astro
GROUP BY Military_Branch;

-- 3. the top 5 military ranks among astronauts.
SELECT 
Top 5
Military_Rank, COUNT(*) AS Number
FROM astro
GROUP BY Military_Rank
ORDER BY Number DESC;

-- 4.the number of male and female astronauts
SELECT Gender, COUNT(*) AS Number
FROM astro
GROUP BY Gender;

-- 5.the average life expectancy of astronauts
SELECT ROUND(AVG(life_Expectancy), 0) AS Average_Life_Expectancy
FROM (
    SELECT
        CASE
            WHEN Status = 'Deceased' THEN YEAR(Death_Date) - YEAR(Birth_Date)
            ELSE 2023 - YEAR(Birth_Date)
        END AS life_Expectancy
    FROM astro
) subquery;

-- 6.he average life expectancy of female astronauts
SELECT ROUND(AVG(Female_life_Expectancy), 0) AS Female_Average_Life_Expectancy
FROM (
    SELECT
        CASE
            WHEN Status = 'Deceased' AND Gender = 'Female' THEN YEAR(Death_Date) - YEAR(Birth_Date)
            WHEN Status <> 'Deceased' AND Gender = 'Female' THEN 2023 - YEAR(Birth_Date)
            ELSE NULL
        END AS Female_life_Expectancy
    FROM astro
) subquery;

-- 7.the average life expectancy of male astronauts
SELECT ROUND(AVG(Male_life_Expectancy), 0) AS Male_Average_Life_Expectancy
FROM (
    SELECT
        CASE
            WHEN Status = 'Deceased' AND Gender = 'Male' THEN YEAR(Death_Date) - YEAR(Birth_Date)
            WHEN Status <> 'Deceased' AND Gender = 'Male' THEN 2023 - YEAR(Birth_Date)
            ELSE NULL
        END AS Male_life_Expectancy
    FROM astro
) subquery;

-- 8. top 10 graduate majors among astronauts
SELECT 
Top 10
Graduate_Major, COUNT(*) AS Number
FROM astro
GROUP BY Graduate_Major
ORDER BY Number DESC;

-- 9.the count of astronauts with undergraduate and graduate degrees
SELECT
    COUNT(*) AS Number_of_Astronauts,
    SUM(CASE WHEN Undergraduate_Major IS NOT NULL THEN 1 ELSE 0 END) AS Astronauts_with_Undergraduate_Degrees,
    SUM(CASE WHEN Graduate_Major IS NOT NULL THEN 1 ELSE 0 END) AS Astronauts_with_Graduate_Degrees
FROM astro;

-- 10. top 5 states of birth for astronauts
SELECT TOP 5
    STATE,
    COUNT(*) AS Astronauts_Count
FROM (
    SELECT 
        RIGHT(Birth_Place, LEN(Birth_Place) - CHARINDEX(',', Birth_Place)) AS STATE
    FROM astro
) subquery
GROUP BY STATE
ORDER BY Astronauts_Count DESC;

-- 11. the average number of space flights and spacewalks for astronauts
SELECT 
    ROUND(AVG(Space_Flights), 2) AS Average_Number_Of_Space_Flight,
    ROUND(AVG(Space_Walks), 2) AS Average_Number_Of_Space_Walks
FROM astro;

-- 12. the top 10 alma maters (universities or institutions) of astronauts
SELECT Top 10
    Alma_Mater,
    COUNT(*) AS Astronauts_Count
FROM astro
GROUP BY Alma_Mater
ORDER BY Astronauts_Count DESC;

-- 13.he top 10 undergraduate majors among astronauts
SELECT Top 10
    Undergraduate_Major,
    COUNT(*) AS Astronauts_Count
FROM astro
GROUP BY Undergraduate_Major
ORDER BY Astronauts_Count DESC;

-- 14.the count of astronauts who didn't change their major (i.e., they pursued the same major for both undergraduate and graduate studies)
SELECT COUNT(*) AS Astronauts_Count_No_Major_Change
FROM astro
WHERE Undergraduate_Major IS NOT NULL AND Graduate_Major IS NOT NULL AND Undergraduate_Major = Graduate_Major;

-- 15.the youngest astronaut until today
SELECT TOP 1 Name, Birth_Date
FROM astro
ORDER BY Birth_Date DESC;
-- 16. astronauts who passed away without being on a mission and to determine their death dates
SELECT Name, Death_Date, Death_Mission
FROM astro
WHERE Status = 'Deceased' AND Death_Mission IS NOT NULL;

-- 17.the top 5 astronauts who have taken the most space flights
SELECT 
Top 10
Name, Space_Flights
FROM astro
ORDER BY Space_Flights DESC;

-- 18.the top 3 astronauts who spent the longest time in space
SELECT TOP 10
    Name,
    "Space_Flight_(hr)"
FROM astro
ORDER BY "Space_Flight_(hr)" DESC;

-- 19.the top 10 astronauts who have conducted the most spacewalks
SELECT 
Top 10
Name, Space_Walks
FROM astro
ORDER BY Space_Walks DESC;

-- 20.the top 10 astronauts with the longest total spacewalk hours and their names
SELECT
Top 10
Name, "Space_Walks_(hr)"
FROM astro
ORDER BY "Space_Walks_(hr)" DESC;

-- 21.astronauts who have no alma mater (no information about their undergraduate institution)
SELECT *
FROM astro
WHERE Alma_Mater IS NULL and Undergraduate_Major is null;

-- 22.the astronaut who most recently joined the astronaut program
SELECT 
Top 1 *
FROM astro
ORDER BY Year DESC;

-- 23.the names of astronauts who were part of the Apollo missions
SELECT DISTINCT Name, Missions
FROM astro
WHERE Missions LIKE '%Apollo%';

-- 24.astronauts who did not take any space flights
SELECT *
FROM astro
WHERE Space_Flights = 0;

-- 25.the oldest active astronaut as of today,
SELECT 
Top 1
*
FROM astro
WHERE Status = 'Active'
ORDER BY Birth_Date ASC;