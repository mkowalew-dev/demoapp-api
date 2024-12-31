-- Create the database
CREATE DATABASE DemoWebAppProd;
USE DemoWebAppProd;

-- User Accounts Table for Online Store
CREATE TABLE Users (
                       user_id INT AUTO_INCREMENT PRIMARY KEY,
                       first_name VARCHAR(100) NOT NULL,
                       last_name VARCHAR(100) NOT NULL,
                       email VARCHAR(255) UNIQUE NOT NULL,
                       password_hash VARCHAR(255) NOT NULL,
                       avatar_url VARCHAR(255), -- URL to the avatar image
                       phone VARCHAR(20),
                       address VARCHAR(255),
                       city VARCHAR(100),
                       state VARCHAR(100),
                       zip_code VARCHAR(10),
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- Insert 2 Admin Users
INSERT INTO Users (first_name, last_name, email, password_hash, avatar_url, phone, address, city, state, zip_code) VALUES
                                                                                                                       ('Admin', 'User', 'admin@demowebapp.net', SHA2('CAdemo123', 256), 'http://staging.demowebapp.net/avatar/admin1.jpg', '555-0100', '123 Admin St', 'Admin City', 'CA', '90001'),
                                                                                                                       ('Presales', 'Admin', 'presales@demowebapp.net', SHA2('CAdemo123', 256), 'http://staging.demowebapp.net/avatar/admin2.jpg', '555-0101', '456 Admin Blvd', 'Admin Town', 'NY', '10001');

-- Insert 10 Demo Users
INSERT INTO Users (first_name, last_name, email, password_hash, avatar_url, phone, address, city, state, zip_code) VALUES
                                                                                                                       ('Demo', 'User1', 'demo1@example.com', SHA2('password123', 256), 'http://staging.demowebapp.net/avatar/demo1.jpg', '555-0200', '789 Demo Rd', 'Demo City', 'TX', '73301'),
                                                                                                                       ('Demo', 'User2', 'demo2@example.com', SHA2('password123', 256), 'http://staging.demowebapp.net/avatar/demo2.jpg', '555-0201', '101 Demo Ln', 'Demo Town', 'FL', '33101'),
                                                                                                                       ('Demo', 'User3', 'demo3@example.com', SHA2('password123', 256), 'http://staging.demowebapp.net/avatar/demo3.jpg', '555-0202', '202 Demo Ave', 'Demo Village', 'IL', '60601'),
                                                                                                                       ('Demo', 'User4', 'demo4@example.com', SHA2('password123', 256), 'http://staging.demowebapp.net/avatar/demo4.jpg', '555-0203', '303 Demo St', 'Demo Borough', 'WA', '98101'),
                                                                                                                       ('Demo', 'User5', 'demo5@example.com', SHA2('password123', 256), 'http://staging.demowebapp.net/avatar/demo5.jpg', '555-0204', '404 Demo Dr', 'Demo Hamlet', 'OR', '97201'),
                                                                                                                       ('Demo', 'User6', 'demo6@example.com', SHA2('password123', 256), 'http://staging.demowebapp.net/avatar/demo6.jpg', '555-0205', '505 Demo Ct', 'Demo Estate', 'GA', '30301'),
                                                                                                                       ('Demo', 'User7', 'demo7@example.com', SHA2('password123', 256), 'http://staging.demowebapp.net/avatar/demo7.jpg', '555-0206', '606 Demo Blvd', 'Demo District', 'AZ', '85001'),
                                                                                                                       ('Demo', 'User8', 'demo8@example.com', SHA2('password123', 256), 'http://staging.demowebapp.net/avatar/demo8.jpg', '555-0207', '707 Demo Way', 'Demo Sector', 'NV', '89101'),
                                                                                                                       ('Demo', 'User9', 'demo9@example.com', SHA2('password123', 256), 'http://staging.demowebapp.net/avatar/demo9.jpg', '555-0208', '808 Demo Pl', 'Demo Region', 'CO', '80201'),
                                                                                                                       ('Demo', 'User10', 'demo10@example.com', SHA2('password123', 256), 'http://staging.demowebapp.net/avatar/demo10.jpg', '555-0209', '909 Demo Pkwy', 'Demo Zone', 'MI', '48201');
-- Products Table
CREATE TABLE Products (
                          product_id INT AUTO_INCREMENT PRIMARY KEY,
                          name VARCHAR(255) NOT NULL,
                          description TEXT,
                          price DECIMAL(10, 2) NOT NULL,
                          category VARCHAR(100),
                          photo_url VARCHAR(255), -- URL to the product photo
                          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO Products (name, description, price, category, photo_url) VALUES
                                                                         ('Laptop A', '14-inch laptop with 8GB RAM and 256GB SSD', 699.99, 'Electronics', 'https://example.com/photos/laptop-a.jpg'),
                                                                         ('Laptop B', '15-inch laptop with 16GB RAM and 512GB SSD', 999.99, 'Electronics', 'https://example.com/photos/laptop-b.jpg'),
                                                                         ('Smartphone A', '5G smartphone with 128GB storage', 599.99, 'Mobile Phones', 'https://example.com/photos/smartphone-a.jpg'),
                                                                         ('Smartphone B', '4G smartphone with 64GB storage', 399.99, 'Mobile Phones', 'https://example.com/photos/smartphone-b.jpg'),
                                                                         ('Tablet A', '10-inch tablet with 64GB storage and Wi-Fi', 299.99, 'Tablets', 'https://example.com/photos/tablet-a.jpg'),
                                                                         ('Tablet B', '8-inch tablet with 32GB storage and LTE', 199.99, 'Tablets', 'https://example.com/photos/tablet-b.jpg'),
                                                                         ('Headphones A', 'Wireless headphones with noise cancellation', 149.99, 'Audio', 'https://example.com/photos/headphones-a.jpg'),
                                                                         ('Headphones B', 'Over-ear headphones with deep bass', 89.99, 'Audio', 'https://example.com/photos/headphones-b.jpg'),
                                                                         ('Camera A', 'DSLR camera with 24MP sensor and 18-55mm lens', 549.99, 'Photography', 'https://example.com/photos/camera-a.jpg'),
                                                                         ('Camera B', 'Compact camera with 20MP sensor', 299.99, 'Photography', 'https://example.com/photos/camera-b.jpg'),
                                                                         ('Smartwatch A', 'Smartwatch with heart rate monitor and GPS', 199.99, 'Wearables', 'https://example.com/photos/smartwatch-a.jpg'),
                                                                         ('Smartwatch B', 'Fitness tracker with sleep tracking', 99.99, 'Wearables', 'https://example.com/photos/smartwatch-b.jpg'),
                                                                         ('Speaker A', 'Bluetooth speaker with 12-hour battery life', 49.99, 'Audio', 'https://example.com/photos/speaker-a.jpg'),
                                                                         ('Speaker B', 'Portable speaker with waterproof design', 59.99, 'Audio', 'https://example.com/photos/speaker-b.jpg'),
                                                                         ('Router A', 'Wi-Fi 6 router with gigabit ports', 129.99, 'Networking', 'https://example.com/photos/router-a.jpg'),
                                                                         ('Router B', 'Dual-band Wi-Fi router with parental controls', 79.99, 'Networking', 'https://example.com/photos/router-b.jpg'),
                                                                         ('Monitor A', '27-inch 4K UHD monitor with HDR', 379.99, 'Computers', 'https://example.com/photos/monitor-a.jpg'),
                                                                         ('Monitor B', '24-inch Full HD monitor with IPS panel', 179.99, 'Computers', 'https://example.com/photos/monitor-b.jpg'),
                                                                         ('Keyboard A', 'Mechanical keyboard with RGB lighting', 119.99, 'Computers', 'https://example.com/photos/keyboard-a.jpg'),
                                                                         ('Keyboard B', 'Wireless keyboard with ergonomic design', 49.99, 'Computers', 'https://example.com/photos/keyboard-b.jpg'),
                                                                         ('Mouse A', 'Gaming mouse with 16,000 DPI sensor', 59.99, 'Computers', 'https://example.com/photos/mouse-a.jpg'),
                                                                         ('Mouse B', 'Wireless mouse with silent clicks', 29.99, 'Computers', 'https://example.com/photos/mouse-b.jpg'),
                                                                         ('Printer A', 'All-in-one printer with wireless printing', 129.99, 'Office', 'https://example.com/photos/printer-a.jpg'),
                                                                         ('Printer B', 'Laser printer with duplex printing', 199.99, 'Office', 'https://example.com/photos/printer-b.jpg'),
                                                                         ('Chair A', 'Ergonomic office chair with lumbar support', 299.99, 'Furniture', 'https://example.com/photos/chair-a.jpg'),
                                                                         ('Chair B', 'Mesh back office chair with adjustable height', 159.99, 'Furniture', 'https://example.com/photos/chair-b.jpg'),
                                                                         ('Desk A', 'Standing desk with adjustable height', 499.99, 'Furniture', 'https://example.com/photos/desk-a.jpg'),
                                                                         ('Desk B', 'L-shaped desk with cable management', 249.99, 'Furniture', 'https://example.com/photos/desk-b.jpg'),
                                                                         ('Lamp A', 'LED desk lamp with touch control', 39.99, 'Home', 'https://example.com/photos/lamp-a.jpg'),
                                                                         ('Lamp B', 'Floor lamp with adjustable arm', 69.99, 'Home', 'https://example.com/photos/lamp-b.jpg'),
                                                                         ('Cookware Set A', '10-piece non-stick cookware set', 99.99, 'Kitchen', 'https://example.com/photos/cookware-a.jpg'),
                                                                         ('Cookware Set B', 'Stainless steel cookware set with lids', 149.99, 'Kitchen', 'https://example.com/photos/cookware-b.jpg'),
                                                                         ('Vacuum A', 'Cordless vacuum cleaner with powerful suction', 199.99, 'Appliances', 'https://example.com/photos/vacuum-a.jpg'),
                                                                         ('Vacuum B', 'Robot vacuum with smart mapping', 299.99, 'Appliances', 'https://example.com/photos/vacuum-b.jpg'),
                                                                         ('Fridge A', 'Top-freezer refrigerator with energy star', 599.99, 'Appliances', 'https://example.com/photos/fridge-a.jpg'),
                                                                         ('Fridge B', 'Side-by-side refrigerator with water dispenser', 899.99, 'Appliances', 'https://example.com/photos/fridge-b.jpg'),
                                                                         ('Washer A', 'Front-load washing machine with steam', 699.99, 'Appliances', 'https://example.com/photos/washer-a.jpg'),
                                                                         ('Washer B', 'Top-load washing machine with agitator', 499.99, 'Appliances', 'https://example.com/photos/washer-b.jpg'),
                                                                         ('Dryer A', 'Electric dryer with sensor dry', 599.99, 'Appliances', 'https://example.com/photos/dryer-a.jpg'),
                                                                         ('Dryer B', 'Gas dryer with wrinkle prevent option', 649.99, 'Appliances', 'https://example.com/photos/dryer-b.jpg'),
                                                                         ('Coffee Maker A', 'Drip coffee maker with programmable settings', 39.99, 'Kitchen', 'https://example.com/photos/coffee-a.jpg'),
                                                                         ('Coffee Maker B', 'Single-serve coffee maker with pod compatibility', 79.99, 'Kitchen', 'https://example.com/photos/coffee-b.jpg'),
                                                                         ('Blender A', 'High-speed blender with multiple settings', 89.99, 'Kitchen', 'https://example.com/photos/blender-a.jpg'),
                                                                         ('Blender B', 'Personal blender with travel cup', 29.99, 'Kitchen', 'https://example.com/photos/blender-b.jpg'),
                                                                         ('Mixer A', 'Stand mixer with 6-quart bowl', 299.99, 'Kitchen', 'https://example.com/photos/mixer-a.jpg'),
                                                                         ('Mixer B', 'Hand mixer with turbo boost function', 49.99, 'Kitchen', 'https://example.com/photos/mixer-b.jpg'),
                                                                         ('Toaster A', '4-slice toaster with bagel setting', 49.99, 'Kitchen', 'https://example.com/photos/toaster-a.jpg'),
                                                                         ('Toaster B', '2-slice toaster with defrost function', 29.99, 'Kitchen', 'https://example.com/photos/toaster-b.jpg');

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
-- Insert Customers for Detroit
INSERT INTO Customers (first_name, last_name, email, phone, address, city, state, zip_code) VALUES
                                                                                                ('John', 'Doe', 'johndetroit1@example.com', '555-0101', '123 Elm St', 'Detroit', 'MI', '48201'),
                                                                                                ('Jane', 'Smith', 'janedetroit2@example.com', '555-0102', '456 Oak St', 'Detroit', 'MI', '48202'),
                                                                                                ('Alice', 'Johnson', 'alicedetroit3@example.com', '555-0103', '789 Maple Ave', 'Detroit', 'MI', '48203'),
                                                                                                ('Robert', 'Brown', 'robertdetroit4@example.com', '555-0104', '101 Pine St', 'Detroit', 'MI', '48204'),
                                                                                                ('Michael', 'Davis', 'michaeldetroit5@example.com', '555-0105', '202 Cedar Ave', 'Detroit', 'MI', '48205'),
                                                                                                ('Emily', 'Wilson', 'emilydetroit6@example.com', '555-0106', '303 Birch Ln', 'Detroit', 'MI', '48206'),
                                                                                                ('David', 'Miller', 'daviddetroit7@example.com', '555-0107', '404 Walnut St', 'Detroit', 'MI', '48207'),
                                                                                                ('Sarah', 'Taylor', 'sarahdetroit8@example.com', '555-0108', '505 Chestnut Ave', 'Detroit', 'MI', '48208');

-- Insert Customers for Pittsburgh
INSERT INTO Customers (first_name, last_name, email, phone, address, city, state, zip_code) VALUES
                                                                                                ('Richard', 'Anderson', 'richardpitt1@example.com', '555-0201', '606 Sycamore Ln', 'Pittsburgh', 'PA', '15201'),
                                                                                                ('Jessica', 'Thomas', 'jessicapitt2@example.com', '555-0202', '707 Aspen Dr', 'Pittsburgh', 'PA', '15202'),
                                                                                                ('Charles', 'Jackson', 'charlespitt3@example.com', '555-0203', '808 Willow St', 'Pittsburgh', 'PA', '15203'),
                                                                                                ('Laura', 'White', 'laurapitt4@example.com', '555-0204', '909 Poplar Ave', 'Pittsburgh', 'PA', '15204'),
                                                                                                ('Daniel', 'Harris', 'danielpitt5@example.com', '555-0205', '1010 Oak Dr', 'Pittsburgh', 'PA', '15205'),
                                                                                                ('Sophia', 'Martin', 'sophiapitt6@example.com', '555-0206', '1111 Spruce St', 'Pittsburgh', 'PA', '15206'),
                                                                                                ('James', 'Thompson', 'jamespitt7@example.com', '555-0207', '1212 Pine Ave', 'Pittsburgh', 'PA', '15207'),
                                                                                                ('Olivia', 'Garcia', 'oliviapitt8@example.com', '555-0208', '1313 Maple Ln', 'Pittsburgh', 'PA', '15208');

-- Insert Customers for San Diego
INSERT INTO Customers (first_name, last_name, email, phone, address, city, state, zip_code) VALUES
                                                                                                ('Matthew', 'Martinez', 'matthewsd1@example.com', '555-0301', '1414 Birch St', 'San Diego', 'CA', '92101'),
                                                                                                ('Ava', 'Robinson', 'avasd2@example.com', '555-0302', '1515 Cedar Ave', 'San Diego', 'CA', '92102'),
                                                                                                ('Joshua', 'Clark', 'joshuasd3@example.com', '555-0303', '1616 Walnut Ln', 'San Diego', 'CA', '92103'),
                                                                                                ('Isabella', 'Rodriguez', 'isabellasd4@example.com', '555-0304', '1717 Chestnut Dr', 'San Diego', 'CA', '92104'),
                                                                                                ('Ethan', 'Lewis', 'ethansd5@example.com', '555-0305', '1818 Sycamore St', 'San Diego', 'CA', '92105'),
                                                                                                ('Mia', 'Lee', 'miasd6@example.com', '555-0306', '1919 Aspen Ave', 'San Diego', 'CA', '92106'),
                                                                                                ('Alexander', 'Walker', 'alexandersd7@example.com', '555-0307', '2020 Poplar Ln', 'San Diego', 'CA', '92107'),
                                                                                                ('Amelia', 'Hall', 'ameliasd8@example.com', '555-0308', '2121 Willow Dr', 'San Diego', 'CA', '92108');

-- Insert Customers for Baltimore
INSERT INTO Customers (first_name, last_name, email, phone, address, city, state, zip_code) VALUES
                                                                                                ('William', 'Allen', 'williambalt1@example.com', '555-0401', '2222 Spruce Ave', 'Baltimore', 'MD', '21201'),
                                                                                                ('Emma', 'Scott', 'emmabalt2@example.com', '555-0402', '2323 Elm St', 'Baltimore', 'MD', '21202'),
                                                                                                ('Lucas', 'Adams', 'lucasbalt3@example.com', '555-0403', '2424 Oak St', 'Baltimore', 'MD', '21203'),
                                                                                                ('Ava', 'Parker', 'avabalt4@example.com', '555-0404', '2525 Maple Ave', 'Baltimore', 'MD', '21204'),
                                                                                                ('Noah', 'Evans', 'noahbalt5@example.com', '555-0405', '2626 Pine St', 'Baltimore', 'MD', '21205'),
                                                                                                ('Liam', 'Turner', 'liambalt6@example.com', '555-0406', '2727 Cedar Ave', 'Baltimore', 'MD', '21206'),
                                                                                                ('Sophia', 'Collins', 'sophiabalt7@example.com', '555-0407', '2828 Birch Ln', 'Baltimore', 'MD', '21207'),
                                                                                                ('Mason', 'Stewart', 'masonbalt8@example.com', '555-0408', '2929 Walnut St', 'Baltimore', 'MD', '21208');

-- Insert Customers for Phoenix
INSERT INTO Customers (first_name, last_name, email, phone, address, city, state, zip_code) VALUES
                                                                                                ('Ella', 'Sanchez', 'ellaphoenix1@example.com', '555-0501', '3030 Chestnut Ave', 'Phoenix', 'AZ', '85001'),
                                                                                                ('Lucas', 'Morris', 'lucasphoenix2@example.com', '555-0502', '3131 Aspen Dr', 'Phoenix', 'AZ', '85002'),
                                                                                                ('Charlotte', 'Rogers', 'charlottephoenix3@example.com', '555-0503', '3232 Willow St', 'Phoenix', 'AZ', '85003'),
                                                                                                ('Henry', 'Reed', 'henryphoenix4@example.com', '555-0504', '3333 Poplar Ave', 'Phoenix', 'AZ', '85004'),
                                                                                                ('Avery', 'Cook', 'averyphoenix5@example.com', '555-0505', '3434 Elm St', 'Phoenix', 'AZ', '85005'),
                                                                                                ('Jackson', 'Morgan', 'jacksonphoenix6@example.com', '555-0506', '3535 Oak St', 'Phoenix', 'AZ', '85006'),
                                                                                                ('Scarlett', 'Bell', 'scarlettphoenix7@example.com', '555-0507', '3636 Maple Ave', 'Phoenix', 'AZ', '85007'),
                                                                                                ('Aiden', 'Murphy', 'aidenphoenix8@example.com', '555-0508', '3737 Pine St', 'Phoenix', 'AZ', '85008');

-- Insert Customers for New Orleans
INSERT INTO Customers (first_name, last_name, email, phone, address, city, state, zip_code) VALUES
                                                                                                ('Aubrey', 'Bailey', 'aubreyneworleans1@example.com', '555-0601', '3838 Cedar Ave', 'New Orleans', 'LA', '70112'),
                                                                                                ('Carter', 'Rivera', 'carterneworleans2@example.com', '555-0602', '3939 Birch Ln', 'New Orleans', 'LA', '70113'),
                                                                                                ('Lily', 'Cooper', 'lilyneworleans3@example.com', '555-0603', '4040 Walnut St', 'New Orleans', 'LA', '70114'),
                                                                                                ('Evelyn', 'Richardson', 'evelynneworleans4@example.com', '555-0604', '4141 Chestnut Ave', 'New Orleans', 'LA', '70115'),
                                                                                                ('Benjamin', 'Cox', 'benjaminneworleans5@example.com', '555-0605', '4242 Aspen Dr', 'New Orleans', 'LA', '70116'),
                                                                                                ('Sofia', 'Howard', 'sofianeworleans6@example.com', '555-0606', '4343 Willow St', 'New Orleans', 'LA', '70117'),
                                                                                                ('Jack', 'Ward', 'jackneworleans7@example.com', '555-0607', '4444 Poplar Ave', 'New Orleans', 'LA', '70118'),
                                                                                                ('Madison', 'Torres', 'madisonneworleans8@example.com', '555-0608', '4545 Elm St', 'New Orleans', 'LA', '70119');
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
                           avatar_url VARCHAR(255), -- URL to the avatar image
                           created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- Insert Employees for Detroit
INSERT INTO Employees (first_name, last_name, email, phone, position, salary, hire_date, avatar_url) VALUES
                                                                                                         ('John', 'Doe', 'john.doe1@detroit.example.com', '555-1001', 'Manager', 65000.00, '2022-01-15', 'https://example.com/avatars/john1.jpg'),
                                                                                                         ('Jane', 'Smith', 'jane.smith2@detroit.example.com', '555-1002', 'Sales Associate', 40000.00, '2021-05-22', 'https://example.com/avatars/jane2.jpg'),
                                                                                                         ('Alice', 'Johnson', 'alice.johnson3@detroit.example.com', '555-1003', 'Cashier', 30000.00, '2020-03-18', 'https://example.com/avatars/alice3.jpg'),
                                                                                                         ('Robert', 'Brown', 'robert.brown4@detroit.example.com', '555-1004', 'Stock Clerk', 32000.00, '2019-11-11', 'https://example.com/avatars/robert4.jpg'),
                                                                                                         ('Michael', 'Davis', 'michael.davis5@detroit.example.com', '555-1005', 'Security', 35000.00, '2018-08-09', 'https://example.com/avatars/michael5.jpg'),
                                                                                                         ('Emily', 'Wilson', 'emily.wilson6@detroit.example.com', '555-1006', 'HR Specialist', 45000.00, '2017-02-14', 'https://example.com/avatars/emily6.jpg'),
                                                                                                         ('David', 'Miller', 'david.miller7@detroit.example.com', '555-1007', 'Assistant Manager', 55000.00, '2016-07-07', 'https://example.com/avatars/david7.jpg'),
                                                                                                         ('Sarah', 'Taylor', 'sarah.taylor8@detroit.example.com', '555-1008', 'Janitor', 28000.00, '2021-12-01', 'https://example.com/avatars/sarah8.jpg'),
                                                                                                         ('Richard', 'Anderson', 'richard.anderson9@detroit.example.com', '555-1009', 'IT Support', 48000.00, '2015-09-05', 'https://example.com/avatars/richard9.jpg'),
                                                                                                         ('Jessica', 'Thomas', 'jessica.thomas10@detroit.example.com', '555-1010', 'Customer Service', 31000.00, '2019-10-10', 'https://example.com/avatars/jessica10.jpg'),
                                                                                                         ('Charles', 'Jackson', 'charles.jackson11@detroit.example.com', '555-1011', 'Logistics', 37000.00, '2018-04-04', 'https://example.com/avatars/charles11.jpg'),
                                                                                                         ('Laura', 'White', 'laura.white12@detroit.example.com', '555-1012', 'Marketing', 52000.00, '2020-06-23', 'https://example.com/avatars/laura12.jpg');

-- Insert Employees for Pittsburgh
INSERT INTO Employees (first_name, last_name, email, phone, position, salary, hire_date, avatar_url) VALUES
                                                                                                         ('Daniel', 'Harris', 'daniel.harris1@pittsburgh.example.com', '555-2001', 'Manager', 66000.00, '2022-02-15', 'https://example.com/avatars/daniel1.jpg'),
                                                                                                         ('Sophia', 'Martin', 'sophia.martin2@pittsburgh.example.com', '555-2002', 'Sales Associate', 41000.00, '2021-04-21', 'https://example.com/avatars/sophia2.jpg'),
                                                                                                         ('James', 'Thompson', 'james.thompson3@pittsburgh.example.com', '555-2003', 'Cashier', 31000.00, '2020-02-17', 'https://example.com/avatars/james3.jpg'),
                                                                                                         ('Olivia', 'Garcia', 'olivia.garcia4@pittsburgh.example.com', '555-2004', 'Stock Clerk', 33000.00, '2019-12-12', 'https://example.com/avatars/olivia4.jpg'),
                                                                                                         ('Matthew', 'Martinez', 'matthew.martinez5@pittsburgh.example.com', '555-2005', 'Security', 36000.00, '2018-09-10', 'https://example.com/avatars/matthew5.jpg'),
                                                                                                         ('Ava', 'Robinson', 'ava.robinson6@pittsburgh.example.com', '555-2006', 'HR Specialist', 46000.00, '2017-03-11', 'https://example.com/avatars/ava6.jpg'),
                                                                                                         ('Joshua', 'Clark', 'joshua.clark7@pittsburgh.example.com', '555-2007', 'Assistant Manager', 56000.00, '2016-08-08', 'https://example.com/avatars/joshua7.jpg'),
                                                                                                         ('Isabella', 'Rodriguez', 'isabella.rodriguez8@pittsburgh.example.com', '555-2008', 'Janitor', 29000.00, '2021-11-05', 'https://example.com/avatars/isabella8.jpg'),
                                                                                                         ('Ethan', 'Lewis', 'ethan.lewis9@pittsburgh.example.com', '555-2009', 'IT Support', 49000.00, '2015-07-06', 'https://example.com/avatars/ethan9.jpg'),
                                                                                                         ('Mia', 'Lee', 'mia.lee10@pittsburgh.example.com', '555-2010', 'Customer Service', 32000.00, '2019-09-09', 'https://example.com/avatars/mia10.jpg'),
                                                                                                         ('Alexander', 'Walker', 'alexander.walker11@pittsburgh.example.com', '555-2011', 'Logistics', 38000.00, '2018-03-03', 'https://example.com/avatars/alexander11.jpg'),
                                                                                                         ('Amelia', 'Hall', 'amelia.hall12@pittsburgh.example.com', '555-2012', 'Marketing', 53000.00, '2020-05-22', 'https://example.com/avatars/amelia12.jpg');

-- Insert Employees for San Diego
INSERT INTO Employees (first_name, last_name, email, phone, position, salary, hire_date, avatar_url) VALUES
                                                                                                         ('William', 'Allen', 'william.allen1@sandiego.example.com', '555-3001', 'Manager', 67000.00, '2022-03-15', 'https://example.com/avatars/william1.jpg'),
                                                                                                         ('Emma', 'Scott', 'emma.scott2@sandiego.example.com', '555-3002', 'Sales Associate', 42000.00, '2021-03-20', 'https://example.com/avatars/emma2.jpg'),
                                                                                                         ('Lucas', 'Adams', 'lucas.adams3@sandiego.example.com', '555-3003', 'Cashier', 32000.00, '2020-01-16', 'https://example.com/avatars/lucas3.jpg'),
                                                                                                         ('Ava', 'Parker', 'ava.parker4@sandiego.example.com', '555-3004', 'Stock Clerk', 34000.00, '2019-11-13', 'https://example.com/avatars/ava4.jpg'),
                                                                                                         ('Noah', 'Evans', 'noah.evans5@sandiego.example.com', '555-3005', 'Security', 37000.00, '2018-10-11', 'https://example.com/avatars/noah5.jpg'),
                                                                                                         ('Liam', 'Turner', 'liam.turner6@sandiego.example.com', '555-3006', 'HR Specialist', 47000.00, '2017-04-12', 'https://example.com/avatars/liam6.jpg'),
                                                                                                         ('Sophia', 'Collins', 'sophia.collins7@sandiego.example.com', '555-3007', 'Assistant Manager', 57000.00, '2016-09-09', 'https://example.com/avatars/sophia7.jpg'),
                                                                                                         ('Mason', 'Stewart', 'mason.stewart8@sandiego.example.com', '555-3008', 'Janitor', 30000.00, '2021-10-05', 'https://example.com/avatars/mason8.jpg'),
                                                                                                         ('Ella', 'Sanchez', 'ella.sanchez9@sandiego.example.com', '555-3009', 'IT Support', 50000.00, '2015-06-07', 'https://example.com/avatars/ella9.jpg'),
                                                                                                         ('Lucas', 'Morris', 'lucas.morris10@sandiego.example.com', '555-3010', 'Customer Service', 33000.00, '2019-08-08', 'https://example.com/avatars/lucas10.jpg'),
                                                                                                         ('Charlotte', 'Rogers', 'charlotte.rogers11@sandiego.example.com', '555-3011', 'Logistics', 39000.00, '2018-02-02', 'https://example.com/avatars/charlotte11.jpg'),
                                                                                                         ('Henry', 'Reed', 'henry.reed12@sandiego.example.com', '555-3012', 'Marketing', 54000.00, '2020-04-21', 'https://example.com/avatars/henry12.jpg');

-- Insert Employees for Baltimore
INSERT INTO Employees (first_name, last_name, email, phone, position, salary, hire_date, avatar_url) VALUES
                                                                                                         ('Avery', 'Cook', 'avery.cook1@baltimore.example.com', '555-4001', 'Manager', 68000.00, '2022-04-15', 'https://example.com/avatars/avery1.jpg'),
                                                                                                         ('Jackson', 'Morgan', 'jackson.morgan2@baltimore.example.com', '555-4002', 'Sales Associate', 43000.00, '2021-02-19', 'https://example.com/avatars/jackson2.jpg'),
                                                                                                         ('Scarlett', 'Bell', 'scarlett.bell3@baltimore.example.com', '555-4003', 'Cashier', 33000.00, '2020-12-15', 'https://example.com/avatars/scarlett3.jpg'),
                                                                                                         ('Aiden', 'Murphy', 'aiden.murphy4@baltimore.example.com', '555-4004', 'Stock Clerk', 35000.00, '2019-10-12', 'https://example.com/avatars/aiden4.jpg'),
                                                                                                         ('Aubrey', 'Bailey', 'aubrey.bailey5@baltimore.example.com', '555-4005', 'Security', 38000.00, '2018-11-13', 'https://example.com/avatars/aubrey5.jpg'),
                                                                                                         ('Carter', 'Rivera', 'carter.rivera6@baltimore.example.com', '555-4006', 'HR Specialist', 48000.00, '2017-05-13', 'https://example.com/avatars/carter6.jpg'),
                                                                                                         ('Lily', 'Cooper', 'lily.cooper7@baltimore.example.com', '555-4007', 'Assistant Manager', 58000.00, '2016-10-10', 'https://example.com/avatars/lily7.jpg'),
                                                                                                         ('Evelyn', 'Richardson', 'evelyn.richardson8@baltimore.example.com', '555-4008', 'Janitor', 31000.00, '2021-09-04', 'https://example.com/avatars/evelyn8.jpg'),
                                                                                                         ('Benjamin', 'Cox', 'benjamin.cox9@baltimore.example.com', '555-4009', 'IT Support', 51000.00, '2015-05-08', 'https://example.com/avatars/benjamin9.jpg'),
                                                                                                         ('Sofia', 'Howard', 'sofia.howard10@baltimore.example.com', '555-4010', 'Customer Service', 34000.00, '2019-07-07', 'https://example.com/avatars/sofia10.jpg'),
                                                                                                         ('Jack', 'Ward', 'jack.ward11@baltimore.example.com', '555-4011', 'Logistics', 40000.00, '2018-01-01', 'https://example.com/avatars/jack11.jpg'),
                                                                                                         ('Madison', 'Torres', 'madison.torres12@baltimore.example.com', '555-4012', 'Marketing', 55000.00, '2020-03-20', 'https://example.com/avatars/madison12.jpg');

-- Insert Employees for Phoenix
INSERT INTO Employees (first_name, last_name, email, phone, position, salary, hire_date, avatar_url) VALUES
                                                                                                         ('Ella', 'Bennett', 'ella.bennett1@phoenix.example.com', '555-5001', 'Manager', 69000.00, '2022-05-15', 'https://example.com/avatars/ella1.jpg'),
                                                                                                         ('Lucas', 'Turner', 'lucas.turner2@phoenix.example.com', '555-5002', 'Sales Associate', 44000.00, '2021-01-18', 'https://example.com/avatars/lucas2.jpg'),
                                                                                                         ('Mason', 'Coleman', 'mason.coleman3@phoenix.example.com', '555-5003', 'Cashier', 34000.00, '2020-11-14', 'https://example.com/avatars/mason3.jpg'),
                                                                                                         ('Ethan', 'Foster', 'ethan.foster4@phoenix.example.com', '555-5004', 'Stock Clerk', 36000.00, '2019-09-13', 'https://example.com/avatars/ethan4.jpg'),
                                                                                                         ('Chloe', 'Perez', 'chloe.perez5@phoenix.example.com', '555-5005', 'Security', 39000.00, '2018-10-15', 'https://example.com/avatars/chloe5.jpg'),
                                                                                                         ('Sophia', 'Ross', 'sophia.ross6@phoenix.example.com', '555-5006', 'HR Specialist', 49000.00, '2017-06-14', 'https://example.com/avatars/sophia6.jpg'),
                                                                                                         ('Jackson', 'Powell', 'jackson.powell7@phoenix.example.com', '555-5007', 'Assistant Manager', 59000.00, '2016-11-11', 'https://example.com/avatars/jackson7.jpg'),
                                                                                                         ('Aiden', 'Hayes', 'aiden.hayes8@phoenix.example.com', '555-5008', 'Janitor', 32000.00, '2021-08-03', 'https://example.com/avatars/aiden8.jpg'),
                                                                                                         ('Amelia', 'Cooper', 'amelia.cooper9@phoenix.example.com', '555-5009', 'IT Support', 52000.00, '2015-04-09', 'https://example.com/avatars/amelia9.jpg'),
                                                                                                         ('Oliver', 'Butler', 'oliver.butler10@phoenix.example.com', '555-5010', 'Customer Service', 35000.00, '2019-06-06', 'https://example.com/avatars/oliver10.jpg'),
                                                                                                         ('James', 'Bell', 'james.bell11@phoenix.example.com', '555-5011', 'Logistics', 41000.00, '2018-01-15', 'https://example.com/avatars/james11.jpg'),
                                                                                                         ('Liam', 'Wood', 'liam.wood12@phoenix.example.com', '555-5012', 'Marketing', 56000.00, '2020-04-19', 'https://example.com/avatars/liam12.jpg');

-- Insert Employees for New Orleans
INSERT INTO Employees (first_name, last_name, email, phone, position, salary, hire_date, avatar_url) VALUES
                                                                                                         ('Mia', 'Reed', 'mia.reed1@neworleans.example.com', '555-6001', 'Manager', 70000.00, '2022-06-15', 'https://example.com/avatars/mia1.jpg'),
                                                                                                         ('Charlotte', 'Carter', 'charlotte.carter2@neworleans.example.com', '555-6002', 'Sales Associate', 45000.00, '2021-01-17', 'https://example.com/avatars/charlotte2.jpg'),
                                                                                                         ('Benjamin', 'Howard', 'benjamin.howard3@neworleans.example.com', '555-6003', 'Cashier', 35000.00, '2020-10-16', 'https://example.com/avatars/benjamin3.jpg'),
                                                                                                         ('Elijah', 'Young', 'elijah.young4@neworleans.example.com', '555-6004', 'Stock Clerk', 37000.00, '2019-08-14', 'https://example.com/avatars/elijah4.jpg'),
                                                                                                         ('Isabella', 'King', 'isabella.king5@neworleans.example.com', '555-6005', 'Security', 40000.00, '2018-09-16', 'https://example.com/avatars/isabella5.jpg'),
                                                                                                         ('Jackson', 'Wright', 'jackson.wright6@neworleans.example.com', '555-6006', 'HR Specialist', 50000.00, '2017-07-15', 'https://example.com/avatars/jackson6.jpg'),
                                                                                                         ('Oliver', 'Lopez', 'oliver.lopez7@neworleans.example.com', '555-6007', 'Assistant Manager', 60000.00, '2016-12-12', 'https://example.com/avatars/oliver7.jpg'),
                                                                                                         ('Sophia', 'Hill', 'sophia.hill8@neworleans.example.com', '555-6008', 'Janitor', 33000.00, '2021-07-02', 'https://example.com/avatars/sophia8.jpg'),
                                                                                                         ('Avery', 'Scott', 'avery.scott9@neworleans.example.com', '555-6009', 'IT Support', 53000.00, '2015-03-10', 'https://example.com/avatars/avery9.jpg'),
                                                                                                         ('Lucas', 'Green', 'lucas.green10@neworleans.example.com', '555-6010', 'Customer Service', 36000.00, '2019-05-05', 'https://example.com/avatars/lucas10.jpg'),
                                                                                                         ('William', 'Adams', 'william.adams11@neworleans.example.com', '555-6011', 'Logistics', 42000.00, '2018-02-14', 'https://example.com/avatars/william11.jpg'),
                                                                                                         ('James', 'Nelson', 'james.nelson12@neworleans.example.com', '555-6012', 'Marketing', 57000.00, '2020-03-18', 'https://example.com/avatars/james12.jpg');
-- Store Locations Table
CREATE TABLE StoreLocations (
                                location_id INT AUTO_INCREMENT PRIMARY KEY,
                                name VARCHAR(255) NOT NULL,
                                address VARCHAR(255) NOT NULL,
                                city VARCHAR(100),
                                state VARCHAR(100),
                                zip_code VARCHAR(10),
                                phone VARCHAR(20),
                                manager_id INT,
                                FOREIGN KEY (manager_id) REFERENCES Employees(employee_id)
);
-- Insert Store Locations for Detroit
INSERT INTO StoreLocations (name, address, city, state, zip_code, phone, manager_id) VALUES
                                                                                         ('Detroit Store 1', '123 Main St', 'Detroit', 'MI', '48201', '555-0101', 1),
                                                                                         ('Detroit Store 2', '456 Elm St', 'Detroit', 'MI', '48202', '555-0102', 2),
                                                                                         ('Detroit Store 3', '789 Oak St', 'Detroit', 'MI', '48203', '555-0103', 3),
                                                                                         ('Detroit Store 4', '101 Pine St', 'Detroit', 'MI', '48204', '555-0104', 4),
                                                                                         ('Detroit Store 5', '202 Cedar Ave', 'Detroit', 'MI', '48205', '555-0105', 5),
                                                                                         ('Detroit Store 6', '303 Birch Blvd', 'Detroit', 'MI', '48206', '555-0106', 6),
                                                                                         ('Detroit Store 7', '404 Maple Rd', 'Detroit', 'MI', '48207', '555-0107', 7),
                                                                                         ('Detroit Store 8', '505 Walnut Ln', 'Detroit', 'MI', '48208', '555-0108', 8);

-- Insert Store Locations for Pittsburgh
INSERT INTO StoreLocations (name, address, city, state, zip_code, phone, manager_id) VALUES
                                                                                         ('Pittsburgh Store 1', '606 Sycamore St', 'Pittsburgh', 'PA', '15201', '555-0201', 9),
                                                                                         ('Pittsburgh Store 2', '707 Aspen Dr', 'Pittsburgh', 'PA', '15202', '555-0202', 10),
                                                                                         ('Pittsburgh Store 3', '808 Willow Ln', 'Pittsburgh', 'PA', '15203', '555-0203', 11),
                                                                                         ('Pittsburgh Store 4', '909 Poplar Ave', 'Pittsburgh', 'PA', '15204', '555-0204', 12),
                                                                                         ('Pittsburgh Store 5', '1010 Oak St', 'Pittsburgh', 'PA', '15205', '555-0205', 13),
                                                                                         ('Pittsburgh Store 6', '1111 Spruce Rd', 'Pittsburgh', 'PA', '15206', '555-0206', 14),
                                                                                         ('Pittsburgh Store 7', '1212 Cedar Blvd', 'Pittsburgh', 'PA', '15207', '555-0207', 15),
                                                                                         ('Pittsburgh Store 8', '1313 Chestnut St', 'Pittsburgh', 'PA', '15208', '555-0208', 16);

-- Insert Store Locations for San Diego
INSERT INTO StoreLocations (name, address, city, state, zip_code, phone, manager_id) VALUES
                                                                                         ('San Diego Store 1', '1414 Cypress Ave', 'San Diego', 'CA', '92101', '555-0301', 17),
                                                                                         ('San Diego Store 2', '1515 Palm Blvd', 'San Diego', 'CA', '92102', '555-0302', 18),
                                                                                         ('San Diego Store 3', '1616 Fir Ln', 'San Diego', 'CA', '92103', '555-0303', 19),
                                                                                         ('San Diego Store 4', '1717 Redwood Rd', 'San Diego', 'CA', '92104', '555-0304', 20),
                                                                                         ('San Diego Store 5', '1818 Sequoia St', 'San Diego', 'CA', '92105', '555-0305', 21),
                                                                                         ('San Diego Store 6', '1919 Alder Ave', 'San Diego', 'CA', '92106', '555-0306', 22),
                                                                                         ('San Diego Store 7', '2020 Holly Blvd', 'San Diego', 'CA', '92107', '555-0307', 23),
                                                                                         ('San Diego Store 8', '2121 Juniper Ln', 'San Diego', 'CA', '92108', '555-0308', 24);

-- Insert Store Locations for Baltimore
INSERT INTO StoreLocations (name, address, city, state, zip_code, phone, manager_id) VALUES
                                                                                         ('Baltimore Store 1', '2222 Locust St', 'Baltimore', 'MD', '21201', '555-0401', 25),
                                                                                         ('Baltimore Store 2', '2323 Cherry Ave', 'Baltimore', 'MD', '21202', '555-0402', 26),
                                                                                         ('Baltimore Store 3', '2424 Peach Blvd', 'Baltimore', 'MD', '21203', '555-0403', 27),
                                                                                         ('Baltimore Store 4', '2525 Magnolia Rd', 'Baltimore', 'MD', '21204', '555-0404', 28),
                                                                                         ('Baltimore Store 5', '2626 Dogwood Ln', 'Baltimore', 'MD', '21205', '555-0405', 29),
                                                                                         ('Baltimore Store 6', '2727 Maple Ave', 'Baltimore', 'MD', '21206', '555-0406', 30),
                                                                                         ('Baltimore Store 7', '2828 Ash St', 'Baltimore', 'MD', '21207', '555-0407', 31),
                                                                                         ('Baltimore Store 8', '2929 Elm Blvd', 'Baltimore', 'MD', '21208', '555-0408', 32);

-- Insert Store Locations for Phoenix
INSERT INTO StoreLocations (name, address, city, state, zip_code, phone, manager_id) VALUES
                                                                                         ('Phoenix Store 1', '3030 Pine St', 'Phoenix', 'AZ', '85001', '555-0501', 33),
                                                                                         ('Phoenix Store 2', '3131 Ash Ave', 'Phoenix', 'AZ', '85002', '555-0502', 34),
                                                                                         ('Phoenix Store 3', '3232 Cedar Blvd', 'Phoenix', 'AZ', '85003', '555-0503', 35),
                                                                                         ('Phoenix Store 4', '3333 Birch Ln', 'Phoenix', 'AZ', '85004', '555-0504', 36),
                                                                                         ('Phoenix Store 5', '3434 Fir Rd', 'Phoenix', 'AZ', '85005', '555-0505', 37),
                                                                                         ('Phoenix Store 6', '3535 Elm Ave', 'Phoenix', 'AZ', '85006', '555-0506', 38),
                                                                                         ('Phoenix Store 7', '3636 Oak St', 'Phoenix', 'AZ', '85007', '555-0507', 39),
                                                                                         ('Phoenix Store 8', '3737 Palm Blvd', 'Phoenix', 'AZ', '85008', '555-0508', 40);

-- Insert Store Locations for New Orleans
INSERT INTO StoreLocations (name, address, city, state, zip_code, phone, manager_id) VALUES
                                                                                         ('New Orleans Store 1', '3838 Pine Ave', 'New Orleans', 'LA', '70112', '555-0601', 41),
                                                                                         ('New Orleans Store 2', '3939 Cedar Blvd', 'New Orleans', 'LA', '70113', '555-0602', 42),
                                                                                         ('New Orleans Store 3', '4040 Birch Ln', 'New Orleans', 'LA', '70114', '555-0603', 43),
                                                                                         ('New Orleans Store 4', '4141 Fir Rd', 'New Orleans', 'LA', '70115', '555-0604', 44),
                                                                                         ('New Orleans Store 5', '4242 Elm Ave', 'New Orleans', 'LA', '70116', '555-0605', 45),
                                                                                         ('New Orleans Store 6', '4343 Oak Blvd', 'New Orleans', 'LA', '70117', '555-0606', 46),
                                                                                         ('New Orleans Store 7', '4444 Palm St', 'New Orleans', 'LA', '70118', '555-0607', 47),
                                                                                         ('New Orleans Store 8', '4545 Pine Ln', 'New Orleans', 'LA', '70119', '555-0608', 48);
-- Orders Table
CREATE TABLE Orders (
                        order_id INT AUTO_INCREMENT PRIMARY KEY,
                        user_id INT,
                        order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                        status VARCHAR(50) DEFAULT 'Pending',
                        total DECIMAL(10, 2) NOT NULL,
                        store_id INT,
                        FOREIGN KEY (user_id) REFERENCES Users(user_id),
                        FOREIGN KEY (store_id) REFERENCES StoreLocations(location_id)
);
-- Insert 50 Orders distributed across 12 months
INSERT INTO Orders (user_id, order_date, status, total, store_id) VALUES
-- January Orders
(1, '2023-01-05 10:15:30', 'Completed', 150.00, 1),
(2, '2023-01-15 12:20:45', 'Shipped', 200.00, 2),
(3, '2023-01-25 14:30:55', 'Pending', 120.00, 3),
(4, '2023-01-10 11:10:20', 'Completed', 180.00, 4),

-- February Orders
(5, '2023-02-05 16:45:10', 'Canceled', 0.00, 5),
(6, '2023-02-20 13:55:40', 'Completed', 300.00, 6),
(7, '2023-02-11 09:25:15', 'Pending', 250.00, 7),
(8, '2023-02-22 11:35:50', 'Completed', 400.00, 8),

-- March Orders
(9, '2023-03-03 15:40:25', 'Shipped', 150.00, 9),
(10, '2023-03-14 10:50:35', 'Completed', 175.00, 10),
(1, '2023-03-24 17:25:20', 'Completed', 220.00, 11),
(2, '2023-03-30 12:15:45', 'Pending', 90.00, 12),

-- April Orders
(3, '2023-04-05 14:05:30', 'Completed', 310.00, 13),
(4, '2023-04-16 15:15:10', 'Shipped', 125.00, 14),
(5, '2023-04-26 18:20:55', 'Completed', 500.00, 15),
(6, '2023-04-09 09:45:25', 'Pending', 160.00, 16),

-- May Orders
(7, '2023-05-17 14:30:40', 'Completed', 270.00, 17),
(8, '2023-05-27 11:50:15', 'Completed', 350.00, 18),
(9, '2023-05-12 12:40:50', 'Pending', 200.00, 19),
(10, '2023-05-22 16:00:05', 'Completed', 450.00, 20),

-- June Orders
(1, '2023-06-03 13:55:30', 'Shipped', 175.00, 21),
(2, '2023-06-14 11:20:45', 'Completed', 90.00, 22),
(3, '2023-06-24 15:35:20', 'Completed', 320.00, 23),
(4, '2023-06-30 10:45:10', 'Pending', 260.00, 24),

-- July Orders
(5, '2023-07-05 09:50:35', 'Shipped', 150.00, 25),
(6, '2023-07-16 14:55:15', 'Completed', 380.00, 26),
(7, '2023-07-30 17:10:40', 'Completed', 110.00, 27),
(8, '2023-07-11 10:25:55', 'Pending', 140.00, 28),

-- August Orders
(9, '2023-08-21 11:35:05', 'Completed', 210.00, 29),
(10, '2023-08-31 16:45:15', 'Completed', 330.00, 30),
(1, '2023-08-01 12:10:25', 'Shipped', 250.00, 31),
(2, '2023-08-15 15:20:50', 'Completed', 390.00, 32),

-- September Orders
(3, '2023-09-05 09:55:35', 'Pending', 130.00, 33),
(4, '2023-09-20 11:15:40', 'Completed', 470.00, 34),
(5, '2023-09-30 13:30:15', 'Shipped', 180.00, 35),
(6, '2023-09-12 17:45:05', 'Completed', 220.00, 36),

-- October Orders
(7, '2023-10-03 16:55:10', 'Completed', 510.00, 37),
(8, '2023-10-14 12:40:50', 'Pending', 200.00, 38),
(9, '2023-10-24 13:55:30', 'Shipped', 175.00, 39),
(10, '2023-10-30 11:20:45', 'Completed', 90.00, 40),

-- November Orders
(1, '2023-11-05 15:35:20', 'Completed', 320.00, 41),
(2, '2023-11-16 10:45:10', 'Pending', 260.00, 42),
(3, '2023-11-28 09:50:35', 'Shipped', 150.00, 43),
(4, '2023-11-12 14:55:15', 'Completed', 380.00, 44),

-- December Orders
(5, '2023-12-03 17:10:40', 'Completed', 110.00, 45),
(6, '2023-12-14 10:25:55', 'Pending', 140.00, 46),
(7, '2023-12-26 11:35:05', 'Completed', 210.00, 47),
(8, '2023-12-17 16:45:15', 'Completed', 330.00, 48);

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
-- Insert Order Details for each Order
INSERT INTO OrderDetails (order_id, product_id, quantity, price) VALUES(4, 6, 2, 90.00);
INSERT INTO OrderDetails (order_id, product_id, quantity, price) VALUES(5, 7, 5, 40.00);
INSERT INTO OrderDetails (order_id, product_id, quantity, price) VALUES(6, 8, 3, 100.00);
INSERT INTO OrderDetails (order_id, product_id, quantity, price) VALUES(7, 9, 1, 250.00); -- Order 7, Product 9
INSERT INTO OrderDetails (order_id, product_id, quantity, price) VALUES(8, 10, 4, 100.00); -- Order 8, Product 10
INSERT INTO OrderDetails (order_id, product_id, quantity, price) VALUES(9, 11, 2, 75.00); -- Order 9, Product 11
INSERT INTO OrderDetails (order_id, product_id, quantity, price) VALUES(10, 12, 1, 175.00); -- Order 10, Product 12
INSERT INTO OrderDetails (order_id, product_id, quantity, price) VALUES(11, 13, 3, 73.33); -- Order 11, Product 13
INSERT INTO OrderDetails (order_id, product_id, quantity, price) VALUES(12, 14, 1, 90.00); -- Order 12, Product 14
INSERT INTO OrderDetails (order_id, product_id, quantity, price) VALUES(13, 15, 5, 62.00); -- Order 13, Product 15
INSERT INTO OrderDetails (order_id, product_id, quantity, price) VALUES(14, 16, 1, 125.00); -- Order 14, Product 16
INSERT INTO OrderDetails (order_id, product_id, quantity, price) VALUES(15, 17, 2, 250.00); -- Order 15, Product 17
INSERT INTO OrderDetails (order_id, product_id, quantity, price) VALUES(16, 18, 4, 40.00); -- Order 16, Product 18
INSERT INTO OrderDetails (order_id, product_id, quantity, price) VALUES(17, 19, 3, 90.00); -- Order 17, Product 19
INSERT INTO OrderDetails (order_id, product_id, quantity, price) VALUES(18, 20, 1, 350.00); -- Order 18, Product 20
INSERT INTO OrderDetails (order_id, product_id, quantity, price) VALUES(19, 21, 2, 100.00); -- Order 19, Product 21
INSERT INTO OrderDetails (order_id, product_id, quantity, price) VALUES(20, 22, 2, 225.00); -- Order 20, Product 22
INSERT INTO OrderDetails (order_id, product_id, quantity, price) VALUES(21, 23, 1, 175.00); -- Order 21, Product 23
INSERT INTO OrderDetails (order_id, product_id, quantity, price) VALUES(22, 24, 1, 90.00); -- Order 22, Product 24
INSERT INTO OrderDetails (order_id, product_id, quantity, price) VALUES(23, 25, 4, 80.00); -- Order 23, Product 25
INSERT INTO OrderDetails (order_id, product_id, quantity, price) VALUES(24, 26, 2, 130.00); -- Order 24, Product 26
INSERT INTO OrderDetails (order_id, product_id, quantity, price) VALUES(25, 27, 3, 50.00); -- Order 25, Product 27
INSERT INTO OrderDetails (order_id, product_id, quantity, price) VALUES(26, 28, 1, 380.00); -- Order 26, Product 28
INSERT INTO OrderDetails (order_id, product_id, quantity, price) VALUES(27, 29, 1, 110.00); -- Order 27, Product 29
INSERT INTO OrderDetails (order_id, product_id, quantity, price) VALUES(28, 30, 1, 140.00); -- Order 28, Product 30
INSERT INTO OrderDetails (order_id, product_id, quantity, price) VALUES(29, 31, 2, 105.00); -- Order 29, Product 31
INSERT INTO OrderDetails (order_id, product_id, quantity, price) VALUES(30, 32, 1, 330.00); -- Order 30, Product 32
INSERT INTO OrderDetails (order_id, product_id, quantity, price) VALUES(31, 33, 1, 250.00); -- Order 31, Product 33
INSERT INTO OrderDetails (order_id, product_id, quantity, price) VALUES(32, 34, 2, 195.00); -- Order 32, Product 34
INSERT INTO OrderDetails (order_id, product_id, quantity, price) VALUES(33, 35, 2, 65.00); -- Order 33, Product 35
INSERT INTO OrderDetails (order_id, product_id, quantity, price) VALUES(34, 36, 1, 470.00); -- Order 34, Product 36
INSERT INTO OrderDetails (order_id, product_id, quantity, price) VALUES(35, 37, 2, 90.00); -- Order 35, Product 37
INSERT INTO OrderDetails (order_id, product_id, quantity, price) VALUES(36, 38, 1, 220.00); -- Order 36, Product 38
INSERT INTO OrderDetails (order_id, product_id, quantity, price) VALUES(37, 39, 3, 170.00); -- Order 37, Product 39
INSERT INTO OrderDetails (order_id, product_id, quantity, price) VALUES(38, 40, 1, 200.00); -- Order 38, Product 40
INSERT INTO OrderDetails (order_id, product_id, quantity, price) VALUES(39, 41, 2, 87.50); -- Order 39, Product 41
INSERT INTO OrderDetails (order_id, product_id, quantity, price) VALUES(40, 42, 1, 90.00); -- Order 40, Product 42
INSERT INTO OrderDetails (order_id, product_id, quantity, price) VALUES(41, 43, 4, 80.00); -- Order 41, Product 43
INSERT INTO OrderDetails (order_id, product_id, quantity, price) VALUES(42, 44, 2, 190.00); -- Order 42, Product 44
INSERT INTO OrderDetails (order_id, product_id, quantity, price) VALUES(43, 45, 2, 75.00); -- Order 43, Product 45
INSERT INTO OrderDetails (order_id, product_id, quantity, price) VALUES(44, 46, 1, 380.00); -- Order 44, Product 46
INSERT INTO OrderDetails (order_id, product_id, quantity, price) VALUES(45, 47, 1, 110.00); -- Order 45, Product 47
INSERT INTO OrderDetails (order_id, product_id, quantity, price) VALUES(46, 48, 2, 70.00); -- Order 46, Product 48
INSERT INTO OrderDetails (order_id, product_id, quantity, price) VALUES(47, 1, 1, 210.00); -- Order 47, Product 1
INSERT INTO OrderDetails (order_id, product_id, quantity, price) VALUES(48, 2, 1, 330.00); -- Order 48, Product 2


-- Inventory Table
CREATE TABLE Inventory (
                           product_id INT,
                           location_id INT,
                           quantity_in_stock INT NOT NULL,
                           last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                           PRIMARY KEY (product_id, location_id),
                           FOREIGN KEY (product_id) REFERENCES Products(product_id),
                           FOREIGN KEY (location_id) REFERENCES StoreLocations(location_id)
);
-- Insert Inventory Data for each Product across 48 Locations
INSERT INTO Inventory (product_id, location_id, quantity_in_stock) VALUES
                                                                       (1, 1, 100),  -- Product 1 at Location 1
                                                                       (1, 2, 150),  -- Product 1 at Location 2
                                                                       (1, 3, 200),  -- Product 1 at Location 3
                                                                       (1, 48, 120), -- Product 1 at Location 48
                                                                       (2, 1, 95),   -- Product 2 at Location 1
                                                                       (2, 2, 110),  -- Product 2 at Location 2
                                                                       (2, 48, 85),  -- Product 2 at Location 48
                                                                       (3, 1, 130),  -- Product 3 at Location 1
                                                                       (3, 48, 105), -- Product 3 at Location 48
                                                                       (48, 1, 140), -- Product 48 at Location 1
                                                                       (48, 48, 115); -- Product 48 at Location 48

-- Shipping Details Table
CREATE TABLE ShippingDetails (
                                 shipping_id INT AUTO_INCREMENT PRIMARY KEY,
                                 order_id INT,
                                 address VARCHAR(255) NOT NULL,
                                 city VARCHAR(100) NOT NULL,
                                 state VARCHAR(100) NOT NULL,
                                 zip_code VARCHAR(10) NOT NULL,
                                 shipping_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                                 carrier VARCHAR(100),
                                 tracking_number VARCHAR(100),
                                 FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- Insert Shipping Details for each Order
INSERT INTO ShippingDetails (order_id, address, city, state, zip_code, shipping_date, carrier, tracking_number) VALUES
                                                                                                                    (1, '123 Elm St', 'Detroit', 'MI', '48201', '2023-01-05 10:15:30', 'FedEx', 'TRK1234567891'),
                                                                                                                    (2, '456 Maple Ave', 'Pittsburgh', 'PA', '15201', '2023-01-15 12:20:45', 'UPS', 'TRK1234567892'),
                                                                                                                    (3, '789 Oak St', 'San Diego', 'CA', '92101', '2023-01-25 14:30:55', 'USPS', 'TRK1234567893'),
                                                                                                                    (4, '101 Pine St', 'Baltimore', 'MD', '21201', '2023-01-10 11:10:20', 'DHL', 'TRK1234567894'),
                                                                                                                    (5, '202 Cedar Ave', 'Phoenix', 'AZ', '85001', '2023-02-05 16:45:10', 'FedEx', 'TRK1234567895'),
                                                                                                                    (6, '303 Birch Blvd', 'New Orleans', 'LA', '70112', '2023-02-20 13:55:40', 'UPS', 'TRK1234567896'),
                                                                                                                    (7, '404 Walnut Ln', 'Detroit', 'MI', '48202', '2023-02-11 09:25:15', 'USPS', 'TRK1234567897'),
                                                                                                                    (8, '505 Chestnut St', 'Pittsburgh', 'PA', '15202', '2023-02-22 11:35:50', 'DHL', 'TRK1234567898'),
                                                                                                                    (9, '606 Sycamore Ln', 'San Diego', 'CA', '92102', '2023-03-03 15:40:25', 'FedEx', 'TRK1234567899'),
                                                                                                                    (10, '707 Aspen Dr', 'Baltimore', 'MD', '21202', '2023-03-14 10:50:35', 'UPS', 'TRK12345678910'),
                                                                                                                    (11, '808 Willow St', 'Phoenix', 'AZ', '85002', '2023-03-24 17:25:20', 'USPS', 'TRK12345678911'),
                                                                                                                    (12, '909 Poplar Ave', 'New Orleans', 'LA', '70113', '2023-03-30 12:15:45', 'DHL', 'TRK12345678912'),
                                                                                                                    (13, '1010 Oak St', 'Detroit', 'MI', '48203', '2023-04-05 14:05:30', 'FedEx', 'TRK12345678913'),
                                                                                                                    (14, '1111 Spruce Rd', 'Pittsburgh', 'PA', '15203', '2023-04-16 15:15:10', 'UPS', 'TRK12345678914'),
                                                                                                                    (15, '1212 Cedar Blvd', 'San Diego', 'CA', '92103', '2023-04-26 18:20:55', 'USPS', 'TRK12345678915'),
                                                                                                                    (16, '1313 Chestnut St', 'Baltimore', 'MD', '21203', '2023-04-09 09:45:25', 'DHL', 'TRK12345678916'),
                                                                                                                    (17, '1414 Cypress Ave', 'Phoenix', 'AZ', '85003', '2023-05-17 14:30:40', 'FedEx', 'TRK12345678917'),
                                                                                                                    (18, '1515 Palm Blvd', 'New Orleans', 'LA', '70114', '2023-05-27 11:50:15', 'UPS', 'TRK12345678918'),
                                                                                                                    (19, '1616 Fir Ln', 'Detroit', 'MI', '48204', '2023-05-12 12:40:50', 'USPS', 'TRK12345678919'),
                                                                                                                    (20, '1717 Redwood Rd', 'Pittsburgh', 'PA', '15204', '2023-05-22 16:00:05', 'DHL', 'TRK12345678920'),
                                                                                                                    (21, '1818 Sequoia St', 'San Diego', 'CA', '92104', '2023-06-03 13:55:30', 'FedEx', 'TRK12345678921'),
                                                                                                                    (22, '1919 Alder Ave', 'Baltimore', 'MD', '21204', '2023-06-14 11:20:45', 'UPS', 'TRK12345678922'),
                                                                                                                    (23, '2020 Holly Blvd', 'Phoenix', 'AZ', '85004', '2023-06-24 15:35:20', 'USPS', 'TRK12345678923'),
                                                                                                                    (24, '2121 Juniper Ln', 'New Orleans', 'LA', '70115', '2023-06-30 10:45:10', 'DHL', 'TRK12345678924'),
                                                                                                                    (25, '2222 Locust St', 'Detroit', 'MI', '48205', '2023-07-05 09:50:35', 'FedEx', 'TRK12345678925'),
                                                                                                                    (26, '2323 Cherry Ave', 'Pittsburgh', 'PA', '15205', '2023-07-16 14:55:15', 'UPS', 'TRK12345678926'),
                                                                                                                    (27, '2424 Peach Blvd', 'San Diego', 'CA', '92105', '2023-07-30 17:10:40', 'USPS', 'TRK12345678927'),
                                                                                                                    (28, '2525 Magnolia Rd', 'Baltimore', 'MD', '21205', '2023-07-11 10:25:55', 'DHL', 'TRK12345678928'),
                                                                                                                    (29, '2626 Dogwood Ln', 'Phoenix', 'AZ', '85005', '2023-08-21 11:35:05', 'FedEx', 'TRK12345678929'),
                                                                                                                    (30, '2727 Maple Ave', 'New Orleans', 'LA', '70116', '2023-08-31 16:45:15', 'UPS', 'TRK12345678930'),
                                                                                                                    (31, '2828 Ash St', 'Detroit', 'MI', '48206', '2023-08-01 12:10:25', 'USPS', 'TRK12345678931'),
                                                                                                                    (32, '2929 Elm Blvd', 'Pittsburgh', 'PA', '15206', '2023-08-15 15:20:50', 'DHL', 'TRK12345678932'),
                                                                                                                    (33, '3030 Pine St', 'San Diego', 'CA', '92106', '2023-09-05 09:55:35', 'FedEx', 'TRK12345678933'),
                                                                                                                    (34, '3131 Ash Ave', 'Baltimore', 'MD', '21206', '2023-09-20 11:15:40', 'UPS', 'TRK12345678934'),
                                                                                                                    (35, '3232 Cedar Blvd', 'Phoenix', 'AZ', '85006', '2023-09-30 13:30:15', 'USPS', 'TRK12345678935'),
                                                                                                                    (36, '3333 Birch Ln', 'New Orleans', 'LA', '70117', '2023-09-12 17:45:05', 'DHL', 'TRK12345678936'),
                                                                                                                    (37, '3434 Fir Rd', 'Detroit', 'MI', '48207', '2023-10-03 16:55:10', 'FedEx', 'TRK12345678937'),
                                                                                                                    (38, '3535 Elm Ave', 'Pittsburgh', 'PA', '15207', '2023-10-14 12:40:50', 'UPS', 'TRK12345678938'),
                                                                                                                    (39, '3636 Oak St', 'San Diego', 'CA', '92107', '2023-10-24 13:55:30', 'USPS', 'TRK12345678939'),
                                                                                                                    (40, '3737 Palm Blvd', 'Baltimore', 'MD', '21207', '2023-10-30 11:20:45', 'DHL', 'TRK12345678940'),
                                                                                                                    (41, '3838 Pine Ave', 'Phoenix', 'AZ', '85007', '2023-11-05 15:35:20', 'FedEx', 'TRK12345678941'),
                                                                                                                    (42, '3939 Cedar Blvd', 'New Orleans', 'LA', '70118', '2023-11-16 10:45:10', 'UPS', 'TRK12345678942'),
                                                                                                                    (43, '4040 Birch Ln', 'Detroit', 'MI', '48208', '2023-11-28 09:50:35', 'USPS', 'TRK12345678943'),
                                                                                                                    (44, '4141 Fir Rd', 'Pittsburgh', 'PA', '15208', '2023-11-12 14:55:15', 'DHL', 'TRK12345678944'),
                                                                                                                    (45, '4242 Elm Ave', 'San Diego', 'CA', '92108', '2023-12-03 17:10:40', 'FedEx', 'TRK12345678945'),
                                                                                                                    (46, '4343 Oak Blvd', 'Baltimore', 'MD', '21208', '2023-12-14 10:25:55', 'UPS', 'TRK12345678946'),
                                                                                                                    (47, '4444 Palm St', 'Phoenix', 'AZ', '85008', '2023-12-26 11:35:05', 'USPS', 'TRK12345678947'),
                                                                                                                    (48, '4545 Pine Ln', 'New Orleans', 'LA', '70119', '2023-12-17 16:45:15', 'DHL', 'TRK12345678948');
-- Expense Categories Table
CREATE TABLE ExpenseCategories (
                                   category_id INT AUTO_INCREMENT PRIMARY KEY,
                                   name VARCHAR(100) NOT NULL UNIQUE,
                                   description TEXT
);

-- Insert Expense Categories
INSERT INTO ExpenseCategories (name, description) VALUES
                                                      ('Rent', 'Expenses related to the rental of office or store space.'),
                                                      ('Utilities', 'Expenses for electricity, water, gas, and other utilities.'),
                                                      ('Salaries', 'Expenses for employee wages and salaries.'),
                                                      ('Marketing', 'Expenses for advertising and promotional activities.'),
                                                      ('Office Supplies', 'Expenses for office materials like paper, pens, and other supplies.'),
                                                      ('Travel', 'Expenses related to business travel, including transportation and lodging.'),
                                                      ('Maintenance', 'Expenses for the maintenance and repair of equipment and facilities.'),
                                                      ('Insurance', 'Expenses for various types of business insurance.'),
                                                      ('Training', 'Expenses for employee training and development programs.'),
                                                      ('IT Services', 'Expenses for IT support and services, including software and hardware.'),
                                                      ('Legal Fees', 'Expenses for legal consultations and services.'),
                                                      ('Consulting', 'Expenses for consulting services from external experts.'),
                                                      ('Miscellaneous', 'Expenses that do not fit into other categories.'),
                                                      ('Entertainment', 'Expenses for business-related entertainment and events.'),
                                                      ('Transportation', 'Expenses for transportation, including vehicle maintenance and fuel.');
-- Expenses Table
CREATE TABLE Expenses (
                          expense_id INT AUTO_INCREMENT PRIMARY KEY,
                          employee_id INT,
                          category_id INT,
                          amount DECIMAL(10, 2) NOT NULL,
                          expense_date DATE,
                          description VARCHAR(255),
                          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                          FOREIGN KEY (employee_id) REFERENCES Employees(employee_id),
                          FOREIGN KEY (category_id) REFERENCES ExpenseCategories(category_id)
);
-- Insert Synthetic Expenses
INSERT INTO Expenses (employee_id, category_id, amount, expense_date, description) VALUES
-- January Expenses
(1, 1, 1500.00, '2023-01-05', 'Monthly rent for office space'),
(2, 2, 300.00, '2023-01-10', 'Utility bills for office'),
(3, 3, 2500.00, '2023-01-15', 'Employee salaries'),
(4, 4, 500.00, '2023-01-20', 'Marketing campaign expenses'),

-- February Expenses
(5, 5, 100.00, '2023-02-05', 'Office supplies purchase'),
(6, 6, 800.00, '2023-02-12', 'Business travel expenses'),
(7, 7, 150.00, '2023-02-18', 'Equipment maintenance'),
(8, 8, 400.00, '2023-02-25', 'Business insurance premium'),

-- March Expenses
(9, 9, 300.00, '2023-03-03', 'Employee training program'),
(10, 10, 200.00, '2023-03-10', 'IT support services'),
(1, 11, 150.00, '2023-03-15', 'Legal consultation fees'),
(2, 12, 350.00, '2023-03-22', 'Consulting services'),

-- April Expenses
(3, 13, 50.00, '2023-04-01', 'Miscellaneous office expenses'),
(4, 14, 200.00, '2023-04-08', 'Business entertainment event'),
(5, 15, 150.00, '2023-04-16', 'Transportation costs'),

-- May Expenses
(6, 1, 1500.00, '2023-05-05', 'Monthly rent for office space'),
(7, 2, 310.00, '2023-05-10', 'Utility bills for office'),
(8, 3, 2550.00, '2023-05-15', 'Employee salaries'),
(9, 4, 600.00, '2023-05-20', 'Marketing campaign expenses'),

-- June Expenses
(10, 5, 120.00, '2023-06-05', 'Office supplies purchase'),
(1, 6, 850.00, '2023-06-12', 'Business travel expenses'),
(2, 7, 170.00, '2023-06-18', 'Equipment maintenance'),
(3, 8, 450.00, '2023-06-25', 'Business insurance premium'),

-- July Expenses
(4, 9, 320.00, '2023-07-03', 'Employee training program'),
(5, 10, 220.00, '2023-07-10', 'IT support services'),
(6, 11, 180.00, '2023-07-15', 'Legal consultation fees'),
(7, 12, 380.00, '2023-07-22', 'Consulting services'),

-- August Expenses
(8, 13, 60.00, '2023-08-01', 'Miscellaneous office expenses'),
(9, 14, 250.00, '2023-08-08', 'Business entertainment event'),
(10, 15, 180.00, '2023-08-16', 'Transportation costs'),

-- September Expenses
(1, 1, 1550.00, '2023-09-05', 'Monthly rent for office space'),
(2, 2, 320.00, '2023-09-10', 'Utility bills for office'),
(3, 3, 2600.00, '2023-09-15', 'Employee salaries'),
(4, 4, 550.00, '2023-09-20', 'Marketing campaign expenses'),

-- October Expenses
(5, 5, 130.00, '2023-10-05', 'Office supplies purchase'),
(6, 6, 900.00, '2023-10-12', 'Business travel expenses'),
(7, 7, 180.00, '2023-10-18', 'Equipment maintenance'),
(8, 8, 500.00, '2023-10-25', 'Business insurance premium'),

-- November Expenses
(9, 9, 340.00, '2023-11-03', 'Employee training program'),
(10, 10, 240.00, '2023-11-10', 'IT support services'),
(1, 11, 200.00, '2023-11-15', 'Legal consultation fees'),
(2, 12, 400.00, '2023-11-22', 'Consulting services'),

-- December Expenses
(3, 13, 70.00, '2023-12-01', 'Miscellaneous office expenses'),
(4, 14, 300.00, '2023-12-08', 'Business entertainment event'),
(5, 15, 200.00, '2023-12-16', 'Transportation costs');
-- API Keys Table
CREATE TABLE ApiKeys (
                         api_key_id INT AUTO_INCREMENT PRIMARY KEY,
                         user_id INT,
                         api_key VARCHAR(255) UNIQUE NOT NULL,
                         created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                         FOREIGN KEY (user_id) REFERENCES Users(user_id)
);
-- Created for Admin Users 1 and 2
INSERT INTO ApiKeys (user_id, api_key) VALUES
                                           (1, 'd41d8cd98f00b204e9800998ecf8427e'), -- Admin User 1
                                           (2, '098f6bcd4621d373cade4e832627b4f6'); -- Admin User 2
-- Create the Sales Table
CREATE TABLE Sales (
                       sale_id INT AUTO_INCREMENT PRIMARY KEY,
                       order_id INT,
                       product_id INT,
                       quantity INT NOT NULL,
                       sale_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                       total DECIMAL(10, 2) NOT NULL,
                       location_id INT,
                       FOREIGN KEY (order_id) REFERENCES Orders(order_id),
                       FOREIGN KEY (product_id) REFERENCES Products(product_id),
                       FOREIGN KEY (location_id) REFERENCES StoreLocations(location_id)
);
-- Insert Synthetic Sales Data
INSERT INTO Sales (order_id, product_id, quantity, sale_date, total, location_id) VALUES
-- January Sales
(1, 1, 2, '2023-01-05 10:15:30', 150.00, 1),
(2, 2, 3, '2023-01-15 12:20:45', 200.00, 2),
(3, 3, 1, '2023-01-25 14:30:55', 120.00, 3),
(4, 4, 4, '2023-01-10 11:10:20', 180.00, 4),

-- February Sales
(5, 5, 5, '2023-02-05 16:45:10', 0.00, 5), -- Canceled order
(6, 6, 2, '2023-02-20 13:55:40', 300.00, 6),
(7, 7, 6, '2023-02-11 09:25:15', 250.00, 7),
(8, 8, 3, '2023-02-22 11:35:50', 400.00, 8),

-- March Sales
(9, 9, 4, '2023-03-03 15:40:25', 150.00, 9),
(10, 10, 1, '2023-03-14 10:50:35', 175.00, 10),
(11, 11, 2, '2023-03-24 17:25:20', 220.00, 11),
(12, 12, 5, '2023-03-30 12:15:45', 90.00, 12),

-- April Sales
(13, 13, 6, '2023-04-05 14:05:30', 310.00, 13),
(14, 14, 3, '2023-04-16 15:15:10', 125.00, 14),
(15, 15, 7, '2023-04-26 18:20:55', 500.00, 15),
(16, 16, 4, '2023-04-09 09:45:25', 160.00, 16),

-- May Sales
(17, 17, 1, '2023-05-17 14:30:40', 270.00, 17),
(18, 18, 2, '2023-05-27 11:50:15', 350.00, 18),
(19, 19, 5, '2023-05-12 12:40:50', 200.00, 19),
(20, 20, 3, '2023-05-22 16:00:05', 450.00, 20),

-- June Sales
(21, 21, 6, '2023-06-03 13:55:30', 175.00, 21),
(22, 22, 7, '2023-06-14 11:20:45', 90.00, 22),
(23, 23, 1, '2023-06-24 15:35:20', 320.00, 23),
(24, 24, 2, '2023-06-30 10:45:10', 260.00, 24),

-- July Sales
(25, 25, 5, '2023-07-05 09:50:35', 150.00, 25),
(26, 26, 3, '2023-07-16 14:55:15', 380.00, 26),
(27, 27, 6, '2023-07-30 17:10:40', 110.00, 27),
(28, 28, 4, '2023-07-11 10:25:55', 140.00, 28),

-- August Sales
(29, 29, 1, '2023-08-21 11:35:05', 210.00, 29),
(30, 30, 2, '2023-08-31 16:45:15', 330.00, 30),
(31, 31, 5, '2023-08-01 12:10:25', 250.00, 31),
(32, 32, 3, '2023-08-15 15:20:50', 390.00, 32),

-- September Sales
(33, 33, 6, '2023-09-05 09:55:35', 130.00, 33),
(34, 34, 4, '2023-09-20 11:15:40', 470.00, 34),
(35, 35, 1, '2023-09-30 13:30:15', 180.00, 35),
(36, 36, 2, '2023-09-12 17:45:05', 220.00, 36),

-- October Sales
(37, 37, 5, '2023-10-03 16:55:10', 510.00, 37),
(38, 38, 3, '2023-10-14 12:40:50', 200.00, 38),
(39, 39, 6, '2023-10-24 13:55:30', 175.00, 39),
(40, 40, 4, '2023-10-30 11:20:45', 90.00, 40),

-- November Sales
(41, 41, 1, '2023-11-05 15:35:20', 320.00, 41),
(42, 42, 2, '2023-11-16 10:45:10', 260.00, 42),
(43, 43, 5, '2023-11-28 09:50:35', 150.00, 43),
(44, 44, 3, '2023-11-12 14:55:15', 380.00, 44),

-- December Sales
(45, 45, 6, '2023-12-03 17:10:40', 110.00, 45),
(46, 46, 4, '2023-12-14 10:25:55', 140.00, 46),
(47, 47, 1, '2023-12-26 11:35:05', 210.00, 47),
(48, 48, 2, '2023-12-17 16:45:15', 330.00, 48);