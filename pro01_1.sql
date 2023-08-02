-- 회원(member) 테이블 생성
CREATE TABLE MEMBER(
	id VARCHAR(16) NOT NULL,
	pw VARCHAR(330) NOT NULL,
	NAME VARCHAR(100) NOT NULL,
	email VARCHAR(100) NOT NULL,
	tel VARCHAR(13),
	regdate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	POINT INT DEFAULT 0,
	PRIMARY KEY (id));

-- 테이블 목록 보기	
SHOW TABLES;

-- 회원 테이블 구조 보기
DESC MEMBER;

-- 더미데이터 삽입
INSERT INTO MEMBER(id, pw, NAME, email, tel) VALUES
('admin', '1234', '관리자', 'admin@edu.com', '010-1004-1004');

INSERT INTO MEMBER(id, pw, NAME, email, tel) VALUES
('kim', '4321', '김일등', 'kim@edu.com', '010-2004-2004');

INSERT INTO MEMBER(id, pw, NAME, email, tel) VALUES
('park', '1111', '박일병', 'park@edu.com', '010-3004-3004');

INSERT INTO MEMBER(id, pw, NAME, email, tel) VALUES
('jeong', '2222', '정일병', 'jeong@edu.com', '010-4004-4004');

INSERT INTO MEMBER(id, pw, NAME, email, tel) VALUES
('lee', '3333', '이일병', 'lee@edu.com', '010-5004-5004');

INSERT INTO MEMBER(id, pw, NAME, email, tel) VALUES
('shin', '4444', '신일병', 'shin@edu.com', '010-3004-3004')

SELECT * FROM MEMBER;

-- 게시판 테이블 생성
CREATE TABLE board(
	bno INT PRIMARY KEY AUTO_INCREMENT,
	title VARCHAR(200) NOT NULL,
	content VARCHAR(1000),
	author VARCHAR(16),
	regdate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	cnt INT DEFAULT 0);

-- 게시판 테이블 구조 보기	
DESC board;

-- 게시판 더미데이터 생성
INSERT INTO board(title, content, author) VALUES
('더미글1', '여기는 더미글1입니다', 'admin');

INSERT INTO board(title, content, author) VALUES
('더미글2', '여기는 더미글2입니다', 'admin');

INSERT INTO board(title, content, author) VALUES
('더미글3', '여기는 더미글3입니다', 'admin');

INSERT INTO board(title, content, author) VALUES
('더미글4', '여기는 더미글4입니다', 'admin');

INSERT INTO board(title, content, author) VALUES
('더미글5', '여기는 더미글5입니다', 'admin');

INSERT INTO board(title, content, author) VALUES
('더미글6', '여기는 더미글6입니다', 'admin');

INSERT INTO board(title, content, author) VALUES
('더미글7', '여기는 더미글7입니다', 'admin');

INSERT INTO board(title, content, author) VALUES
('더미글8', '여기는 더미글8입니다', 'lee');

-- 게시판 테이블 검색
SELECT * FROM board;

DELETE FROM MEMBER WHERE id='shin';  -- 아이디 shin인 회원의 레코드를 삭제
SELECT author FROM board WHERE bno=10; -- 글번호 10인 레코드의 이름을 변경

UPDATE board SET author='yoon' WHERE bno=9;

COMMIT;

-- 7번 글에 대한 작성자의 이름
SELECT * FROM MEMBER WHERE id='admin'; 
SELECT author FROM board WHERE bno=8;
s
-- 일치 검색
SELECT * FROM MEMBER WHERE NAME IN ('김일등', '이일병', '박일병');
SELECT * FROM MEMBER WHERE NAME='김일등' OR NAME='이일병' OR NAME='박일병';

-- 유사 검색
SELECT * FROM MEMBER WHERE NAME LIKE '김%'; -- 김씨만 검색
SELECT * FROM MEMBER WHERE NAME LIKE '%일%'; -- "일" 들어간 것만 검색

-- 중복성 제거 : 
SELECT DISTINCT author, title FROM board;
SELECT DISTINCT author FROM board;

-- 구간 검색
SELECT * FROM board WHERE bno >=3 AND bno <=6;
SELECT * FROM board WHERE bno BETWEEN 3 AND 6;
-- limit는 MySQL과 MariaDB만 사용 가능member
SELECT * FROM board LIMIT 2, 4;

