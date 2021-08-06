CREATE DATABASE revival_brewing_co;

USE revival_brewing_co;

CREATE TABLE beers (
	beer_code CHAR(4),
    beer_name VARCHAR(50) NOT NULL,
    style VARCHAR(50) NOT NULL,
    alc_vol DECIMAL(3,2) NOT NULL,
    price_code DECIMAL(3,2) NOT NULL,
CONSTRAINT pk_beer_code PRIMARY KEY (beer_code)
);

CREATE TABLE items (
	item_code CHAR(4),
    item_name VARCHAR(50) NOT NULL,
    base_price DECIMAL(10,2) NOT NULL,
    litres_per_item DECIMAL(10,3) NOT NULL,
    litres_total DECIMAL(10,3) NOT NULL,
    units_per_item INT NOT NULL,
CONSTRAINT pk_item_code PRIMARY KEY (item_code)
);

CREATE TABLE stock (
	stock_code CHAR(4),
    beer_code CHAR(4) NOT NULL,
    item_code CHAR(4) NOT NULL,
    quantity INT NOT NULL,
    exp_date DATE NOT NULL,
CONSTRAINT pk_stock_code PRIMARY KEY (stock_code),
CONSTRAINT fk_s_beer_code FOREIGN KEY (beer_code) REFERENCES beers(beer_code),
CONSTRAINT fk_s_item_code FOREIGN KEY (item_code) REFERENCES items(item_code)
);

CREATE TABLE customers (
	customer_code CHAR(4),
    customer_first_name VARCHAR(50) NOT NULL,
    customer_surname VARCHAR(50) NOT NULL,
    email_address VARCHAR(100) NOT NULL CHECK (email_address = '%@%'),
    phone_number CHAR(11) NOT NULL,
    post_code VARCHAR(8) NOT NULL,
    premises_name VARCHAR(50) NOT NULL,
    premises_type SET('pub','shop') NOT NULL,
CONSTRAINT pk_customer_code PRIMARY KEY (customer_code)
);

CREATE TABLE orders (
	order_code CHAR(4),
    customer_code CHAR(4) NOT NULL,
    order_placed DATETIME NOT NULL,
CONSTRAINT pk_order_code PRIMARY KEY (order_code)
);

CREATE TABLE order_details (
	order_code CHAR(4) NOT NULL,
    beer_code CHAR(4) NOT NULL,
    item_code CHAR(4) NOT NULL,
    quantity INT NOT NULL,
CONSTRAINT fk_od_order_code FOREIGN KEY (order_code) REFERENCES orders(order_code),
CONSTRAINT fk_od_beer_code FOREIGN KEY (beer_code) REFERENCES beers(beer_code),
CONSTRAINT fk_od_item_code FOREIGN KEY (item_code) REFERENCES items(item_code)
);


ALTER TABLE orders
ADD CONSTRAINT
fk_o_customer_code FOREIGN KEY (customer_code) REFERENCES customers(customer_code);

ALTER TABLE customers
DROP COLUMN email_address;

ALTER TABLE customers
ADD email_address VARCHAR(100) NOT NULL CHECK (email_address LIKE '%@%');

INSERT INTO beers (beer_code, beer_name, style, alc_vol, price_code)
VALUES
	('b001', 'Finish Line', 'IPA', 5.1, 1),
	('b002', 'Greyhound', 'Golden', 4.3, 0.98),
	('b003', 'Oak Tree', 'Bitter', 3.8, 0.95),
	('b004', 'After Dark', 'Stout', 5.2, 1.05),
	('b005', 'Great Pretender', 'Lager', 0.5, 0.89),
	('b006', 'Staycation', 'Lager', 4.7, 0.99),
	('b007', 'Big Time', 'IPA', 6, 1.12),
	('b008', 'Mallard', 'Blond', 5.5, 1.07);
    
INSERT INTO items (item_code, item_name, base_price, litres_per_item, litres_total, units_per_item)
VALUES
	('i001', 'barrel', 190.66, 163.659, 163.659, 1),
	('i002', 'firkin', 95.47, 40.91, 40.91, 1),
	('i003', 'bottles_small_case', 17.99, 0.33, 7.92, 24),
	('i004', 'bottles_large_case', 14.27, 0.5, 6, 10),
	('i005', 'cans_case', 16.79, 0.33, 7.92, 24);
    
