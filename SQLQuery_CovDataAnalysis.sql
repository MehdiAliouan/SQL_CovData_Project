
--Covid 19 Data Exploration

Select *
From dbo.CovidDeaths$
Where continent is not Null;

--Select Data that we are going to be starting with

Select location, date,total_cases, new_cases, total_deaths, population
From dbo.CovidDeaths$
Where continent is not Null
Order BY 1,2 ;

--Total Cases vs Total Deaths
--Shows the likelihood of dying if you contract covid in your country

Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From dbo.CovidDeaths$
Where location like '%morocco%' AND continent is not null
Order BY 1,2;

--Total Cases vs Population
--Shows what percentage of population infected with Covid

Select location,date, Population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
From dbo.CovidDeaths$
Where location like '%morocco%'
Order BY 1,2;

--Countries with Highest Infection Rate Compared to Population

Select location,population, MAX(total_cases) as HighestInfectionCount,MAX(total_cases/population)*100 as PercentPopulationInfected
From dbo.CovidDeaths$
Where location is not null 
Group By location, population
Order By PercentPopulationInfected Desc;

--Countries with Highest Death Count per Population

Select location, MAX(cast(total_deaths as int)) as TotalDeathCount
From dbo.CovidDeaths$
Where continent is not null
Group By location
Order By TotalDeathCount Desc;

--Breaking thing down by continent

--Showing continents with the highest death count per population

Select continent, MAX(cast(Total_deaths as int)) as TotalDeathCount
From dbo.CovidDeaths$
Where continent is not null
Group By continent
Order By TotalDeathCount Desc;

--Global Numbers

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From dbo.CovidDeaths$
Where continent is not null
Group By date
Order By 1,2 Desc;

--Total Population vs Vaccinations
--Shows Percentage of Population that has recieved at least one Covid Vaccine

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From CovidDeaths$ dea
Join CovidVaccinations$ vac
on dea.location = vac.location
and dea.date = vac.date
Where dea.continent is not null
Order By 2,3;

--Using CTE to perform Calculation on Partition By in Previous Query

With Popsvac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
AS (
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From CovidDeaths$ dea
Join CovidVaccinations$ vac
on dea.location = vac.location
and dea.date = vac.date
Where dea.continent is not null
)
Select *, (RollingPeopleVaccinated/Population)*100 as Vaccination_Percentage
From Popsvac

--Using Temp Table to perform calculation on partition by in previous query

Create Table #Vaccination_Percentage
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_Vaccinations numeric,
RollingPeopleVaccinated numeric
)
Insert into  #Vaccination_Percentage
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From CovidDeaths$ dea
Join CovidVaccinations$ vac
on dea.location = vac.location
and dea.date = vac.date

Select *, (RollingPeopleVaccinated/Population)*100 as Vaccination_Percentage
From #Vaccination_Percentage

--Creating View to store data for later visualisations

Create View Vaccination_Percentage as 
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
From CovidDeaths$ dea
Join CovidVaccinations$ vac
on dea.location = vac.location
and dea.date = vac.date
Where dea.continent is not null;