-- 이중 쿼리(=, >=, <=, !=,,,) : select문을 이중으로 사용
SELECT id, NAME from member where id = (SELECT author FROM board WHERE bno=8);
-- 일치 검색(in)
SELECT id, NAME FROM MEMBER WHERE id IN(SELECT author FROM board);
-- 불일치 검색(not~in~)
SELECT id, NAME FROM MEMBER WHERE id not IN(SELECT author FROM board);
	 
--  연관쿼리와 join
--  연관커리(alias 활용)
SELECT * FROM MEMBER a, board b;	-- 7 * 8 -> 56건
SELECT a.id, a.name, a.email, b.bno, b.title MEMBER a, board b; -- 56건, 5개 항목
SELECT a.id AS pid, a.name AS pname, a.email, b.bno AS pno, b.title AS ptitle FROM MEMBER a, board b WHERE a.id=b.author;  -- 게시판에 글을 올린 회원정보와 글 정보 모두 표시

-- 내부 join
SELECT a.id, a.name, a.email, b.bno, b.title FROM MEMBER a INNER JOIN board b ON a.id=b.author;

-- 테이블 복제 : 키에 대한 복제는 이루어지지 않는다.
CREATE TABLE board2 AS SELECT * FROM board;

-- 기본 키 추가
ALTER TABLE board2 ADD CONSTRAINT PRIMARY KEY (bno);

-- 컬럼 수정 - auto_increment 추가
ALTER TABLE board2 MODIFY bno INT AUTO_INCREMENT;

SELECT * FROM board2;

DESC board2;

CREATE VIEW writer_info AS (SELECT a.id AS pid, a.name AS pname, a.email, b.bno AS pno, b.title AS ptitle FROM MEMBER a, board b WHERE a.id=b.author);

-- 생성된 뷰의 결과 출력 - view는 select 문만
SELECT * FROM writer_info;

--  sort(소트) = 분류, 순서정렬
SELECT * FROM board;

-- 읽은 횟수 증가
UPDATE board SET cnt=cnt+1 WHERE bno=3;

