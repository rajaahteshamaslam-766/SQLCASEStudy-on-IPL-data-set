#FIND TOTAL SPENDING ON PLAYERS FOR EACH TEAM.alter
SELECT TEAM,SUM(Price_in_cr) AS SPENDING 
FROM iplplayers
GROUP BY TEAM
order by 'Spending' asc;
#Total teams participating in ipl.
select count(distinct(team)) as total_teams from iplplayers;

# Q2. Find the top 3 highest paid 'All Rounders' across all teams.

select  player,team,Price_in_cr from iplplayers
where type = 'all-rounder'
order by Price_in_cr desc
limit 3;

# Q3. Find the highest priced player in each team.
select player,MAX(PRICE_IN_CR) as max_price
from iplplayers group by player
order by 3 desc;

# Q6. Calculate the percentage contribution of each player's price to their team's total spending.
select player,team ,price_in_cr,  (Price_in_cr/ sum(price_in_cr) over (partition by team))*100  as Contribution_Percentage
from iplplayers ;
# Q7. Classify players based on following rules 
-- high if price is greater then 15 crore
-- medium if price is between 5 and 15 crore
-- low if price is less then 5 crore
-- and count no of players in each class.

with ct_br AS(
select team,player,Price_in_cr,
    case 
        when price_in_cr >15 then 'High'
        when price_in_cr  between 5 and 15 then "Medium"
        else "Low"
	end as Price_Category
 from iplplayers )
 select team,price_category,count(*) as "No_of_Players"
 from ct_br 
 group by team,price_category
 order by team;


#Q8. Find the average price of indian players and compare it with overseas players using a subquery.

select 'indian' as player_type,(
select avg(price_in_cr) as avg_price_of_indian_players from iplplayers
where type like 'indian%') as avg_price
union all
select 'overseas' ,(
select avg(price_in_cr) as avg_price_of_overseas_player from iplplayers
where type like 'overseas%' ) as avg_price;

#Q9. Identify players who earn more then the average price of their team.

select player,team ,price_in_cr from iplplayers p
where price_in_cr > (
select avg(price_in_cr) as avg_price_of_team
from iplplayers
where team=p.team) ;

#Q no 10. For each role find the most expensive player and their price.
select player from iplayer;
select * from iplplayers;
select player,team,role,price_in_cr from iplplayers p
where price_in_cr =(select max(price_in_cr) from iplplayers
where role=p.role)
order by role;