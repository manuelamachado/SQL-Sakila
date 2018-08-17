## Sakila-SQL

You can down load the database from https://dev.mysql.com/doc/index-other.html

The Git repository also contains the Schema , Data SQL's

## Analyzes:

* Displayed the first and last names of all actors from the table `actor`. 

* Displayed the first and last name of each actor in a single column in upper case letters. Name the column `Actor Name`. 

* Found the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." What is one query would you use to obtain this information?
  	
*  Found all actors whose last name contain the letters `GEN`:
  	
* Found all actors whose last names contain the letters `LI`. This time, order the rows by last name and first name, in that order:

*  Displayed the `country_id` and `country` columns of the following countries: Afghanistan, Bangladesh, and China:

* Added a `middle_name` column to the table `actor`. Position it between `first_name` and `last_name`. Hint: you will need to specify the data type.
  	
* Changed the data type of the `middle_name` column to `blobs`.

* Deleted the `middle_name` column.

* Listed the last names of actors, as well as how many actors have that last name.
  	
* Listed last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
  	
* Wrote a query to fix the record. The actor `HARPO WILLIAMS` was accidentally entered in the `actor` table as `GROUCHO WILLIAMS`, the name of Harpo's second cousin's husband's yoga teacher. 
  	
* Wrote a query if the first name of the actor is currently `HARPO`, change it to `GROUCHO`. Otherwise, change the first name to `MUCHO GROUCHO`, as that is exactly what the actor will be with the grievous error.

* Created a query would you use to re-create the schema of the `address` table. 

* Used `JOIN` to display the first and last names, as well as the address, of each staff member. Use the tables `staff` and `address`:

* Used `JOIN` to display the total amount rung up by each staff member in August of 2005. Use tables `staff` and `payment`. 
  	
* Listed each film and the number of actors who are listed for that film. Use tables `film_actor` and `film`. Use inner join.
  	
* Counted How many copies of the film `Hunchback Impossible` exist in the inventory system.

* Used the tables `payment` and `customer` and the `JOIN` command, to list the total paid by each customer. Listed the customers alphabetically by last name:

  ```
  	![Total amount paid](Images/total_payment.png)
  ```

* Used subqueries to display the titles of movies starting with the letters `K` and `Q` whose language is English. 

* Used subqueries to display all actors who appear in the film `Alone Trip`.
   
* Used joins to retrieve the names and email addresses of all Canadian customers. 

* Identified all movies categorized as famiy films.

* Displayed the most frequently rented movies in descending order.
  	
* Wrote a query to display how much business, in dollars, each store brought in.

* Wrote a query to display for each store its store ID, city, and country.
  	
* Listed the top five genres in gross revenue in descending order. 
  	
* Displayed the view of the Top five genres by gross revenue. 

* Wrote a query to delete the view `top_five_genres`.

### List of Tables in the Sakila DB

* A schema is also available as `sakila_schema.svg`. Open it with a browser to view.

```sql
	'actor'
	'actor_info'
	'address'
	'category'
	'city'
	'country'
	'customer'
	'customer_list'
	'film'
	'film_actor'
	'film_category'
	'film_list'
	'film_text'
	'inventory'
	'language'
	'nicer_but_slower_film_list'
	'payment'
	'rental'
	'sales_by_film_category'
	'sales_by_store'
	'staff'
	'staff_list'
	'store'
```
