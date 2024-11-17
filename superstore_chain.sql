-- Create the database
DROP DATABASE IF EXISTS superstore_chain;
CREATE DATABASE superstore_chain;
USE superstore_chain;

-- Create tables
CREATE TABLE customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    email VARCHAR(255),
    phone VARCHAR(20),
    street VARCHAR(255),
    city VARCHAR(255),
    state VARCHAR(100),
    date_joined DATETIME
);

CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    status ENUM('Completed', 'Pending', 'Dispatched', 'Canceled'),
    shipped_date DATETIME,
    date_placed DATETIME
);

CREATE TABLE invoices (
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    amount_total INT,
    discount INT,
    status ENUM('Canceled', 'Pending', 'Paid'),
    date_generated DATETIME
);

CREATE TABLE invoice_payments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    invoice_id INT,
    account_id INT,
    payment_method ENUM('Cash', 'Transfer', 'Card', 'Cheque', 'Others'),
    amount INT,
    payment_date DATETIME
);

CREATE TABLE accounts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    account_number VARCHAR(50),
    account_name VARCHAR(255),
    bank VARCHAR(255),
    date_added DATETIME,
    status ENUM('Active', 'Inactive')
);

CREATE TABLE carts (
    order_id INT,
    product_id INT,
    quantity INT,
    amount INT,
    date_generated DATETIME,
    PRIMARY KEY (order_id, product_id)
);

CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT,
    brand_id INT,
    name VARCHAR(255),
    barcode BIGINT,
    cost_price INT,
    list_price INT,
    model_year YEAR
);

CREATE TABLE supplies (
    product_id INT,
    supplier_id INT,
    quantity INT,
    amount INT,
    supply_date DATETIME,
    PRIMARY KEY (product_id, supplier_id)
);

CREATE TABLE suppliers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    address VARCHAR(255),
    phone VARCHAR(20),
    email VARCHAR(255),
    manager VARCHAR(255)
);

CREATE TABLE stores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    manager_id INT,
    street VARCHAR(255),
    city VARCHAR(255),
    state VARCHAR(100)
);

CREATE TABLE inventory (
    product_id INT,
    store_id INT,
    quantity INT,
    date_stocked DATETIME,
    PRIMARY KEY (product_id, store_id)
);

CREATE TABLE categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255)
);

CREATE TABLE brands (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    country VARCHAR(255)
);

CREATE TABLE supply_payments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_id INT,
    account_id INT,
    amount_paid INT,
    payment_method ENUM('Cash', 'Transfer', 'Card', 'Cheque', 'Others'),
    payment_date DATETIME
);

CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    gender ENUM('Male', 'Female', 'Others'),
    role_id INT,
    store_id INT,
    email VARCHAR(255),
    phone VARCHAR(20),
    date_hired DATE,
    status ENUM('Active', 'Suspended', 'Terminated')
);

CREATE TABLE salaries (
    id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    salary INT,
    from_date DATE,
    to_date DATE
);

CREATE TABLE roles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    description VARCHAR(255)
);


ALTER TABLE orders ADD CONSTRAINT
Foreign Key (customer_id) REFERENCES customers(id)
ON UPDATE CASCADE ON DELETE CASCADE
;


ALTER TABLE invoices ADD CONSTRAINT
Foreign Key (order_id) REFERENCES orders(id)
ON UPDATE CASCADE ON DELETE CASCADE
;


ALTER TABLE invoice_payments 
ADD CONSTRAINT Foreign Key (invoice_id) REFERENCES invoices(id) 
ON UPDATE CASCADE ON DELETE CASCADE,
ADD CONSTRAINT Foreign Key (account_id) REFERENCES accounts(id) 
ON UPDATE CASCADE ON DELETE CASCADE;


ALTER TABLE carts
ADD CONSTRAINT Foreign Key (order_id) REFERENCES orders(id) 
ON UPDATE CASCADE ON DELETE CASCADE,
ADD CONSTRAINT Foreign Key (product_id) REFERENCES products(id)
ON UPDATE CASCADE ON DELETE CASCADE;


ALTER TABLE products
ADD CONSTRAINT Foreign Key (category_id) REFERENCES categories(id)
ON UPDATE CASCADE ON DELETE CASCADE,
ADD CONSTRAINT Foreign Key (brand_id) REFERENCES brands(id)
ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE supplies
ADD CONSTRAINT Foreign Key (product_id) REFERENCES products(id)
ON UPDATE CASCADE ON DELETE CASCADE,
ADD CONSTRAINT Foreign Key (supplier_id) REFERENCES suppliers(id)
ON UPDATE CASCADE ON DELETE CASCADE;


ALTER TABLE stores
ADD CONSTRAINT Foreign Key (manager_id) REFERENCES employees(id)
ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE inventory
ADD CONSTRAINT Foreign Key (product_id) REFERENCES products(id)
ON UPDATE CASCADE ON DELETE CASCADE,
ADD CONSTRAINT Foreign Key (store_id) REFERENCES stores(id)
ON UPDATE CASCADE ON DELETE CASCADE;


ALTER TABLE supply_payments 
ADD CONSTRAINT Foreign Key (supplier_id) REFERENCES suppliers(id)
ON UPDATE CASCADE ON DELETE CASCADE,
ADD CONSTRAINT Foreign Key (account_id) REFERENCES accounts(id)
ON UPDATE CASCADE ON DELETE CASCADE;


ALTER TABLE employees
ADD CONSTRAINT Foreign Key (role_id) REFERENCES roles(id)
ON UPDATE CASCADE ON DELETE CASCADE,
ADD CONSTRAINT Foreign Key (store_id) REFERENCES stores(id)
ON UPDATE CASCADE ON DELETE CASCADE;


ALTER TABLE salaries
ADD CONSTRAINT Foreign Key (employee_id) REFERENCES employees(id)
ON UPDATE CASCADE ON DELETE CASCADE;

