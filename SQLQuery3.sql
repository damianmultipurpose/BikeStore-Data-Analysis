-- Select the necessary information to analyze customer orders, product sales, and store performance
SELECT 
    ord.order_id,  -- Order ID to uniquely identify each order
    CONCAT(cus.first_name, ' ', cus.last_name) AS full_name,  -- Customer's full name for better readability
    cus.city,  -- City of the customer
    cus.state,  -- State of the customer
    ord.order_date,  -- The date when the order was placed
    SUM(ite.quantity) AS total_units,  -- Total units ordered in this particular order (sum of all items ordered)
    SUM(ite.quantity * ite.list_price) AS revenue,  -- Revenue from this order (total units * price per unit)
    pro.product_name,  -- Name of the product being purchased
    cat.category_name,  -- Product category (e.g., mountain bikes, road bikes)
    sto.store_name,  -- Name of the store where the order was placed
    CONCAT(staf.first_name, ' ', staf.last_name) AS sales_rep  -- Name of the sales representative who handled the order

-- Joining various tables to bring together information from multiple sources
FROM sales.orders ord
-- Joining the orders table with the customers table to get customer details
JOIN sales.customers cus ON ord.customer_id = cus.customer_id
-- Joining the order_items table to get details about the products in each order
JOIN sales.order_items ite ON ord.order_id = ite.order_id
-- Joining the products table to get product names and other details
JOIN production.products pro ON ite.product_id = pro.product_id
-- Joining the categories table to get the category of each product
JOIN production.categories cat ON pro.category_id = cat.category_id
-- Joining the stores table to get the store name where the order was placed
JOIN sales.stores sto ON ord.store_id = sto.store_id
-- Joining the staffs table to identify which sales representative handled the order
JOIN sales.staffs staf ON ord.staff_id = staf.staff_id

-- Grouping the data by key attributes to get an aggregate summary of the orders
GROUP BY
    ord.order_id,  -- Grouping by Order ID to ensure that each order is summarized individually
    CONCAT(cus.first_name, ' ', cus.last_name),  -- Grouping by full name of the customer
    cus.city,  -- Grouping by city of the customer for geographic analysis
    cus.state,  -- Grouping by state of the customer
    ord.order_date,  -- Grouping by order date to analyze order trends over time
    pro.product_name,  -- Grouping by product name to see which products are selling the most
    cat.category_name,  -- Grouping by product category to identify top categories
    sto.store_name,  -- Grouping by store name to compare sales performance across stores
    CONCAT(staf.first_name, ' ', staf.last_name)  -- Grouping by sales representative to track performance by staff
