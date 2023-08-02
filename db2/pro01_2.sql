USE shop;

CREATE TABLE customer(
	customerid VARCHAR(15) PRIMARY KEY COMMENT '고객id',
	customername varchar(50) not null comment '고객이름',
	customertype varchar(50) null comment '고객구분',
	country varchar(50) null comment '국적',
	city varchar(50) null comment '도시',
	state varchar(50) null comment '주',
	postcode int null comment '우편번호',
	regiontype varchar(50) null comment '지역구분'
);	

create table buy(
	seq int(10) primary key AUTO_INCREMENT comment '순번',
	orderid varchar(15) not null comment '주문id',
	orderdate datetime comment '주문일자',
	shipdate datetime comment '배송일자',
	customerid varchar(15) comment '고객id',
	productid varchar(15) comment '제품id',
	quantity int(10) comment '주문수량',
	discount decimal(10,2) comment '할인금액'
);

create table product(
	productid varchar(15) not null primary key comment '제품id',
	bigcategory varchar(50) not null comment '대분류명',
	subcategory varchar(50) comment '소분류명',
	productname varchar(100) not null comment '제품명',
	price decimal(10,2) comment '가격'
);

DESC customer;

DESC buy;

DESC product;

-- 대단위 데이터 csv 파일을  해당  테이블에 import 하기

LOAD DATA LOCAL INFILE 'customer.csv' INTO TABLE customer FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n';

SELECT * FROM customer;

LOAD DATA LOCAL INFILE 'buy.csv' INTO TABLE buy FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n';

SELECT * FROM buy;

LOAD DATA LOCAL INFILE 'product.csv' INTO TABLE product FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n';


-- 해당 데이터를 csv로 export 하기
-- 해당 테이블 먼저 검색(select)
SELECT * FROM product;
-- 검색 결과에서 전체 선택한 후 마우스 오른쪽 [격자 행 내보내기]
-- 내보낼 타입을 Excel csv 선택하고, 해당 파일의 이름과 경로를 지정
-- 내보내기

-- 테이블 삭제
DROP TABLE customer;
DROP TABLE buy;
DROP TABLE product;

COMMIT;

-- 테이블 목록 보기
SHOW TABLES;

-- sql 파일 실행하여 sql 명령을 실행하기
SOURCE test2.sql;

DESC customer;

Customer cus = NEW Customer();
cus.setCustomerid(request.getParameter("customerid"));
cus.setCustomername(request.getParameter("customername"));
cus.setCustomertype(request.getParameter("customertype"));
cus.setCountry(request.getParameter("contry"));
cus.setCity(request.getParameter("city"));
cus.setState(request.getParameter("state"));
cus.setPostcode(Integer.parseInt(request.getParameter("postcode")));
cus.setRegiontype(request.getParameter("regiontype"));
cusInsert(cus);
-- 고객 등록
INSERT INTO customer VALUES('AK-10880', 'Alien Kim', 'Consumer', 'South Korea', 'Seoul', 'Seoul', 18517, 'West');

-- 웹에서 고객등록
public void cusInsert(Customer cus) {   
	INSERT INTO customer VALUES(?, ?, ?, ?, ?, ?, ?, ?);
	pstmt.setString(1, cus.getCustomerid());
	pstmt.setString(2, cus.getCustomername());
	pstmt.setString(3, cus.getCustomertype());
	pstmt.setString(4, cus.getCountry());
	pstmt.setString(5, cus.getCity());
	pstmt.setString(6, cus.getState());
	pstmt.setInt(7, cus.getPostcode());
	pstmt.setString(8, cus.getRegiontype());
}

-- 고객 정보 변경
UPDATE customer SET country='America', city='Los Angels', state='Los Angels' WHERE customerid='AK-10880'; 

-- 웹에서 고객 정보 변경
UPDATE customer SET country=?, city=?, state=? WHERE customerid=?; 
pstmt.setString(1, cus.getCountry());
pstmt.setString(2, cus.getCity());
pstmt.setString(3, cus.getState());
pstmt.setString(4, cus.getCustomerid());

-- 고객 삭제 
DELETE FROM customer WHERE customerid='AK-10880';

-- 웹에서 고객 삭제
DELETE FROM customer WHERE customerid=?;
pstmt.setString(1, customerid);


COMMIT;

SELECT * FROM customer WHERE customername LIKE '%Kim%';

SELECT * FROM customer WHERE customername LIKE '%Kim%' AND city='Seoul';

SELECT COUNT(*) AS cnt FROM customer WHERE customername LIKE '%Kim%';
