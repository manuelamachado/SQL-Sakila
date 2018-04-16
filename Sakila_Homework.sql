USE sakila;

-- 1a.Display the first and last names of all actors from the table `actor`. 
select first_name,last_name from sakila.actor;
 
 -- 1b. Display the first and last name of each actor in a single column in upper case letters. Name the column `Actor Name`. 
select upper(concat( first_name , ' ' , last_name)) as Actor_Name
from sakila.actor;

-- 2a. You need to find the ID number, first name, and last name of an actor, 
-- of whom you know only the first name, "Joe." What is one query would you use to obtain this information?
select actor_id,first_name,last_name from sakila.actor
where first_name = 'Joe'; 

-- 2b. Find all actors whose last name contain the letters `GEN`:
select * from sakila.actor
where last_name like '%gen%';
  	
-- 2c. Find all actors whose last names contain the letters `LI`. This time, 
-- order the rows by last name and first name, in that order:
select * from sakila.actor
where last_name like '%li%'
order by last_name,first_name;

-- 2d. Using `IN`, display the `country_id` and `country` columns of the
--  following countries: Afghanistan, Bangladesh, and China:
select country_id,country
from sakila.country
where country in ('Afghanistan' , 'Bangladesh' , 'China');

-- 3a. Add a `middle_name` column to the table `actor`. Position it between 
-- `first_name` and `last_name`. Hint: you will need to specify the data type.
alter table sakila.actor
add column middle_name varchar(100) after first_name;

select * from sakila.actor;
  	
-- 3b. You realize that some of these actors have tremendously long last names. 
-- Change the data type of the `middle_name` column to `blobs`.
alter table sakila.actor
modify column middle_name BLOB ;


-- 3c. Now delete the `middle_name` column.
alter table sakila.actor 
drop column middle_name;

-- 4a. List the last names of actors, as well as how many actors have that last name.
select last_name, count(*)
from sakila.actor 
group by last_name;
  	
-- 4b. List last names of actors and the number of actors who have that last name,
-- but only for names that are shared by at least two actors
select last_name, count(*)
from sakila.actor 
group by last_name
having count(*) > 1;
  	
  	
-- 4c. Oh, no! The actor `HARPO WILLIAMS` was accidentally entered in the `actor` 
-- table as `GROUCHO WILLIAMS`, the name of Harpo's second cousin's husband's 
-- yoga teacher. Write a query to fix the record.
update sakila.actor 
set first_name = 'Harpo'
where first_name = 'Groucho' and last_name = 'Williams';

select * from sakila.actor
where first_name = 'Harpo' and last_name = 'Williams';
  	
-- 4d. Perhaps we were too hasty in changing `GROUCHO` to `HARPO`. 
-- It turns out that `GROUCHO` was the correct name after all! 
-- In a single query, if the first name of the actor is currently `HARPO`, 
-- change it to `GROUCHO`. Otherwise, change the first name to `MUCHO GROUCHO`, 
-- as that is exactly what the actor will be with the grievous error. BE CAREFUL NOT TO 
-- CHANGE THE FIRST NAME OF EVERY ACTOR TO `MUCHO GROUCHO`, 
-- HOWEVER! (Hint: update the record using a unique identifier.)

select * from sakila.actor
where first_name = 'Harpo';

update sakila.actor
set first_name = case when first_name ='Harpo' then  'GROUCHO' else 'MUCHO GROUCHO' end
where actor_id = 172 ;


select * from sakila.actor
where actor_id = 172;

-- 5a. You cannot locate the schema of the `address` table. Which query would you use to re-create it? 
show create table sakila.address;

-- 6a. Use `JOIN` to display the first and last names, as well as the address, 
-- of each staff member. Use the tables `staff` and `address`:
select st.first_name,st.last_name, ad.address,ad.address2
from sakila.staff st
left outer join sakila.address ad on st.address_id = ad.address_id;



-- 6b. Use `JOIN` to display the total amount rung up by each staff member in August of 2005. 
-- Use tables `staff` and `payment`. 

select first_name, last_name, sum(amount) as total_amount 
from sakila.staff st 
join sakila.payment pt
on st.staff_id = pt.staff_id 
where payment_date between '2005-08-01' and '2005-08-30'
group by first_name, last_name;

-- 6c. List each film and the number of actors who are listed for that film. 
-- Use tables `film_actor` and `film`. Use inner join.

select title, count(*) 
from sakila.film f
join sakila.film_actor fa
on f.film_id = fa.film_id
group by title
order by title; 
  	
-- 6d. How many copies of the film `Hunchback Impossible` exist in 
-- the inventory system?
select f.title , count(i.inventory_id)  as copies_available
from sakila.inventory i 
join sakila.film f on f.film_id = i.film_id
where f.title = 'Hunchback Impossible';

select count(*)
from sakila.inventory as copies_available
where film_id in 
(
select film_id
from sakila.film
where title =  'Hunchback Impossible'
);


-- 6e. Using the tables `payment` and `customer` and the `JOIN` command, 
-- list the total paid by each customer. List the customers alphabetically 
-- by last name:

select c.customer_id ,c.first_name,c.last_name, sum(amount) as total_amount_paid
from sakila.customer c
join sakila.payment p on c.customer_id = p.customer_id
group by c.customer_id ,c.first_name,c.last_name
order by c.last_name; 

select first_name, last_name, sum(amount) as total_amount_paid
from customer c 
join payment p 
on c.customer_id = p.customer_id 
group by p.customer_id 
order by last_name;

-- 7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. 
-- As an unintended consequence, films starting with the letters `K` and `Q` have also 
-- soared in popularity. Use subqueries to display the titles of movies starting with 
-- the letters `K` and `Q` whose language is English. 

