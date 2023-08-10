USE edu;

CREATE TABLE faq(
fno INT PRIMARY KEY AUTO_INCREMENT,
question VARCHAR(500) NOT NULL,
answer VARCHAR(1000) NOT NULL,
cnt INT DEFAULT 0
);

SELECT * FROM faq;
SELECT * FROM board;

COMMIT;

INSERT INTO faq(question, answer) VALUES('자주 묻는 질문입니다1', '답변입니다1');
INSERT INTO faq(question, answer) VALUES('자주 묻는 질문입니다2', '답변입니다2');
INSERT INTO faq(question, answer) VALUES('자주 묻는 질문입니다3', '답변입니다3');
INSERT INTO faq(question, answer) VALUES('자주 묻는 질문입니다4', '답변입니다4');
INSERT INTO faq(question, answer) VALUES('자주 묻는 질문입니다5', '답변입니다5');


-- 암호화 시키기
SELECT * FROM member;

DESC member;

-- 고냥 비밀번호 풀려면 개씨발 어렵게 만들어 보리기
UPDATE member SET pw='03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4' WHERE pw='1234';
UPDATE member SET pw='fe2592b42a727e977f055947385b709cc82b16b9a87f88c6abf3900d65d0cdc3' WHERE pw='4321';
UPDATE member SET pw='318aee3fed8c9d040d35a7fc1fa776fb31303833aa2de885354ddf3d44d8fb69' WHERE pw='3333';
UPDATE member SET pw='0ffe1abd1a08215353c233d6e009613e95eec4253832a761af28ff37ac5a150c' WHERE pw='1111';

COMMIT;