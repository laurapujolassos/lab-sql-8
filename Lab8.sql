#Lab | SQL Queries 8
#1. Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.
select * from sakila.film;
select title,length, 
dense_rank() over (order by length asc) as ranking # ranking is a function that adds sequencial numbers. Ho tinc ordenat per duration asc i balance desc. En cada duration vull fer ranking. 
from sakila.film
where length > 0;

#2.Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). In your output, only select the columns title, length, rating and rank
select title,length, rating, 
dense_rank() over (partition by rating order by length asc) as ranking # ranking is a function that adds sequencial numbers. Ho tinc ordenat per duration asc i balance desc. En cada duration vull fer ranking. 
from sakila.film
where length > 0;

#3.How many films are there for each of the categories in the category table? Hint: Use appropriate join between the tables "category" and "film_category".
select * from sakila.category;
select * from sakila.film_category;


select c.name, c.category_id,count(film_id)
from sakila.category c 
left join sakila.film_category fc on c.category_id = fc.category_id
group by category_id;

#4.Which actor has appeared in the most films? 
select * from sakila.actor;
select * from sakila.film_actor;

select a.actor_id, a.first_name, a.last_name,count(film_id)
from sakila.actor a 
left join sakila.film_actor f on a.actor_id = f.actor_id
group by a.actor_id;

# 5. Which is the most active customer (the customer that has rented the most number of films)?

select * from sakila.customer;
select * from sakila.rental;

select c.customer_id, c.first_name, c.last_name,count(rental_id)
from sakila.customer c 
left join sakila.rental r on c.customer_id = r.customer_id
group by c.customer_id ;

# Bonus: Which is the most rented film? 
select * from sakila.film;
select * from sakila.inventory;
select * from sakila.rental;

select f.film_id, f.title, count(rental_id)
from sakila.film f
join sakila.inventory i on f.film_id = i.film_id 
join sakila.rental r on i.inventory_id = r.inventory_id
group by film_id
order by count(rental_id) desc;


