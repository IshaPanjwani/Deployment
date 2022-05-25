SELECT * 
FROM [Portfolio Project]..['Table 1#0$']

--Extracting Provincial Data
SELECT * INTO Provincial_Data 
FROM [Portfolio Project]..['Table 1#0$']
WHERE [Centre] like '%[10000+]%'

DELETE FROM [Portfolio Project]..Provincial_Data
WHERE Centre = 'Canada'

UPDATE Provincial_Data SET [Centre] = LEFT([Centre], LEN([Centre])-7)

--Provincial Data
SELECT * FROM [Portfolio Project]..Provincial_Data


--Extracting City Data
SELECT * INTO City_Data 
FROM [Portfolio Project]..['Table 1#0$']
WHERE [Centre] like '%CMA%'

DELETE FROM [Portfolio Project]..City_Data
WHERE Centre = 'Canada'

--Formatting City Names
UPDATE City_Data SET Centre = LEFT(Centre, LEN(Centre)-4)

UPDATE [Portfolio Project]..City_Data SET Centre = (SUBSTRING(centre, 1, 15))
WHERE Centre = 'Ottawa-Gatineau CMA (Qué. p' or Centre = 'Ottawa-Gatineau CMA (Ont. p'

--City Data
SELECT * FROM [Portfolio Project]..City_Data


--Increment/decrement of rental properties among provinces(Mobility Change)
SELECT Centre, CONVERT(float,[Vacancy Rates (Oct-20)]) AS Vacancy_2020, CONVERT(float, [Vacancy Rates (Oct-21)]) AS Vacancy_2021,
-1 * (CONVERT(float, [Vacancy Rates (Oct-21)])-CONVERT(float,[Vacancy Rates (Oct-20)])) AS Mobility_Change
FROM [Portfolio Project]..Provincial_Data 
ORDER BY Mobility_Change DESC

--Increment/decrement of average rent (2 bedroom)
SELECT Centre, [Average Rent Two Bedroom ($) (New and Existing Structures) (01/1] AS Average_Two_Bedroom_rent2020, 
[Average Rent Two Bedroom ($) (New and Existing Structures)(01/10] AS Average_Two_Bedroom_rent2021
FROM [Portfolio Project]..Provincial_Data

ALTER TABLE [Portfolio Project]..Provincial_Data
DROP COLUMN [Turnover rates (Oct-20)], [Turnover rates (Oct-21)]

ALTER TABLE [Portfolio Project]..Provincial_Data
DROP COLUMN [Turnover rates (Oct-21)]

ALTER TABLE [Portfolio Project]..Provincial_Data
DROP COLUMN [Percentage Change of Average Rent Two Bedroom From Fixed Sample1]

SELECT * 
FROM [Portfolio Project]..Provincial_Data

SELECT Centre, [Vacancy Rates (Oct-20)], [Vacancy Rates (Oct-21)] INTO Provincial_Vacancy_Rate
FROM [Portfolio Project]..Provincial_Data

SELECT * 
FROM Provincial_Vacancy_Rate


SELECT Centre, [Average Rent Two Bedroom ($) (New and Existing Structures) (01/1] AS Average_Rent_two_bedroom_Oct2020, 
[Average Rent Two Bedroom ($) (New and Existing Structures)(01/10] AS Average_Rent_two_bedroom_Oct2021, 
[Percentage Change of Average Rent Two Bedroom From Fixed Sample ]
INTO Provincial_Average_Rent
FROM [Portfolio Project]..Provincial_Data

SELECT * 
FROM Provincial_Average_Rent

ALTER TABLE [Portfolio Project]..City_Data
DROP COLUMN [Turnover rates (Oct-20)], [Turnover rates (Oct-21)]

ALTER TABLE [Portfolio Project]..City_Data
DROP COLUMN [Percentage Change of Average Rent Two Bedroom From Fixed Sample1]

SELECT * 
FROM [Portfolio Project]..City_Data

SELECT Centre, [Vacancy Rates (Oct-20)], [Vacancy Rates (Oct-21)] INTO City_Vacancy_Data
FROM [Portfolio Project]..City_Data

SELECT * 
FROM City_Vacancy_Data


SELECT Centre, [Average Rent Two Bedroom ($) (New and Existing Structures) (01/1] AS Average_Rent_two_bedroom_Oct2020, 
[Average Rent Two Bedroom ($) (New and Existing Structures)(01/10] AS Average_Rent_two_bedroom_Oct2021, 
[Percentage Change of Average Rent Two Bedroom From Fixed Sample ]
INTO City_Average_Rent
FROM [Portfolio Project]..City_Data

SELECT * 
FROM City_Average_Rent

SELECT *
FROM [Portfolio Project]..City_Data


UPDATE [Portfolio Project]..['Table 1#0$']
SET Centre = SUBSTRING('Canada', 1, 6)
WHERE Centre = 'Canada CMAs'


SELECT Centre, [Vacancy Rates (Oct-20)], [Vacancy Rates (Oct-21)] INTO Canada_vacancy_Rate
FROM [Portfolio Project]..['Table 1#0$']
WHERE Centre = 'Canada'

SELECT * 
FROM Canada_vacancy_Rate


SELECT Centre, [Average Rent Two Bedroom ($) (New and Existing Structures) (01/1], [Average Rent Two Bedroom ($) (New and Existing Structures)(01/10], 
[Percentage Change of Average Rent Two Bedroom From Fixed Sample ] INTO Canada_Average_Rent
FROM [Portfolio Project]..['Table 1#0$']
WHERE Centre = 'Canada'


SELECT * 
FROM Canada_Average_Rent