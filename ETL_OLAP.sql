CREATE DATABASE `Northwind_DW` /*!40100 DEFAULT CHARACTER SET latin1 */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE Northwind_DW;

CREATE TABLE `dim_customers` (
  `customer_key` int NOT NULL AUTO_INCREMENT,
  `company` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `job_title` varchar(50) DEFAULT NULL,
  `business_phone` varchar(25) DEFAULT NULL,
  `fax_number` varchar(25) DEFAULT NULL,
  `address` longtext,
  `city` varchar(50) DEFAULT NULL,
  `state_province` varchar(50) DEFAULT NULL,
  `zip_postal_code` varchar(15) DEFAULT NULL,
  `country_region` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`customer_key`),
  KEY `city` (`city`),
  KEY `company` (`company`),
  KEY `first_name` (`first_name`),
  KEY `last_name` (`last_name`),
  KEY `zip_postal_code` (`zip_postal_code`),
  KEY `state_province` (`state_province`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4;


CREATE TABLE `dim_employees` (
  `employee_key` int NOT NULL AUTO_INCREMENT,
  `company` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `email_address` varchar(50) DEFAULT NULL,
  `job_title` varchar(50) DEFAULT NULL,
  `business_phone` varchar(25) DEFAULT NULL,
  `home_phone` varchar(25) DEFAULT NULL,
  `fax_number` varchar(25) DEFAULT NULL,
  `address` longtext,
  `city` varchar(50) DEFAULT NULL,
  `state_province` varchar(50) DEFAULT NULL,
  `zip_postal_code` varchar(15) DEFAULT NULL,
  `country_region` varchar(50) DEFAULT NULL,
  `web_page` longtext,
  `notes` longtext,
  PRIMARY KEY (`employee_key`),
  KEY `city` (`city`),
  KEY `company` (`company`),
  KEY `first_name` (`first_name`),
  KEY `last_name` (`last_name`),
  KEY `zip_postal_code` (`zip_postal_code`),
  KEY `state_province` (`state_province`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4;

CREATE TABLE `dim_shippers` (
  `shipper_key` int NOT NULL AUTO_INCREMENT,
  `company` varchar(50) DEFAULT NULL,
  `address` longtext,
  `city` varchar(50) DEFAULT NULL,
  `state_province` varchar(50) DEFAULT NULL,
  `zip_postal_code` varchar(15) DEFAULT NULL,
  `country_region` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`shipper_key`),
  KEY `city` (`city`),
  KEY `company` (`company`),
  KEY `zip_postal_code` (`zip_postal_code`),
  KEY `state_province` (`state_province`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;
INSERT INTO `northwind_dw`.`dim_customers`
(`customer_key`,
`company`,
`last_name`,
`first_name`,
`job_title`,
`business_phone`,
`fax_number`,
`address`,
`city`,
`state_province`,
`zip_postal_code`,
`country_region`)
SELECT `id`,
`company`,
`last_name`,
`first_name`,
`job_title`,
`business_phone`,
`fax_number`,
`address`,
`city`,
`state_province`,
`zip_postal_code`,
`country_region`
FROM northwind.customers;


INSERT INTO `northwind_dw`.`dim_employees`
(`employee_key`,
`company`,
`last_name`,
`first_name`,
`email_address`,
`job_title`,
`business_phone`,
`home_phone`,
`fax_number`,
`address`,
`city`,
`state_province`,
`zip_postal_code`,
`country_region`,
`web_page`,
`notes`)
SELECT `id`,
`company`,
`last_name`,
`first_name`,
`email_address`,
`job_title`,
`business_phone`,
`home_phone`,
`fax_number`,
`address`,
`city`,
`state_province`,
`zip_postal_code`,
`country_region`,
`web_page`,
`notes`
FROM `northwind`.`employees`;

SELECT * FROM northwind_dw.dim_employees;

INSERT INTO `northwind_dw`.`dim_shippers`
(`shipper_key`,
`company`,
`address`,
`city`,
`state_province`,
`zip_postal_code`,
`country_region`)
SELECT `id`,
`company`,
`address`,
`city`,
`state_province`,
`zip_postal_code`,
`country_region`
FROM `northwind`.`shippers`;


SELECT * FROM northwind_dw.dim_shippers;

SELECT * FROM northwind.orders;

SELECT * FROM northwind.order_details;

SELECT * FROM northwind.order_details_status;

SELECT `o`.`id`,
    `o`.`employee_id`,
    `o`.`customer_id`,
    `o`.`order_date`,
    `o`.`shipped_date`,
    `o`.`shipper_id`,
    `o`.`ship_name`,
    `o`.`ship_address`,
    `o`.`ship_city`,
    `o`.`ship_state_province`,
    `o`.`ship_zip_postal_code`,
    `o`.`ship_country_region`,
    `o`.`shipping_fee`,
    `o`.`taxes`,
    `o`.`payment_type`,
    `o`.`paid_date`,
    `o`.`notes`,
    `o`.`tax_rate`,
    `o`.`tax_status_id`,
    os.status_name as orders_status_name FROM northwind.orders as o
LEFT OUTER JOIN northwind.orders_status as os
ON o.status_id = os.id;


SELECT `od`.`id`,
    `od`.`order_id`,
    `od`.`product_id`,
    `od`.`quantity`,
    `od`.`unit_price`,
    `od`.`discount`,
    `od`.`date_allocated`,
    `od`.`purchase_order_id`,
    `od`.`inventory_id`,
    ods.status_name as order_details_status_name FROM northwind.order_details as od
LEFT OUTER JOIN northwind.order_details_status as ods
ON od.status_id = ods.id;

-- ---
-- Joining orders and order_details to create 
-- fact orders table 
-- --- 
SELECT `o`.`id`,
    `o`.`employee_id`,
    `o`.`customer_id`,
    `o`.`order_date`,
    `o`.`shipped_date`,
    `o`.`shipper_id`,
    `o`.`ship_name`,
    `o`.`ship_address`,
    `o`.`ship_city`,
    `o`.`ship_state_province`,
    `o`.`ship_zip_postal_code`,
    `o`.`ship_country_region`,
    `o`.`shipping_fee`,
    `o`.`taxes`,
    `o`.`payment_type`,
    `o`.`paid_date`,
    `o`.`notes`,
    `o`.`tax_rate`,
    `o`.`tax_status_id`,
    os.status_name as orders_status_name, 
	`od`.`id`,
    `od`.`order_id`,
    `od`.`product_id`,
    `od`.`quantity`,
    `od`.`unit_price`,
    `od`.`discount`,
    `od`.`date_allocated`,
    ods.status_name as order_details_status_name
    FROM northwind.orders as o
INNER JOIN northwind.orders_status as os
ON o.status_id = os.id
RIGHT OUTER JOIN northwind.order_details as od
ON o.id = od.order_id
INNER JOIN northwind.order_details_status as ods 
ON od.status_id = ods.id;

USE Northwind_DW; 

CREATE TABLE `Fact_Orders` (
  `order_key` int NOT NULL AUTO_INCREMENT,
  `employee_id` int,
  `customer_id` int,
  `shipper_id` int,
  `order_id`int ,
  `product_id`int,
  `order_date` varchar(50) DEFAULT NULL,
  `shipped_date`varchar(50) DEFAULT NULL,
  `ship_name`varchar(50) DEFAULT NULL,
  `ship_address`varchar(50) DEFAULT NULL,
  `ship_city`varchar(50) DEFAULT NULL,
  `ship_state_province`varchar(50) DEFAULT NULL,
  `ship_zip_postal_code`varchar(50) DEFAULT NULL,
  `ship_country_region`varchar(50) DEFAULT NULL,
  `shipping_fee`varchar(50) DEFAULT NULL,
  `taxes`varchar(50) DEFAULT NULL,
  `payment_type`varchar(50) DEFAULT NULL,
  `paid_date`varchar(50) DEFAULT NULL,
  `tax_rate`varchar(50) DEFAULT NULL,
  `orders_status_name`varchar(50) DEFAULT NULL, 
  `quantity`numeric,
  `unit_price`FLOAT(8) DEFAULT 0.0,
  `discount`int,
  `order_details_status_name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`order_key`),
  KEY `employee_id`(`employee_id`),
  KEY `customer_id`(`customer_id`),
  KEY `shipper_id`(`shipper_id`), 
  KEY `order_id`(`order_id`),
  KEY `product_id`(`product_id`)
) ENGINE=InnoDB  AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;


INSERT INTO `Northwind_DW`.`Fact_Orders`
(`employee_id`,
`customer_id`,
`shipper_id`,
`order_id`,
`product_id`,
`order_date`,
`shipped_date`,
`ship_name`,
`ship_address`,
`ship_city`,
`ship_state_province`,
`ship_zip_postal_code`,
`ship_country_region`,
`shipping_fee`,
`taxes`,
`payment_type`,
`paid_date`,
`tax_rate`,
`orders_status_name`,
`quantity`,
`unit_price`,
`discount`,
`order_details_status_name`)
SELECT `o`.`employee_id`,
    `o`.`customer_id`,
    `o`.`shipper_id`,
    `o`.`id`,
    `od`.`product_id`,
    `o`.`order_date`,
    `o`.`shipped_date`,
    `o`.`ship_name`,
    `o`.`ship_address`,
    `o`.`ship_city`,
    `o`.`ship_state_province`,
    `o`.`ship_zip_postal_code`,
    `o`.`ship_country_region`,
    `o`.`shipping_fee`,
    `o`.`taxes`,
    `o`.`payment_type`,
    `o`.`paid_date`,
    `o`.`tax_rate`,
    os.status_name as orders_status_name, 
    `od`.`quantity`,
    `od`.`unit_price`,
    `od`.`discount`,
    ods.status_name as order_details_status_name
    FROM northwind.orders as o
    INNER JOIN northwind.orders_status as os
    ON o.status_id = os.id
    RIGHT OUTER JOIN northwind.order_details as od
    ON o.id = od.order_id
    INNER JOIN northwind.order_details_status as ods
    ON od.status_id = ods.id;

SELECT last_name,
SUM(unit_price) as total_unit_price,
SUM(quantity) as total_quantity 
FROM Northwind_DW.Fact_Orders 
JOIN `Northwind_DW`.`dim_customers`
ON `dim_customers`.`customer_key` = `Fact_Orders`.`customer_id`
GROUP BY customer_id;