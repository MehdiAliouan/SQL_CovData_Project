## SQL_CovData_Project

### Situation:

The project involves exploring and analyzing Covid-19 data from 2020 to 2021 using SQL Server. The data is sourced from [Our_World_in_Data](https://ourworldindata.org/covid-deaths)

### Task:

The objective is to analyze the Covid-19 dataset to extract meaningful insights such as infection rates, death rates, and vaccination percentages. The analysis aims to present the findings visually using Tableau Public.

### Action:

#### Data Exploration:

Selected relevant columns and filtered the data to focus on non-null continents.
Queried total cases, new cases, total deaths, and population by location and date.

#### Analysis:

Calculated the death percentage by dividing total deaths by total cases.
Determined the percentage of the population infected with Covid-19.
Identified countries with the highest infection rates and death counts relative to their populations.
Analyzed data by continent to find the highest death counts per population.

Global Metrics:
Aggregated global numbers for total cases, total deaths, and the death percentage.

Vaccination Analysis:
Joined Covid-19 death data with vaccination data to calculate rolling totals of people vaccinated.
Used Common Table Expressions (CTEs) and temporary tables to compute the vaccination percentage of the population.

#### Visualization:
Created a view to store data for later visualizations in Tableau Public : [Tableau_Visualization](https://public.tableau.com/app/profile/el.mehdi.aliouan4405/viz/CovidDashboard_16738012660980/Dashboard1#1)


### Result:

The analysis provided insights into infection and death rates across different countries and continents, as well as the progress of vaccination efforts. The findings were visualized using Tableau Public, making it easier to understand the impact of Covid-19 globally.

### Reflection:

The project successfully utilized SQL to analyze and extract insights from Covid-19 data. Future improvements could include more granular analysis, such as regional breakdowns within countries or time-series analysis to observe trends over time.
