#1.	Write a query to get Product name and quantity/unit.  
Select northwind.products.product_name, northwind.products.quantity_per_unit FROM northwind.products;

#2. Write a query to get current Product list (Product ID and name). 
Select northwind.products.id, northwind.products.product_name FROM northwind.products;

#3. Write a query to get discontinued Product list (Product ID and name). 
Select northwind.products.product_name, northwind.products.id FROM northwind.products WHERE northwind.products.discontinued ='1';

#4. Write a query to get most expensive and least expensive Product list (name and unit price).  
Select distinct northwind.products.product_name, northwind.order_details.unit_price FROM northwind.order_details JOIN northwind.products ON 
northwind.products.id = northwind.order_details.product_id WHERE unit_price= (SELECT MAX(unit_price) FROM order_details) OR 
unit_price= (SELECT MIN(unit_price) FROM order_details);

#5. Write a query to get Product list (id, name, unit price) where current products cost less than $20.  
Select distinct northwind.products.id, northwind.products.product_name, northwind.order_details.unit_price FROM northwind.products JOIN northwind.order_details ON 
northwind.products.id = northwind.products.id WHERE northwind.order_details.unit_price < 20 AND northwind.products.discontinued = FALSE;

#6. Write a query to get Product list (id, name, unit price) where products cost between $15 and $25.  
Select distinct northwind.products.id, northwind.products.product_name, northwind.order_details.unit_price FROM northwind.products JOIN northwind.order_details ON 
northwind.products.id = northwind.products.id WHERE northwind.order_details.unit_price between 15 and 25;

#7. Write a query to get Product list (name, unit price) of above average price.  
Select distinct northwind.products.product_name, northwind.order_details.unit_price FROM northwind.order_details JOIN northwind.products ON 
northwind.products.id = northwind.order_details.product_id WHERE northwind.order_details.unit_price> (SELECT AVG(unit_price) FROM northwind.order_details);

#8. Write a query to get Product list (name, unit price) of ten most expensive products.  
Select distinct northwind.products.product_name, northwind.order_details.unit_price FROM northwind.order_details JOIN northwind.products ON 
northwind.products.id = northwind.order_details.product_id ORDER by unit_price LIMIT 10;

#9. Write a query to count current and discontinued products. 
Select (Select COUNT(northwind.products.product_name) FROM northwind.products WHERE discontinued = 0) as 'Current', 
(Select COUNT(northwind.products.product_name) FROM northwind.products WHERE discontinued = 1) as 'Discontinued';

#10. Write a query to get Product list (name, units on order, units in stock) of stock is less than the quantity on order.  
Select northwind.products.product_name, northwind.products.quantity, northwind.inventory_transactions.quantity FROM northwind.products 
JOIN northwind.inventory_transactions ON northwind.products.id = northwind.inventory_transactions WHERE northwind.products.quantity < northwind.inventory_transactions.quantity;



