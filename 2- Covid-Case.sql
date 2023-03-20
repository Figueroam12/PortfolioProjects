


Select * 
from portfolioproject..coviddeaths
Where continent is not null
order by 3,4

-- Looking at Total Cases vs total Deaths
Select location, date, total_cases, total_deaths , ( Total_deaths/total_cases) * 100 as DeathPercentage
from portfolioproject..coviddeaths
Where location like '%states%'
Order by 1,2 

-- Looking at Total Cases vs Population
-- Shows what % of population got covid

Select location, date, total_cases, Population , (total_cases/population) * 100 as Populationcovid
from portfolioproject..coviddeaths
Where location like '%states%'
Order by 1,2 


-- Looking at countries with highest infection 

Select location,Population, max(total_cases) as HighestInfectioncount, Max((total_cases/population)) * 100 as percentpopulationinfected
from portfolioproject..coviddeaths
-- Where location like '%states%'
Group by location, population
Order by percentpopulationinfected desc


-- LET´S BREAK THINGS DOWN BY CONTINENT
Select location, max(cast(total_deaths as int)) as Total_Death_count
from portfolioproject..coviddeaths
-- Where location like '%states%'
Where continent is NULL
Group by location
Order by Total_Death_count desc


-- Showing the countries with the highest death count per population


Select location, max(cast(total_deaths as int)) as Total_Death_count
from portfolioproject..coviddeaths
-- Where location like '%states%'
Where continent is not null
Group by location
Order by Total_Death_count desc

-- Global numbers DEATH PERCENTAGE across the world
Select sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage
from portfolioproject..coviddeaths
--Where location like '%states%'
where continent is not null
--Group by date
Order by 1,2


-- Now we have to write queries about the vaccination
-- Looking at total population vs Vaccionation

Select a.continent,a.location, a.date, a.population, b.new_vaccinations, sum(convert(int,b.new_vaccinations)) OVER (partition by a.location order by a.location, a.date) as RollingPeopleVaccinated
from PortfolioProject..CovidDeaths a 
Join PortfolioProject..CovidVaccinations b
  on a.location=b.location
  and a.date=b.date
  Where a.continent is not null
  Order by 2,3

  -- USE CTE

  With PopvsVac (Continent, location,date, population, new_vaccinations, RollingpeopleVaccinated)
  as
  (
  Select a.continent,a.location, a.date, a.population, b.new_vaccinations, sum(convert(int,b.new_vaccinations)) OVER (partition by a.location order by a.location, a.date) as RollingPeopleVaccinated
from PortfolioProject..CovidDeaths a 
Join PortfolioProject..CovidVaccinations b
  on a.location=b.location
  and a.date=b.date
  Where a.continent is not null
--   Order by 2,3
  )
  Select *, ( Rollingpeoplevaccinated/Population)*100
  From PopvsVac


  -- Temp table

  Drop table if exists #PercentPopulationVaccinated
  Create table #PercentPopulationVaccinated
  (
  Continent nvarchar(255),
  Location nvarchar(255),
  Date datetime, 
  Population numeric, 
  New_vaccinations numeric,
  Rollingpeoplevaccinated numeric
  )


  Insert Into #PercentPopulationVaccinated

  Select a.continent,a.location, a.date, a.population, b.new_vaccinations, sum(convert(int,b.new_vaccinations)) OVER (partition by a.location order by a.location, a.date) as RollingPeopleVaccinated
from PortfolioProject..CovidDeaths a 
Join PortfolioProject..CovidVaccinations b
  on a.location=b.location
  and a.date=b.date
 --  Where a.continent is not null
--   Order by 2,3


  Select *, ( Rollingpeoplevaccinated/Population)*100
  From #PercentPopulationVaccinated


  -- Creating View to store data for later visualizations

  Create View PercentPopulationVaccinated1 as
  Select a.continent,a.location, a.date, a.population, b.new_vaccinations, sum(convert(int,b.new_vaccinations)) OVER (partition by a.location order by a.location, a.date) as RollingPeopleVaccinated
from PortfolioProject..CovidDeaths a 
Join PortfolioProject..CovidVaccinations b
  on a.location=b.location
  and a.date=b.date
 Where a.continent is not null
--   Order by 2,3
