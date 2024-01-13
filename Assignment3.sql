-- may be these queries do not give you the right answer while applying to the original database
-- but while applying to what i get here, logic seems right to me  
-- but cuz tables are pretty messed up here so may be it can give you wrong answer
-- if this happens than you can ask me to explain logic on zoom meet 

--1. List all customers who live in Texas (use JOINs)
SELECT * 
from customer
where customer.city in
(SELECT city.city
from city
join address
on city.city_id = address.city_id
where address.district = 'Texas') 



-- 2. Get all payments above $6.99 with the Customer's Full Name


select amount, first_name || ' ' || last_name as full_name
from customer c
join payment p
on c.customer_id = p.customer_id
where p.amount > 6.99
order by c.customer_id 



-- 3. Show all customers names who have made payments over $175(use subqueries)


-- Using Subqueries
select first_name || ' ' || last_name as full_name
from customer
where customer_id in 
(
select customer_id
from payment
where amount > 175)


-- using join
select first_name || ' ' || last_name as full_name, amount
from customer c
left join payment p
on c.customer_id = p.customer_id
where p.amount > 175



-- 4. List all customers that live in Nepal (use the city table)

SELECT *
from customer
where customer.city in(
SELECT ci.city -- , co.country,co.country_id,row_number() over(partition by co.country order by co.country) rn
from city ci
left join country co
on ci.country_id = co.country_id
where co.country = 'Nepal'
);



-- 5. Which staff member had the most transactions?

-- lets check how many total staff_ids are present 
select count(distinct staff_id)
from payment

SELECT  count(distinct payment_id) as Transactions, staff_id
from payment
GROUP BY staff_id
order by count(payment_id) desc
limit 1



--6. How many movies of each rating are there?

SELECT count(distinct film_id) as movie_count, rating
from film
group by rating
order by movie_count

-- 7.Show all customers who have made a single payment above $6.99 (Use Subqueries)
SELECT *
from customer c
where customer_id in
    (select p.customer_id 
    FROM payment p
    where p.amount > 6.99)

-- 8. How many free rental did our store give away

-- Using Joins 
select count(distinct p.rental_id) as free_rentals
from rental r
join payment p
on r.rental_id = p.rental_id 
and p.amount <= 0


-- using subQueries
select count(distinct rental_id) as free_rentals
from rental
where rental_id in 
    (select rental_id 
    from payment
    where amount <= 0)



    echo "# SQL_basicMediumQueries" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/sukhpreet1910/SQL_basicMediumQueries.git
git push -u origin main