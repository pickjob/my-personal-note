DROP DATABASE IF EXISTS sample;
CREATE DATABASE sample DEFAULT CHARACTER SET utf8mb4;

USE sample;

-- Customers: customer’s data
-- Products: a list of scale model cars
-- ProductLines: a list of product line categories
-- Orders: sales orders placed by customers
-- OrderDetails: sales order line items for each sales order
-- Payments: payments made by customers based on their accounts
-- Employees: all employee information as well as the organization structure such as who reports to whom
-- Offices: sales office data

CREATE TABLE IF NOT EXISTS offices (
  office_code varchar(10) NOT NULL,
  city varchar(50) NOT NULL,
  phone varchar(50) NOT NULL,
  address_line1 varchar(50) NOT NULL,
  address_line2 varchar(50) DEFAULT NULL,
  state varchar(50) DEFAULT NULL,
  country varchar(50) NOT NULL,
  postal_code varchar(15) NOT NULL,
  territory varchar(10) NOT NULL,
  PRIMARY KEY (office_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS employees (
  employee_number int(11) NOT NULL,
  last_name varchar(50) NOT NULL,
  first_name varchar(50) NOT NULL,
  extension varchar(10) NOT NULL,
  email varchar(100) NOT NULL,
  office_code varchar(10) NOT NULL,
  reports_to int(11) DEFAULT NULL,
  job_title varchar(50) NOT NULL,
  PRIMARY KEY (employee_number),
  KEY reports_to (reports_to),
  KEY office_code (office_code),
  CONSTRAINT employees_ibfk_1 FOREIGN KEY (reports_to) REFERENCES employees (employee_number),
  CONSTRAINT employees_ibfk_2 FOREIGN KEY (office_code) REFERENCES offices (office_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS customers (
  customer_number int(11) NOT NULL,
  customer_name varchar(50) NOT NULL,
  contact_last_name varchar(50) NOT NULL,
  contact_first_name varchar(50) NOT NULL,
  phone varchar(50) NOT NULL,
  address_line1 varchar(50) NOT NULL,
  address_line2 varchar(50) DEFAULT NULL,
  city varchar(50) NOT NULL,
  state varchar(50) DEFAULT NULL,
  postal_code varchar(15) DEFAULT NULL,
  country varchar(50) NOT NULL,
  sales_rep_employee_number int(11) DEFAULT NULL,
  credit_limit decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (customer_number),
  KEY sales_rep_employee_number (sales_rep_employee_number),
  CONSTRAINT customers_ibfk_1 FOREIGN KEY (sales_rep_employee_number) REFERENCES employees (employee_number)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS orders (
  order_number int(11) NOT NULL,
  order_date date NOT NULL,
  required_date date NOT NULL,
  shipped_date date DEFAULT NULL,
  status varchar(15) NOT NULL,
  comments text,
  customer_number int(11) NOT NULL,
  PRIMARY KEY (order_number),
  KEY customer_number (customer_number),
  CONSTRAINT orders_ibfk_1 FOREIGN KEY (customer_number) REFERENCES customers (customer_number)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS productlines (
  product_line varchar(50) NOT NULL,
  text_description varchar(4000) DEFAULT NULL,
  html_description mediumtext,
  image mediumblob,
  PRIMARY KEY (product_line)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS products (
  product_code varchar(15) NOT NULL,
  product_name varchar(70) NOT NULL,
  product_line varchar(50) NOT NULL,
  product_scale varchar(10) NOT NULL,
  product_vendor varchar(50) NOT NULL,
  product_description text NOT NULL,
  quantity_in_stock smallint(6) NOT NULL,
  buy_price decimal(10,2) NOT NULL,
  MSRP decimal(10,2) NOT NULL,
  PRIMARY KEY (product_code),
  KEY product_line (product_line),
  CONSTRAINT products_ibfk_1 FOREIGN KEY (product_line) REFERENCES productlines (product_line)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS orderdetails (
  order_number int(11) NOT NULL,
  product_code varchar(15) NOT NULL,
  quantity_ordered int(11) NOT NULL,
  price_each decimal(10,2) NOT NULL,
  order_line_number smallint(6) NOT NULL,
  PRIMARY KEY (order_number,product_code),
  KEY product_code (product_code),
  CONSTRAINT orderdetails_ibfk_1 FOREIGN KEY (order_number) REFERENCES orders (order_number),
  CONSTRAINT orderdetails_ibfk_2 FOREIGN KEY (product_code) REFERENCES products (product_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS payments (
  customer_number int(11) NOT NULL,
  check_number varchar(50) NOT NULL,
  payment_date date NOT NULL,
  amount decimal(10,2) NOT NULL,
  PRIMARY KEY (customer_number, check_number),
  CONSTRAINT payments_ibfk_1 FOREIGN KEY (customer_number) REFERENCES customers (customer_number)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

