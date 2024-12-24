CREATE DATABASE DemoWebAppDB;
USE DemoWebAppDB;

CREATE TABLE SalesLegacy (
                             id INT AUTO_INCREMENT PRIMARY KEY,
                             year INT NOT NULL,
                             month INT NOT NULL,
                             amount DECIMAL(10, 2) NOT NULL
);

CREATE TABLE ExpensesLegacy (
                                id INT AUTO_INCREMENT PRIMARY KEY,
                                year INT NOT NULL,
                                month INT NOT NULL,
                                amount DECIMAL(10, 2) NOT NULL
);
-- Products Table
CREATE TABLE Products (
                          product_id INT AUTO_INCREMENT PRIMARY KEY,
                          name VARCHAR(255) NOT NULL,
                          description TEXT,
                          price DECIMAL(10, 2) NOT NULL,
                          category VARCHAR(100),
                          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- Customers Table
CREATE TABLE Customers (
                           customer_id INT AUTO_INCREMENT PRIMARY KEY,
                           first_name VARCHAR(100) NOT NULL,
                           last_name VARCHAR(100) NOT NULL,
                           email VARCHAR(255) UNIQUE NOT NULL,
                           phone VARCHAR(20),
                           address VARCHAR(255),
                           city VARCHAR(100),
                           state VARCHAR(100),
                           zip_code VARCHAR(10),
                           created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- Employees Table
CREATE TABLE Employees (
                           employee_id INT AUTO_INCREMENT PRIMARY KEY,
                           first_name VARCHAR(100) NOT NULL,
                           last_name VARCHAR(100) NOT NULL,
                           email VARCHAR(255) UNIQUE NOT NULL,
                           phone VARCHAR(20),
                           position VARCHAR(100),
                           salary DECIMAL(10, 2),
                           hire_date DATE,
                           created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- Orders Table
CREATE TABLE Orders (
                        order_id INT AUTO_INCREMENT PRIMARY KEY,
                        customer_id INT,
                        order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                        status VARCHAR(50) DEFAULT 'Pending',
                        total DECIMAL(10, 2) NOT NULL,
                        FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
-- OrderDetails Table
CREATE TABLE OrderDetails (
                              order_detail_id INT AUTO_INCREMENT PRIMARY KEY,
                              order_id INT,
                              product_id INT,
                              quantity INT NOT NULL,
                              price DECIMAL(10, 2) NOT NULL,
                              FOREIGN KEY (order_id) REFERENCES Orders(order_id),
                              FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
-- Inventory Table
CREATE TABLE Inventory (
                           product_id INT,
                           quantity_in_stock INT NOT NULL,
                           last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                           PRIMARY KEY (product_id),
                           FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
-- Shipping Details Table
CREATE TABLE ShippingDetails (
                                 shipping_id INT AUTO_INCREMENT PRIMARY KEY,
                                 order_id INT,
                                 address VARCHAR(255) NOT NULL,
                                 city VARCHAR(100) NOT NULL,
                                 state VARCHAR(100) NOT NULL,
                                 zip_code VARCHAR(10) NOT NULL,
                                 shipping_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                 FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);
-- Sales Table
CREATE TABLE Sales (
                       sale_id INT AUTO_INCREMENT PRIMARY KEY,
                       product_id INT,
                       customer_id INT,
                       quantity_sold INT NOT NULL,
                       total DECIMAL(10, 2) NOT NULL,
                       sale_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                       FOREIGN KEY (product_id) REFERENCES Products(product_id),
                       FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
-- Expenses Table
CREATE TABLE Expenses (
                          expense_id INT AUTO_INCREMENT PRIMARY KEY,
                          employee_id INT,
                          description VARCHAR(255) NOT NULL,
                          amount DECIMAL(10, 2) NOT NULL,
                          expense_date DATE,
                          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                          FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);