select title 
from sakila.film
where title like 'K%' 
or title like 'Q%'
and language_id in 
(
select language_id
from sakila.language 
where name = 'English'
);


-- 7b. Use subqueries to display all actors who appear in the film `Alone Trip`.
select a.first_name , a.last_name 
from sakila.actor a
where a.actor_id in 
(
select fa.actor_id 
from sakila.film_actor fa  
join sakila.film f on fa.film_id = f.film_id 
where f.title = 'Alone Trip'
);

select first_name, last_name 
from sakila.actor 
where actor_id in 
(
select actor_id 
from sakila.film_actor 
where film_id in 
(
select film_id 
from sakila.film
where title = 'Alone Trip'
)
);
   
-- 7c. You want to run an email marketing campaign in Canada, for which you
-- will need the names and email addresses of all Canadian customers. Use joins 
-- to retrieve this information.
select c.customer_id,c.first_name,c.last_name,c.email
from sakila.customer  c 
join sakila.address a on c.address_id = a.address_id
join sakila.city ct on a.city_id = ct.city_id
join sakila.country cy on ct.country_id = cy.country_id
where cy.country = 'Canada';

select * from sakila.address;
select * from sakila.country;

select first_name, last_name, email 
from sakila.customer 
where address_id in 
(
select address_id 
from sakila.address 
where address_id in 
(
select city_id 
from sakila.city
where country_id in 
(
select country_id 
from sakila.country 
where country = 'Canada'
)
)
);

-- 7d. Sales have been lagging among young families, and you wish to target 
-- all family movies for a promotion. Identify all movies categorized as famiy films.
select f.title
from sakila.film_category fc
join sakila.category c on c.category_id = fc.category_id 
join sakila.film f on f.film_id = fc.film_id
where c.name = 'Family';

select title 
from sakila.film 
where film_id in 
(
select film_id 
from sakila.film_category
where category_id in 
(
select category_id 
from sakila.category 
where name = 'Family'
)
);

-- 7e. Display the most frequently rented movies in descending order.
select f.film_id, count(r.rental_id) as films_rented
from sakila.rental r 
join sakila.inventory i on r.inventory_id = i.inventory_id
join sakila.film f on i.film_id = f.film_id
group by 1
ORDER BY films_rented 
DESC LIMIT 5;

create view vw_rental_max_rentals as 
select inventory_id, count(*) as reccnt 
from rental 
GROUP BY inventory_id 
order by reccnt desc ;

select max(reccnt) 
from vw_rental_max_rentals;

select title 
from film 
where film_id in 
(
select distinct film_id  
from inventory 
where inventory_id in 
(
select inventory_id
from vw_rental_max_rentals 
where reccnt = 5
)
)
order by title desc;	
  
 
 
-- 7f. Write a query to display how much business, in dollars, each store brought in.
select s.store_id , sum(p.amount) as total_amount
from sakila.store s
left join sakila.staff st on s.store_id = st.store_id
left join sakila.payment p on st.staff_id = p.staff_id
group by s.store_id;

select s.store_id, sum(p.amount) as total_amount
from sakila.store s 
left join sakila.customer c on s.store_id = c.store_id 
left join sakila.payment p on c.customer_id = p.customer_id
group by s.store_id; 

-- 7g. Write a query to display for each store its store ID, city, and country.
select distinct s.store_id , c.city, ct.country
from sakila.store s
join sakila.address a on s.address_id = a.address_id
join sakila.city c on a.city_id = c.city_id
join sakila.country ct on c.country_id = ct.country_id;

select s.store_id, c.city, ct.country 
from store s 
left join address a on s.address_id = a.address_id 
left join city c on a.city_id = c.city_id 
left join country ct on c.country_id = ct.country_id; 

  	
--  7h. List the top five genres in gross revenue in descending order. 
-- (**Hint**: you may need to use the following tables: category, film_category, 
-- inventory, payment, and rental.)
select c.name , sum(p.amount) as gross_revenue
from sakila.inventory i
inner join sakila.film_category fc	on fc.film_id = i.film_id
inner join sakila.category c on fc.category_id = c.category_id 
inner join sakila.rental r on i.inventory_id = r.inventory_id
inner join sakila.payment p on p.rental_id = r.rental_id
group by c.name 
order by gross_revenue 
desc limit 5;

select c.name, sum(p.amount) as gross_revenue
FROM category c 
left join film_category fc on c.category_id = fc.category_id 
left join inventory i on fc.film_id = i.film_id 
left join rental r on i.inventory_id = r.inventory_id 
left join payment p on r.rental_id = p.rental_id 
group by c.name 
order by gross_revenue
desc limit 5;

-- 8a. In your new role as an executive, you would like to have an easy way of viewing the
--  Top five genres by gross revenue. Use the solution from the problem above to create a view.
-- If you haven't solved 7h, you can substitute another query to create a view.
create view sakila.top_five_genre as 
(
select c.name , sum(p.amount) as gross_revenue
from sakila.inventory i
inner join sakila.film_category fc	on fc.film_id = i.film_id
inner join sakila.category c on fc.category_id = c.category_id 
inner join sakila.rental r on i.inventory_id = r.inventory_id
inner join sakila.payment p on p.rental_id = r.rental_id
group by 1 
order by gross_revenue 
desc limit 5
);

select * from sakila.top_five_genre;

-- 8b. How would you display the view that you created in 8a?
select * from sakila.top_five_genre;

show create view sakila.top_five_genre;

-- 8c. You find that you no longer need the view `top_five_genres`. Write a query to delete it.
Drop view if exists sakila.top_five_genre;