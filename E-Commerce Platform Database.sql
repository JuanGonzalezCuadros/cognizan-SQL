CREATE DATABASE ECommercePlatform;
USE ECommercePlatform;

# Create Users Table
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(50) NOT NULL,
    role VARCHAR(50) NOT NULL
);

# Create Products Table
CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(50) NOT NULL,
    category VARCHAR(50),
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT NOT NULL
);

# Create Orders Table
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10, 2) NOT NULL,
    order_status VARCHAR(50) DEFAULT 'pending',
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

# Create OrderDetails Table
CREATE TABLE OrderDetails (
    order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    unit_price DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

# Create Payments Table
CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    payment_method VARCHAR(50) NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

# Create Reviews Table
CREATE TABLE Reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    user_id INT,
    review_text TEXT,
    rating INT CHECK(rating BETWEEN 1 AND 5),
    review_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);



# Insert sample users
INSERT INTO Users (username, email, password, role) VALUES
('john_doe', 'john@example.com', 'password123', 'customer'),
('jane_doe', 'jane@example.com', 'password456', 'customer'),
('admin_user', 'admin@example.com', 'adminpassword', 'admin');

# Insert sample products
INSERT INTO Products (product_name, category, price, stock_quantity) VALUES
('Smartphone', 'Electronics', 599.99, 50),
('Laptop', 'Electronics', 899.99, 30),
('Headphones', 'Electronics', 199.99, 100),
('Coffee Maker', 'Home Appliances', 49.99, 200),
('Running Shoes', 'Sportswear', 79.99, 150);

# Insert sample orders
INSERT INTO Orders (user_id, total_amount, order_status) VALUES
(1, 799.98, 'shipped'),
(2, 1499.98, 'pending'),
(1, 49.99, 'delivered');

# Insert order details
INSERT INTO OrderDetails (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 599.99),
(1, 3, 1, 199.99),
(2, 2, 1, 899.99),
(3, 4, 1, 49.99);

# Insert sample payments
INSERT INTO Payments (order_id, payment_method, amount) VALUES
(1, 'credit_card', 799.98),
(2, 'paypal', 1499.98),
(3, 'credit_card', 49.99);

# Insert sample reviews
INSERT INTO Reviews (product_id, user_id, review_text, rating) VALUES
(1, 1, 'Great smartphone with amazing features!', 5),
(2, 2, 'Laptop works perfectly for my needs.', 4),
(3, 1, 'The headphones have great sound quality.', 5),
(4, 2, 'The coffee maker is easy to use and brews quickly.', 4);



# Retrieve the list of all products in a specific category
SELECT product_name, price, stock_quantity
FROM Products
WHERE category = 'Electronics';

# Retrieve the details of a specific user by providing their user_id
SELECT *
FROM Users
WHERE user_id = 1;

# Retrieve the order history for a particular user
SELECT *
FROM Orders
WHERE user_id = 2;

# Retrieve the products in an order along with their quantities and prices
SELECT p.product_name, od.quantity, od.unit_price
FROM OrderDetails od
JOIN Products p ON od.product_id = p.product_id
WHERE od.order_id = 1;

# Retrieve the average rating of a product
SELECT AVG(rating) AS average_rating
FROM Reviews
WHERE product_id = 2;

# Retrieve the total revenue for a given month
SELECT SUM(amount) AS total_revenue
FROM Payments
WHERE MONTH(payment_date) = 5 AND YEAR(payment_date) = 2025;



# Add a new product to the inventory
INSERT INTO Products (product_name, category, price, stock_quantity) VALUES
('Smartwatch', 'Electronics', 199.99, 75);

# Place a new order for a user
INSERT INTO Orders (user_id, total_amount, order_status) VALUES
(1, 699.99, 'pending');

INSERT INTO OrderDetails (order_id, product_id, quantity, unit_price) VALUES
(4, 1, 1, 599.99),
(4, 5, 1, 79.99);

# Update the stock quantity of a product
UPDATE Products
SET stock_quantity = stock_quantity - 1
WHERE product_id = 1;

# Remove a user's review
DELETE FROM Reviews
WHERE review_id = 2;



# Identify the top-selling products
SELECT p.product_name, SUM(od.quantity) AS total_sold
FROM OrderDetails od
JOIN Products p ON od.product_id = p.product_id
GROUP BY od.product_id
ORDER BY total_sold DESC
LIMIT 5;

# Find users who have placed orders exceeding a certain amount
SELECT u.username, SUM(o.total_amount) AS total_spent
FROM Orders o
JOIN Users u ON o.user_id = u.user_id
GROUP BY o.user_id
HAVING total_spent > 1000;

# Calculate the overall average rating for each product category
SELECT p.category, AVG(r.rating) AS average_rating
FROM Reviews r
JOIN Products p ON r.product_id = p.product_id
GROUP BY p.category;



# Automatically update the order status based on order processing


# Generate a report on the most active users
SELECT u.username, COUNT(o.order_id) AS number_of_orders
FROM Orders o
JOIN Users u ON o.user_id = u.user_id
GROUP BY o.user_id
ORDER BY number_of_orders DESC
LIMIT 5;
