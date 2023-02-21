-- 시퀀스와 테이블 drop & create
DROP TABLE FRIEND;
DROP SEQUENCE FRIEND_NO_SEQ;
CREATE SEQUENCE FRIEND_NO_SEQ MAXVALUE 9999 NOCACHE NOCYCLE;
CREATE TABLE FRIEND(
    NO NUMBER(4,0) PRIMARY KEY,
    NAME VARCHAR2(30) NOT NULL,
    TEL VARCHAR2(30)
);
-- 친구 전부 가져오기
SELECT * FROM FRIEND;
-- 친구 추가
INSERT INTO FRIEND VALUES (FRIEND_NO_SEQ.NEXTVAL, '홍길동','010-9999-9999');
-- 친구 검색(추후 추가)

COMMIT;