-- ORDER BY - 정렬
SELECT * FROM board ORDER BY author ASC, cnt DESC;
-- GROUP BY - 그룹화 및 집계(group by -> count, sum, avg, max, min...
SELECT author, COUNT(author) FROM board GROUP BY author;

--- 테이블 만들기 및 예시 데이터 추가
--- 테이블명 : 상품(goods)
--- 상품코드 : gcode - 정수 / 일련번호(기본키) - 필수 입력
--- 상품명 : gname - 문자열(150) - 필수입력
--- 종류 : gcate - 문자열(40) - 필수입력
--- 단가 : gprice - 정수 - 필수입력
--- 수량 : gqty - 정수 - 기본값 0
--- 등록일 : regdate - 날짜 - 기본값:오늘날짜 및 시간
CREATE TABLE goods(
	gcode INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
	gname VARCHAR(150) NOT NULL,
	gcate VARCHAR(40) NOT NULL,
	gprice INT NOT NULL,
	gqty INT DEFAULT 0,
	regdate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP);

SELECT * FROM goods;

DESC goods;

COMMIT; 

INSERT INTO goods(gname, gcate, gprice, gqty) VALUES
('2023 ADsP 데이터 분석 준전문가', '활용능력', '31000', '20');

INSERT INTO goods(gname, gcate, gprice, gqty) VALUES
('SQL 자격검정 실전문제', '활용능력', '18000', '10');

INSERT INTO goods(gname, gcate, gprice, gqty) VALUES
('2023 시나공 컴퓨터활용능력 1급 필기', '활용능력', '32000', '4');

INSERT INTO goods(gname, gcate, gprice, gqty) VALUES
('2023 유선배 SQL개발자(SQLD) 과외노트', '활용능력', '23000', '15');

INSERT INTO goods(gname, gcate, gprice, gqty) VALUES
('2023 원큐패스 개인정보관리사 CPPG', '활용능력', '38000', '10');

INSERT INTO goods(gname, gcate, gprice, gqty) VALUES
('2023 시나공 정보처리기사 필기', '활용능력', '35000', '14');

INSERT INTO goods(gname, gcate, gprice, gqty) VALUES
('2023 이기적 빅데이터분석기사 필기 기본서', '활용능력', '33000', '26');

INSERT INTO goods(gname, gcate, gprice, gqty) VALUES
('2023 이기적 리눅스마스터 2급 기본서', '활용능력', '28000', '20');

INSERT INTO goods(gname, gcate, gprice, gqty) VALUES
('2024 이기적 ITQ 엑셀 ver.2016', '활용능력', '16800', '36');

INSERT INTO goods(gname, gcate, gprice, gqty) VALUES
('2023 시나공 기출문제집 사무자동화산업기사 필기', '활용능력', '18000', '21');

INSERT INTO goods(gname, gcate, gprice, gqty) VALUES
('국가공인 SQLP 자격검정 핵심노트 2', '활용능력', '27000', '20');

INSERT INTO goods(gname, gcate, gprice, gqty) VALUES
('2023 이기적 컴퓨터그래픽스운용기능사 필기 기본서', '활용능력', '23000', '32');


--- 테이블명 : 판매(sales)
--- 판매코드 : scode - 정수 / 일련번호(기본키) - 필수입력
--- 상품코드 : gcode - 정수 - 필수 입력
--- 구매자 : id - 문자열(16) - 필수 입력
--- 수량 : qty - 정수 - 기본값 : 1 - 필수입력
--- 구매단가 : sprice - 정수 - 필수 입력
--- 결제수단 : stype - 정수 - 필수입력
--- 할인금액 : distotal - 정수
--- 결제금액 : paytotal - 정수
--- 총 금액 : stotal - 정수
--- 판매일 : saledate - 날짜 - 기본값 : 오늘날짜 및 시간

CREATE TABLE sales(
	scode INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
	gcode INT NOT NULL,
	id VARCHAR(16) NOT NULL,
	qty INT DEFAULT 1 NOT NULL,
	sprice INT NOT NULL,
	stype INT NOT NULL,
	distotal INT,
	paytotal INT,
	stotal INT,
	saledate TIMESTAMP DEFAULT CURRENT_TIMESTAMP);

SELECT * FROM sales;

DESC sales;

COMMIT; 

--- 상품코드 : gcode - 정수 - 필수 입력
--- 구매자 : id - 문자열(16) - 필수 입력
--- 수량 : qty - 정수 - 기본값 : 1 - 필수입력
--- 구매단가 : sprice - 정수 - 필수 입력
--- 결제수단 : stype - 정수 - 필수입력
--- 할인금액 : distotal - 정수
--- 결제금액 : paytotal - 정수
--- 총 금액 : stotal - 정수

INSERT INTO goods(id, qty, , gqty) VALUES
('2023 ADsP 데이터 분석 준전문가', '활용능력', '31000', '20');

INSERT INTO goods(gname, gcate, gprice, gqty) VALUES
('SQL 자격검정 실전문제', '활용능력', '18000', '10');

INSERT INTO goods(gname, gcate, gprice, gqty) VALUES
('2023 시나공 컴퓨터활용능력 1급 필기', '활용능력', '32000', '4');

INSERT INTO goods(gname, gcate, gprice, gqty) VALUES
('2023 유선배 SQL개발자(SQLD) 과외노트', '활용능력', '23000', '15');

INSERT INTO goods(gname, gcate, gprice, gqty) VALUES
('2023 원큐패스 개인정보관리사 CPPG', '활용능력', '38000', '10');

INSERT INTO goods(gname, gcate, gprice, gqty) VALUES
('2023 시나공 정보처리기사 필기', '활용능력', '35000', '14');

INSERT INTO goods(gname, gcate, gprice, gqty) VALUES
('2023 이기적 빅데이터분석기사 필기 기본서', '활용능력', '33000', '26');

INSERT INTO goods(gname, gcate, gprice, gqty) VALUES
('2023 이기적 리눅스마스터 2급 기본서', '활용능력', '28000', '20');

INSERT INTO goods(gname, gcate, gprice, gqty) VALUES
('2024 이기적 ITQ 엑셀 ver.2016', '활용능력', '16800', '36');

INSERT INTO goods(gname, gcate, gprice, gqty) VALUES
('2023 시나공 기출문제집 사무자동화산업기사 필기', '활용능력', '18000', '21');

INSERT INTO goods(gname, gcate, gprice, gqty) VALUES
('국가공인 SQLP 자격검정 핵심노트 2', '활용능력', '27000', '20');

INSERT INTO goods(gname, gcate, gprice, gqty) VALUES
('2023 이기적 컴퓨터그래픽스운용기능사 필기 기본서', '활용능력', '23000', '32');

shop