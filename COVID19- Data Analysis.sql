--All Covid Death Data
SELECT * 
FROM [Portfolio Project]..CovidDeaths$
WHERE continent is not null
ORDER BY 3, 4


--All Covid Vaccine Data
SELECT * 
FROM [Portfolio Project]..CovidVaccinations$
WHERE continent is not null
ORDER BY 3, 4


--Necessary Covid Death info
SELECT location, population, date, MAX(total_cases) AS Highest_Infection_Count,
MAX((total_cases/population))* 100 AS Percent_Population_Infected
FROM [Portfolio Project]..CovidDeaths$
GROUP BY location, population, date
ORDER BY Percent_Population_Infected DESC


--Most infected countries
SELECT TOP 30 Location, MAX(total_cases) AS Total_Cases
FROM [Portfolio Project]..CovidDeaths$
WHERE continent is not null 
GROUP BY location
ORDER BY  Total_Cases DESC

--Infection Count by Continent

SELECT Continent, SUM(new_cases) AS Total_Cases
FROM [Portfolio Project]..CovidDeaths$
WHERE continent is not null
Group By continent
ORDER BY Total_Cases DESC


--Total Cases VS Population of each country (Infection Percentage)

SELECT TOP 50 Location, MAX(total_cases) AS Total_Cases, MAX(Population) AS Population, 
(MAX(total_cases)/MAX(Population))* 100 AS InfectionPercentage
FROM [Portfolio Project]..CovidDeaths$
WHERE continent is not null 
GROUP BY location
ORDER BY InfectionPercentage DESC


--Total Cases VS Population of each continent (Infection Percentage)

SELECT Continent, MAX(total_cases) AS Total_Cases, MAX(Population) AS Population, 
(MAX(total_cases)/MAX(Population))* 100 AS InfectionPercentage
FROM [Portfolio Project]..CovidDeaths$
WHERE continent is not null 
GROUP BY continent
ORDER BY InfectionPercentage DESC


--Mortality Rate by Continent (Death Percentage)

SELECT continent, SUM(population) AS Population, SUM(new_cases) AS Total_Cases, SUM(CAST (new_deaths AS int)) AS Total_Death,
(SUM(CAST (new_deaths AS int))/SUM(new_cases))* 100 AS Death_Percentage
FROM [Portfolio Project]..CovidDeaths$
WHERE continent is not null
GROUP BY continent
ORDER BY Death_Percentage DESC
 

--Countries with Highest Infection Rate compared to Population

SELECT Location, Population, MAX(total_cases) AS Highest_Infection_Count, MAX(total_cases/ population)* 100 AS InfectionPercentage
FROM [Portfolio Project]..CovidDeaths$
GROUP BY Location, Population 
ORDER BY InfectionPercentage DESC


--Mortality Rate of each continent

SELECT continent, MAX(total_cases) AS Cases, MAX(CAST(total_deaths AS int)) AS Total_Death_Count, 
(MAX(CAST(total_deaths AS int))/MAX(total_cases)) * 100 AS Mortality_Rate
FROM [Portfolio Project]..CovidDeaths$
WHERE continent is not null
GROUP BY continent
ORDER BY Mortality_Rate DESC


--Continents with the highest death count per population

SELECT Continent, MAX(CAST(total_deaths AS int)) AS Total_Death_Count
FROM [Portfolio Project]..CovidDeaths$
WHERE continent is not null
GROUP BY continent
ORDER BY Total_Death_Count DESC

--Death Percentage by Continent

SELECT continent, SUM(new_cases) AS Total_Cases, MAX(CAST(total_deaths AS int)) AS total_deaths,  
SUM(CAST(new_deaths AS int))/SUM(New_Cases)* 100 AS Death_Percentage 
FROM [Portfolio Project]..CovidDeaths$
WHERE continent is not null
GROUP BY continent
ORDER BY Death_Percentage DESC


--Global Numbers

SELECT SUM(new_cases) AS Total_Cases, SUM(CAST(new_deaths AS int)) AS Total_Deaths, 
SUM(CAST(new_deaths AS int))/SUM(New_Cases)* 100 AS Death_Percentage 
FROM [Portfolio Project]..CovidDeaths$
WHERE continent is not null
ORDER BY 1, 2


--Population VS Vaccination

SELECT vac.location, MAX(dea.population) AS Population, vac.date, MAX(CAST(vac.people_vaccinated AS BIGINT)) AS Total_Vaccinations, 
(MAX(CAST(vac.people_vaccinated AS BIGINT))/MAX(dea.population)) * 100 AS Vaccine_Percentage
FROM [Portfolio Project]..CovidDeaths$ AS dea 
Join  [Portfolio Project]..CovidVaccinations$ AS vac
	ON vac.location = dea.location
WHERE dea.continent is not null and vac.people_vaccinated is not null 
GROUP BY vac.location, dea.population
ORDER BY Vaccine_Percentage DESC
