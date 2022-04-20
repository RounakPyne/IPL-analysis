/*Creating a Database and using it.*/
create database ipl;
use ipl;

/*Imported data using table data import wizard*/

/*List of all the teams.*/

select distinct teams as Teams from ipl;

/*List of teams and how many overseas players are there in 2022.*/

select distinct teams, year ,count(nationality)  as count
from ipl
where nationality = 'Overseas'
group by teams,year;

/*List of  top 10 players based on the price they were sold over the years*/

select player_name as `Name of player`, 
dense_rank() over (partition by year order by  sold_price DESC ) as `Rank`,
sold_price as `Price`,year as `Year`
from (select *,row_number() over (partition by year order by  sold_price DESC ) as `Number` from ipl) as top10
where Number <=10
order by year desc  ;

/*Teams which have paid highest money for their players over the years*/

select teams,dense_rank() over (partition by year order by  sold_price DESC ) as `Rank`,
sold_price as `Price`
from (select *,row_number() over (partition by year order by  sold_price DESC ) as `Number` from ipl) as top10
where Number <=1
order by year desc  ;

/*Which team has spent the most amount from 2013-2022.*/

select teams,sum(sold_price) as `Total Money spent` from ipl group by teams;

/*How many overseas and Indian players have played from in 2022.*/

select nationality,count(*) as count from ipl where year = 2022 group by nationality;