INSERT INTO stock (stock_code, beer_code, item_code, quantity, exp_date)
VALUES
	('s001', 'b001', 'i002', 42, 20211031), 
	('s002', 'b001', 'i005', 51, 20211031), 
	('s003', 'b002', 'i002', 36, 20211112), 
	('s004', 'b002', 'i004', 44, 20211112), 
	('s005', 'b002', 'i004', 6, 20210818), 
	('s006', 'b003', 'i001', 18, 20210915), 
	('s007', 'b003', 'i004', 53, 20210915), 
	('s008', 'b004', 'i002', 27, 20210927), 
	('s009', 'b004', 'i004', 29, 20210927), 
	('s010', 'b005', 'i003', 79, 20211018), 
	('s011', 'b006', 'i003', 53, 20211018), 
	('s012', 'b006', 'i001', 32, 20211018), 
	('s013', 'b007', 'i005', 66, 20210918), 
	('s014', 'b007', 'i002', 59, 20210918), 
	('s015', 'b008', 'i001', 3, 20210916), 
	('s016', 'b008', 'i005', 8, 20210916);
    
INSERT INTO customers (customer_code, customer_first_name, customer_surname, email_address, phone_number, post_code, premises_name, premises_type)
VALUES
	('c001', 'Jane', 'Beer', 'jbeer@theswan.co.uk', '01613668547', 'SK14 9LW', 'The Swan', 'Pub'), 
	('c002', 'Richard', 'Malt', 'richm@liverpooolplough.co.uk', '01512346597', 'L3 5TR', 'The Plough', 'Pub'), 
	('c003', 'Judy', 'Garland', 'judy@thestarpub.co.uk', '01517894561', 'L18 6BP', 'The Star', 'Pub'), 
	('c004', 'Thomas', 'Bottle', 'tom@bottlesdeli.co.uk', '01519876541', 'L6 6RD', 'Bottles Deli', 'Shop'), 
	('c005', 'Susan', 'Head', 'sue@miab.co.uk', '01925456789', 'WA1 5GH', 'Message In A Bottle', 'Shop'), 
	('c006', 'Mary', 'Tap', 'mary@tappedbar.co.uk', '01611234567', 'M4 8FT', 'Tapped', 'Pub'), 
	('c007', 'Roger', 'Barrel', 'rog@redlionpub.co.uk', '01619876541', 'M16 8AW', 'Red Lion', 'Pub'), 
	('c008', 'Sean', 'Glass', 'seang@thenavigation.co.uk', '01519632587', 'L30 0BH', 'The Navigation', 'Pub'), 
	('c009', 'Jean', 'Topup', 'jean_t@thebottleshopwarrington.co.uk', '01925774112', 'WA5 6TR', 'The Bottle Shop', 'Shop'), 
	('c010', 'Chris', 'Ferment', 'chris@hhpub.co.uk', '01613244566', 'SK15 1AB', 'Hare and Hounds', 'Pub'), 
	('c011', 'Hannah', 'Merry', 'hannah@craftwerk.co.uk', '01619877845', 'M40 7YG', 'CraftWerk', 'Shop'), 
	('c012', 'Joy', 'Porter', 'joy@theotter.co.uk', '01616639564', 'M13 8UJ', 'The Otter', 'Pub'), 
	('c013', 'Kevin', 'Barley', 'kev@catfiddle.co.uk', '01925778457', 'WA10 4RF', 'Cat and Fiddle', 'Pub'), 
	('c014', 'Catherine', 'Mash', 'cat@farmersarms.co.uk', '01457232569', 'SK6 8LP', 'Farmers Arms', 'Pub'), 
	('c015', 'Jess', 'Tipple', 'jess@cheshirecat.co.uk', '01613689988', 'SK12 7LW', 'Cheshire Cat', 'Pub'); 


