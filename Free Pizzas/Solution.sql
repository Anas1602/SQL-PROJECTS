-- SOLUTION
select * from pizza_delivery

select 
		FORMAT(order_time, 'MMM-yy') as period,
		round(
			(sum (
				case 
					when	
						datediff(minute, order_time, actual_delivery) > 30 
					then 1 
					else 0 
				end) / cast(count(1) as decimal)) *100,1) as delayed_delivery_perc,
		sum(
			case 
				when datediff(minute, order_time, actual_delivery) > 30 
				then no_of_pizzas 
				else 0 
			end) as free_pizzas
from pizza_delivery
where actual_delivery is not null
group by FORMAT(order_time, 'MMM-yy')



