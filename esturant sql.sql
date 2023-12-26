-- OBJECTIVE 1
-- Explore the items table
-- 1.Your first objective is to better understand the items table by finding the number of rows in the table, 
-- the least and most expensive items, and the item prices within each category.

-- 1a.View the menu_items table and write a query to find the number of items on the menu
/*SELECT *
FROM menu_items*/

/*SELECT COUNT(menu_item_id) AS num_items_on_menu
FROM menu_items*/
-- ANSWER
-- The are 32 menu items

-- 1b What are the least and most expensive items on the menu?
SELECT MIN(price)AS min_price
FROM  menu_items

-- Min price of item is $5
SELECT MAX(price)AS max_price
FROM  menu_items

-- ANSWER
-- The max price of an item is $19.95

-- 1c.How many Italian dishes are on the menu? What are the least and most expensive Italian dishes on the menu
SELECT COUNT(menu_item_id) AS num_of_menu_item
FROM menu_items
WHERE category='Italian'

-- ANSWER
-- The are 9 Italian dishes on the menu

SELECT MAX(price) ,item_name
FROM menu_items
WHERE category='Italian'
GROUP BY item_name

-- The most expensive item on the menu being italian is the shrimp scampi

SELECT MIN(price) ,item_name
FROM menu_items
WHERE category='Italian'
GROUP BY item_name

-- The least expensive italian item on the menu is spagetti

-- 1d.How many dishes are in each category? What is the average dish price within each category?
 SELECT COUNT(menu_item_id) AS num_of_items,category
 FROM menu_items
 GROUP BY category
 
 -- ANSWER
 6 MENU_ITEMS are American
 8 Menu_items are Asian
 9 Menu_items are Maxican
 9 Menu_items are Italian
 
 SELECT AVG(price),category
 FROM menu_items
 GROUP BY category
 --The average price of American menu_item is $10.066667
 --The average price of Asian menu_item is $13.475000
 --The average price of Mexican menu_item is $11.800000
 --The average price of Italian menu_item is $10.066667
 
 -- OBJECTIVE 2
-- Explore the orders table
--  second objective is to better understand the orders table by finding the date range, the number of items within each order, and the orders with the highest number of items.
-- 2.View the order_details table. What is the date range of the table?

SELECT MIN(order_date)
FROM order_details

-- MIN date 01-01-2023

SELECT MAX(order_date)
FROM order_details
-- MAX DATE 2023-03-01
-- RANGE OF DATES =2023-01-01 - 2023-03-31

-- 2b. How many orders were made within this date range? How many items were ordered within this date range?
SELECT COUNT(DISTINCT order_id) AS num_orders
FROM order_details
WHERE order_date BETWEEN '2023-01-01' AND '2023-03-31'

-- 5370 Orders were placed bete=ween '2023-01-01' AND '2023-03-31'

SELECT COUNT(DISTINCT item_id) AS num_items
FROM order_details
WHERE order_date BETWEEN '2023-01-01' AND '2023-03-31'

-- 32 items were made BETWEEN '2023-01-01' AND '2023-03-31

-- 2c Which orders had the most number of items?
SELECT order_id,COUNT(item_id) AS num_items
FROM order_details
GROUP BY order_id
ORDER BY num_items DESC

-- order_id 330,440,443,1957,2675,3473 and 4305 have the highest num of items 14

-- How many orders had more than 12 items?	
SELECT order_id ,COUNT(item_id)AS num_items
FROM order_details
GROUP BY order_id
HAVING COUNT(item_id)>12

-- 20 ORDERS had more than 12 items 

-- find the least and most ordered categories, and dive into the details of the highest spend orders.
-- 3a Combine the menu_items and order_details tables into a single table

SELECT *
FROM menu_items m
JOIN order_details o
ON m.menu_item_id=o.item_id

-- 3b What were the least and most ordered items? What categories were they in?
SELECT item_name,COUNT(order_id)AS num_orders,category
FROM menu_items m
JOIN order_details o
ON m.menu_item_id=o.item_id
GROUP BY Item_name,category
ORDER BY num_orders DESC
LIMIT 10
            
-- Least ordered items on the menu by category
SELECT item_name,COUNT(order_id)AS num_orders,category
FROM menu_items m
JOIN order_details o
ON m.menu_item_id=o.item_id
GROUP BY Item_name,category
ORDER BY num_orders ASC
LIMIT 5

-- What were the top 5 orders that spent the most money?
SELECT order_id,SUM(price) AS Total_spent
FROM menu_items m
JOIN order_details o
ON m.menu_item_id=o.item_id 
GROUP BY order_id
ORDER BY Total_spent DESC
LIMIT 5

-- View the details of the highest spend order. Which specific items were purchased?
SELECT item_name
FROM menu_items m
JOIN order_details o
ON m.menu_item_id=o.item_id
WHERE order_id=440
-- Order_440 contains steak tacos,hotdog,spagetti,2 spagetti meatballs,2 fettuccine alfredo,korean beefbowl,meat lasagna,edamame,chips and salsa,chicken parmesan,french fries,eggplant parmesan

-- View the details of the top 5 highest spend orders
SELECT order_id,item_name
FROM menu_items m
JOIN order_details o
ON m.menu_item_id=o.item_id
WHERE order_id IN(440,2075,1957,330,2675)

SELECT COUNT(order_id) AS num_orders,order_time
FROM  menu_items m
JOIN order_details o
ON m.menu_item_id=o.item_id
GROUP BY order_time

-- Were there certain times that had more or less orders?
SELECT DATE_FORMAT(order_date,'%Y-%M')AS month,
COUNT(order_id) AS total_orders
FROM order_details
GROUP BY month
ORDER BY month

-- ANSWER 
-- January had 4156 orders
-- February had 3892 orders
-- March had 4186 orders

SELECT order_date,order_time,
COUNT(order_id) AS total_orders
FROM order_details
GROUP BY order_date,order_time
ORDER BY total_orders DESC

SELECT  CONCAT(order_date,' ',order_time) AS order_datetime,COUNT(order_id) AS total_orders
FROM order_details
GROUP BY order_datetime
ORDER BY total_orders DESC

-- ANSWER 
-- From the results we can see that most orders takes place between 12.16pm to 14.50pm 

-- Which cuisines should we focus on developing more menu items for based on the data
-- We should focus on on developing more menu items that have higher order count.Before expanding the menu a survey should be carried out maybe seasonal specials as wellAlso consider customer feedback about the least ordered menu_items.we only had data for three months so we cannot annalyse the seasonal trends.
-- 