INSERT INTO orders (order_code, customer_code, order_placed)
VALUES
	('o001', 'c001', '2021-04-06 10:24:39'),
	('o002', 'c002', '2021-04-07 11:37:50'), 
	('o003', 'c003', '2021-04-07 15:42:19'), 
	('o004', 'c004', '2021-04-16 15:42:19'), 
	('o005', 'c005', '2021-04-20 17:14:56'), 
	('o006', 'c006', '2021-04-23 08:27:04'), 
	('o007', 'c007', '2021-05-03 09:08:54'), 
	('o008', 'c008', '2021-05-10 17:13:22'), 
	('o009', 'c009', '2021-05-17 07:27:34'), 
	('o010', 'c010', '2021-05-19 20:39:36'), 
	('o011', 'c002', '2021-05-26 10:15:58'), 
	('o012', 'c001', '2021-05-26 13:27:44'), 
	('o013', 'c005', '2021-05-30 16:23:18'), 
	('o014', 'c011', '2021-06-04 08:37:51'), 
	('o015', 'c012', '2021-06-05 11:12:13'), 
	('o016', 'c014', '2021-06-06 19:01:32'), 
	('o017', 'c003', '2021-06-08 20:27:39'), 
	('o018', 'c006', '2021-06-09 10:45:06'), 
	('o019', 'c013', '2021-06-10 15:39:39'), 
	('o020', 'c009', '2021-06-19 14:44:03'), 
	('o021', 'c001', '2021-06-19 21:49:59'), 
	('o022', 'c002', '2021-06-23 10:33:06'), 
	('o023', 'c010', '2021-06-25 12:11:08'), 
	('o024', 'c015', '2021-06-28 09:14:47'), 
	('o025', 'c005', '2021-06-29 15:36:11'), 
	('o026', 'c015', '2021-06-30 12:57:01'), 
	('o027', 'c012', '2021-07-02 16:53:48'), 
	('o028', 'c014', '2021-07-04 20:52:49'), 
	('o029', 'c008', '2021-07-04 21:11:53'), 
	('o030', 'c007', '2021-07-06 14:27:28'), 
	('o031', 'c013', '2021-07-09 10:15:12'), 
	('o032', 'c006', '2021-07-10 11:11:03'), 
	('o033', 'c003', '2021-07-12 15:57:04'), 
	('o034', 'c009', '2021-07-13 18:01:24'), 
	('o035', 'c002', '2021-07-15 16:23:56'), 
	('o036', 'c004', '2021-07-18 02:13:57'), 
	('o037', 'c005', '2021-07-20 07:59:46'), 
	('o038', 'c010', '2021-07-21 11:53:11'), 
	('o039', 'c008', '2021-07-22 14:31:44'), 
	('o040', 'c012', '2021-07-23 16:55:14'), 
	('o041', 'c015', '2021-07-24 13:54:07');

INSERT INTO order_details
VALUES
	('o001', 'b001', 'i002', 5), 
	('o001', 'b004', 'i004', 6), 
	('o001', 'b003', 'i001', 2), 
	('o002', 'b001', 'i005', 6), 
	('o002', 'b004', 'i004', 6), 
	('o003', 'b001', 'i002', 3), 
	('o004', 'b007', 'i005', 4), 
	('o004', 'b004', 'i004', 4), 
	('o005', 'b001', 'i005', 7), 
	('o005', 'b004', 'i004', 4), 
	('o006', 'b004', 'i002', 4), 
	('o007', 'b001', 'i002', 5), 
	('o007', 'b007', 'i002', 7), 
	('o008', 'b006', 'i001', 3), 
	('o008', 'b004', 'i004', 9), 
	('o009', 'b006', 'i003', 10), 
	('o009', 'b003', 'i004', 10), 
	('o010', 'b008', 'i001', 4), 
	('o011', 'b003', 'i001', 6), 
	('o011', 'b007', 'i002', 6), 
	('o011', 'b006', 'i003', 6), 
	('o011', 'b004', 'i004', 6), 
	('o012', 'b008', 'i001', 8), 
	('o013', 'b007', 'i005', 5), 
	('o013', 'b004', 'i004', 5), 
	('o014', 'b007', 'i005', 10), 
	('o014', 'b004', 'i004', 10), 
	('o014', 'b001', 'i005', 10), 
	('o015', 'b004', 'i002', 6), 
	('o016', 'b001', 'i002', 4), 
	('o017', 'b006', 'i001', 3), 
	('o017', 'b004', 'i004', 4), 
	('o018', 'b001', 'i005', 4), 
	('o018', 'b004', 'i002', 6), 
	('o018', 'b007', 'i002', 8), 
	('o019', 'b007', 'i002', 8), 
	('o020', 'b002', 'i004', 5), 
	('o020', 'b003', 'i004', 5), 
	('o021', 'b007', 'i002', 5), 
	('o021', 'b004', 'i004', 7), 
	('o022', 'b006', 'i001', 3), 
	('o023', 'b007', 'i002', 8), 
	('o024', 'b008', 'i001', 4), 
	('o025', 'b004', 'i004', 6), 
	('o025', 'b008', 'i005', 8), 
	('o026', 'b008', 'i001', 3), 
	('o027', 'b001', 'i002', 5), 
	('o027', 'b002', 'i002', 5), 
	('o028', 'b006', 'i001', 6), 
	('o028', 'b006', 'i003', 3), 
	('o029', 'b006', 'i001', 3), 
	('o030', 'b001', 'i002', 4), 
	('o031', 'b007', 'i002', 4), 
	('o031', 'b007', 'i002', 4), 
	('o032', 'b004', 'i002', 3), 
	('o033', 'b007', 'i002', 5), 
	('o033', 'b006', 'i003', 2), 
	('o034', 'b008', 'i005', 1), 
	('o034', 'b004', 'i004', 2), 
	('o034', 'b003', 'i004', 3), 
	('o035', 'b006', 'i001', 2), 
	('o036', 'b006', 'i003', 4),  
	('o037', 'b002', 'i004', 6), 
	('o037', 'b006', 'i003', 12), 
	('o038', 'b007', 'i002', 5), 
	('o038', 'b007', 'i002', 5), 
	('o039', 'b002', 'i002', 3), 
	('o040', 'b001', 'i002', 6), 
	('o040', 'b008', 'i001', 6), 
	('o040', 'b006', 'i003', 6), 
	('o041', 'b001', 'i002', 7), 
	('o041', 'b006', 'i001', 2); 





