# brewery_database

This is a database I made as part of the Code First Girls SQL & Data course. The database is based around a fictional brewery, which shows a 'point in time' view - in the future I would like to be able to feed more information into this database, and to differentiate between new, unfulfilled orders and older, archived orders. I would also like to build a PowerBI dashboard to be able to analyse the data further.

The database has six tables which relates to the types of beers made by the brewery, the different vessels the beer is sold in (casks, bottles, cans), as well as information about the customers that the brewery delivers to, the orders and stock levels.

The order_details table uses foreign keys to show the link between the orders, the beers ordered and the customers. To make this table easier to use, I created a view which replaces the beer and item codes with names - the idea being that someone working at the brewery could easily read the orders.

To show orders which include more than one type of beer, I wrote a query with GROUP BY and HAVING. I also wrote a query with a subquery to show all orders where the customer is based in Liverpool (customer has a postcode beginning with 'L').

The stock table has quantities of available beer items in stock (eg. 9 casks of Oak Tree bitter). To give a more immediate view of the stock levels, I created a function which displays different statuses for different quantities ('In stock' for 10 or more, 'Low stock' for less than 10 but more than 0, and 'Out of stock' for 0).

I also created a procedure and a trigger which work together. The procedure makes it easy to add a new type of beer into the beers table, and the trigger ensures that the first character of the beer name is capitalised.



