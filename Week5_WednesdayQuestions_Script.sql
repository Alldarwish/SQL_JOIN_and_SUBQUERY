-- Week 5 - Wednesday Questions
-- Q1. List all customers who live in Texas (use JOINs)
select customer.customer_id, first_name, last_name, email, store_id, active, district
from customer
full join address
on customer.address_id = address.address_id
where district = 'Texas';

-------------------------------------------------------------
-- Q2. Get all payments above $6.99 with the Customer's Full Name
select customer.customer_id, first_name, last_name, payment_id, amount, CAST(payment_date as DATE) date
from customer, payment
where customer.customer_id = payment.customer_id
and amount > 6.99;

-------------------------------------------------------------
-- Q3. Show all customers names who have made payments over $175(use subqueries)
select customer.customer_id, first_name, last_name, email, CAST(payment_date as DATE) date, amount
from customer, payment
where customer.customer_id in (
		select customer_id
		from payment
		group by customer_id
		having sum(amount) > 175)
order by customer.customer_id, date, amount;

-------------------------------------------------------------
-- Q4. List all customers that live in Nepal (use the city table)
select customer.customer_id, first_name, last_name, email, store_id, active, city.country_id, country
from customer
full join address
on customer.address_id = address.address_id
full join city
on address.city_id = city.city_id
full join country
on city.country_id = country.country_id
where country = 'Nepal';

-------------------------------------------------------------
-- Q5. Which staff member had the most transactions?
select rental.staff_id, first_name, last_name, count(rental.rental_id)
from rental, staff
where rental.staff_id = staff.staff_id
group by rental.staff_id, staff.first_name, staff.last_name
order by rental.staff_id;

-------------------------------------------------------------
-- Q6. How many movies of each rating are there?
select rating, count(film_id)
from film
group by rating
order by rating;

-------------------------------------------------------------
-- Q7. Show all customers who have made a single payment above $6.99 (Use Subqueries)
select payment.customer_id, first_name, last_name, email, CAST(payment_date as DATE) date, amount
from customer, payment
where amount in 
		(select amount
		from payment
		where amount > 6.99)
order by date;
-------------------------------------------------------------
-- Q8. How many free rentals did our stores give away?
select store_id, count(amount)
from store, payment
where payment.staff_id = store.manager_staff_id
and amount = 0
group by store_id;

-------------------------------------------------------------