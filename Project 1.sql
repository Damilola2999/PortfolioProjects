select*
from PortfolioProject..CovidDeath
where location is not null
order by 3,4

--select*
--from PortfolioProject..Covidvaccination
--order by 3,4

select Location, Date, total_cases,new_cases, total_deaths,population
from PortfolioProject..CovidDeath
order by 1,2

select Location, date ,total_cases, population ,(total_cases/population)*100 as PercentPopulationInfected
from PortfolioProject..CovidDeath
--where location like '%Nigeria%'
order by 1,2


select Location,population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentPopulationInfected
from PortfolioProject..CovidDeath
--where location like '%Nigeria%'
group by location,population
order by PercentPopulationInfected desc


select Location,MAX(total_deaths) as TotalDeathCount
from PortfolioProject..CovidDeath
--where location like '%Nigeria%'
where continent is not null
group by location
order by TotalDeathCount desc


select continent,MAX(total_deaths) as TotalDeathCount
from PortfolioProject..CovidDeath
--where location like '%Nigeria%'
where continent is not null
group by continent
order by TotalDeathCount desc

select date, SUM(new_cases) as Total_cases,SUM(new_deaths) as Total_deaths, SUM(new_deaths)/SUM(new_cases)*100 DeathPercentage
from PortfolioProject..CovidDeath
where continent is not null
group by date
order by 1,2


select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(new_vaccinations) OVER (partition by dea.location order by dea.location,dea.date) as RollingPeopleVaccinated
from portfolioProject..coviddeath dea
join portfolioProject..covidvaccination vac
 on dea.location = vac.location
 and dea.date = vac.date
 where dea.continent is not null
 order by 1,2,3