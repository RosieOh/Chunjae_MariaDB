 create table customer(
    customerid varchar(15) not null primary key,
    customername varchar(50) not null,
    customertype varchar(50) not null,
    country varchar(50) not null,
    city varchar(50),
    state varchar(50),
    postcode int,
    regiontype varchar(50);
    
show customer;
    
 create table buy(
	 seq int(10) primary key auto_increment,
    orderid varchar(15) not null,
    orderdate timestamp,
    shipdate timestamp,
    customerid varchar(15),
    productid varchar(15),
    quantity int(10),
    discount decimal(10,2);
    
desc buy;

CREATE TABLE product (
	productid VARCHAR(15) PRIMARY KEY,
	bigcategory VARCHAR(50) NOT NULL,
	subcategory VARCHAR(50),
	productname VARCHAR(100) NOT NULL,
	price DECIMAL (10, 2);