/* Create a view that uses at least 3 4 base tables prepare and demonstrate a query that uses the view to produce a
logically arranged result set for analysis
	AND
Using any type of the joins create a view that combines multiple tables in a logical way */
# I am creating a view to show the beer and item names as well as the quantities on order

CREATE OR REPLACE VIEW vw_order_sheet
AS
	SELECT od.order_code, b.beer_name, i.item_name, od.quantity
	FROM order_details od
	LEFT JOIN beers b
	ON od.beer_code = b.beer_code
	LEFT JOIN items i
	ON od.item_code = i.item_code;

SELECT * FROM vw_order_sheet;

SELECT * FROM order_details;

#Prepare an example query with group by and having to demonstrate how to extract data from your DB for analysis
#I want to find out which orders contain more than one type of beer

SELECT od.order_code, COUNT(od.beer_code) AS 'Different Beers Ordered'
FROM order_details od
GROUP BY od.order_code
HAVING COUNT(od.beer_code) > 1;


#Prepare an example query with a subquery to demonstrate how to extract data from your DB for analysis
#I want to bring back a list of all order codes where the customer is based in Liverpool (postcode starts with 'L')

SELECT o.order_code, o.customer_code, c.customer_first_name, c.customer_surname, c.post_code
FROM orders o
LEFT JOIN customers c
ON o.customer_code = c.customer_code
WHERE o.customer_code IN (
	SELECT c.customer_code
    FROM customers c
    WHERE c.post_code LIKE 'L%'
);


#In your database, create a stored function that can be applied to a query in your DB
#I have created a function to assign a stock level to each entry on the Stock table, as 'In Stock', 'Low Stock' or 'Out of Stock'

DELIMITER //
CREATE FUNCTION stock_check(beer_code CHAR(4), quantity INT)

RETURNS VARCHAR(20)
DETERMINISTIC

BEGIN
	DECLARE stock_level VARCHAR(20);
    IF quantity >= 10 THEN
		SET stock_level = 'In Stock';
	ELSEIF quantity > 0 THEN
		SET stock_level = 'Low Stock';
	ELSE
		SET stock_level = 'Out of Stock';
	END IF;
	RETURN (stock_level);

END //
DELIMITER ;


SELECT s.stock_code, b.beer_name, i.item_name, s.quantity, stock_check(s.beer_code, s.quantity) AS 'Stock Level'
FROM stock s
LEFT JOIN beers b
ON s.beer_code = b.beer_code
LEFT JOIN items i
ON s.item_code = i.item_code;


#In your database, create a stored procedure and demonstrate how it runs
#I created a stored procedure to add a beer into the beers table

DELIMITER //

CREATE PROCEDURE add_beer(
IN beer_code CHAR(4),
IN beer_name VARCHAR(50),
IN style VARCHAR(50),
IN alc_vol DEC(3,2),
IN price_code DEC(3,2))

BEGIN
	INSERT INTO beers (beer_code, beer_name, style, alc_vol, price_code)
    VALUES (beer_code, beer_name, style, alc_vol, price_code);
END //

DELIMITER ;

CALL add_beer ('b011', 'dandelion', 'IPA', 4.30, 0.9);

SELECT* FROM beers;
	

#In your database, create a trigger and demonstrate how it runs
#Related to the procedure above, I want to make sure that the beer names and styles are capitalised on entry

DELIMITER //
CREATE TRIGGER names_capitalised
BEFORE INSERT ON beers
FOR EACH ROW
BEGIN
	SET NEW.beer_name =
	CONCAT(UPPER(SUBSTRING(NEW.beer_name,1,1)),
	LOWER(SUBSTRING(NEW.beer_name FROM 2))),
    NEW.style = 
    CONCAT(UPPER(SUBSTRING(NEW.style,1,1)),
	SUBSTRING(NEW.style FROM 2));
END //
DELIMITER ;

