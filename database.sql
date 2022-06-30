REATE DATABASE PHARMACY;

USE PHARMACY;

CREATE TABLE customer (
    custid varchar(20) primary key ,
    Name varchar(50),
    Password varchar(50),
    Email varchar(50),
    Area varchar(50),
    Number int(10)
);


CREATE TABLE drugs(
    id varchar(10) primary key ,
    name varchar(30),
    quantity int,
    expdate date,
    druguse varchar(100)
);

CREATE TABLE orders(
    oid varchar(20) NOT NULL PRIMARY KEY ,
    customerid varchar(20) NOT NULL,
    items varchar(30),
    quantity int



);

ALTER TABLE orders MODIFY oid int auto_increment;
ALTER TABLE orders
ADD FOREIGN KEY (customerid) REFERENCES customer(custid);


DELIMITER &&
CREATE PROCEDURE order_view_data(IN custid VARCHAR(50))
BEGIN
    SELECT * FROM orders WHERE customerid=custid;
end &&
DELIMITER ;

# CALL order_view_data('test#12');

DELIMITER &&
CREATE PROCEDURE order_view_all_data()
BEGIN
    SELECT * FROM orders;
end &&
DELIMITER ;

# CALL order_view_all_data()


DELIMITER &&
CREATE PROCEDURE customer_view_all_data()
BEGIN
    SELECT * FROM customer;
end &&
DELIMITER ;

# CALL customer_view_all_data()

DELIMITER &&
CREATE PROCEDURE drug_view_all_data()
BEGIN
    SELECT * FROM drugs;
end &&
DELIMITER ;

# CALL drug_view_all_data()

# UPDATE PROCEDURES OF DRUGS
DELIMITER &&
CREATE PROCEDURE drug_update(IN d_use varchar(50),IN d_id varchar(10))
BEGIN
    UPDATE drugs SET druguse=d_use where id=d_id;
end &&
DELIMITER ;

# CALL drug_update('Fever','#D1');

DELIMITER &&
CREATE PROCEDURE customer_update(IN cust_email varchar(50),IN cust_number int(10))
BEGIN
    UPDATE customer SET Number=cust_number where Email=cust_email;
end &&
DELIMITER ;

# CALL customer_update('test@email.com','11111111')

# SELECT * FROM customer;

# DELETE PROCEDURES
DELIMITER &&
CREATE PROCEDURE customer_delete(IN cust_email varchar(50))
BEGIN
    DELETE FROM customer where Email=cust_email;
end &&
DELIMITER ;

# CALL customer_delete('test2@emai.com')
DELIMITER &&
CREATE PROCEDURE drug_delete(IN d_id varchar(50))
BEGIN
    DELETE FROM drugs where id=d_id;
end &&
DELIMITER ;

SELECT * FROM orders;
#procedure for adding orders
DELIMITER &&
CREATE PROCEDURE order_add_data(IN username varchar(50),IN O_items varchar(20),IN O_qty varchar(20),IN o_id varchar(20) )
BEGIN
    INSERT INTO orders VALUES (o_id,username,O_items,O_qty);
end &&
DELIMITER ;

# CALL order_add_data('Test#12','Strepsils','0,1,0',0)

# create triggers

DELIMITER |
CREATE TRIGGER cust_id
    before INSERT
    ON
    customer
    FOR EACH ROW
    BEGIN
    SET NEW.custid=CONCAT(NEW.Name,'#',FLOOR(RAND()*10));
    END |
    DELIMITER ;

SELECT * FROM orders;

#FUNCTIONS
DELIMITER //
CREATE FUNCTION total_customers() RETURNS int deterministic
    BEGIN
    DECLARE TOTAL int;
Select count(*) into total from customer;
RETURN TOTAL;
    END;
        //
        DELIMITER ;

#        SELECT total_customers()
