-- SQL-команды для создания таблиц
CREATE TABLE customers_date
(
    customer_id varchar PRIMARY KEY,
    company_name varchar(100) NOT NULL,
	contact_name varchar(100) NOT NULL
);

CREATE TABLE employees_data
(
    employee_id int PRIMARY KEY,
    first_name varchar(100) NOT NULL,
	last_name varchar(100) NOT NULL,
	title varchar(100) NOT NULL,
	birth_date date NOT NULL,
	notes text
);

CREATE TABLE orders_data
(
    order_id int PRIMARY KEY,
    customer_id varchar(10) UNIQUE REFERENCES customers_date(customer_id),
	employee_id int REFERENCES employees_data(employee_id) NOT NULL,
	order_date date NOT NULL,
	ship_city text
)
