-- table & sequence 제거 및 생성
DROP SEQUENCE B_SEQ;
DROP TABLE B CASCADE CONSTRAINTS;
DROP TABLE COMMENTS ;
DROP SEQUENCE COMMENTS_SEQ;
CREATE TABLE B(
    BNO NUMBER(9) PRIMARY KEY,
    BTITLE VARCHAR2(100) NOT NULL,
    BCONTENT CLOB,
    BFILE VARCHAR2(100),
    BRDATE DATE DEFAULT SYSDATE
);
CREATE SEQUENCE B_SEQ MAXVALUE 999999999 NOCYCLE NOCACHE;

CREATE TABLE COMMENTS (
    cNO NUMBER(9) PRIMARY KEY, -- 댓글번호
    BNO NUMBER(9) REFERENCES B(BNO), -- 글번호
    cCONTENT VARCHAR2(1000) NOT NULL, -- 댓글
    cIP VARCHAR2(100)  NOT NULL, -- ip
    cRDATE DATE DEFAULT SYSDATE -- 댓글 등록일
);
CREATE SEQUENCE COMMENTS_SEQ MAXVALUE 999999999 NOCACHE NOCYCLE;
-- dummy data
INSERT INTO B (BNO, BTITLE, BCONTENT, BFILE)
  VALUES (B_SEQ.NEXTVAL, '제목1','내용','nothing.jpg');
INSERT INTO B (BNO, BTITLE, BCONTENT, BFILE) 
  VALUES (B_SEQ.NEXTVAL, '제목2','내용','nothing.jpg');
INSERT INTO COMMENTS (CNO, BNO, CCONTENT, CIP) 
    VALUES (COMMENTS_SEQ.NEXTVAL, 1, '좋아요','192.168.10.30');
INSERT INTO COMMENTS (CNO, BNO, CCONTENT, CIP) 
    VALUES (COMMENTS_SEQ.NEXTVAL, 1, '좋은 정보 감사','192.168.10.30');
commit;

-- DAO에 들어갈 QUERY 
-- BDao의 글목록
SELECT BNO, BTITLE, BCONTENT, BFILE, (SELECT COUNT(*) FROM COMMENTS WHERE BNO=B.BNO) CNT
  FROM B ORDER BY BRDATE DESC; -- DAO에 들어갈 QUERY 
-- BDao의 글쓰기
INSERT INTO B (BNO, BTITLE, BCONTENT, BFILE)
  VALUES (B_SEQ.NEXTVAL, '제목1','내용','nothing.jpg');
-- BDao의 글 상세보기
SELECT BNO, BTITLE, BCONTENT, BFILE, (SELECT COUNT(*) FROM COMMENTS WHERE BNO=B.BNO) CNT
  FROM B WHERE BNO=9;
-- BDao의 글수정
UPDATE B
  SET BTITLE = '수정제목',
      BCONTENT = '수정본문',
      BFILE = 'nothing.jpg'
  WHERE BNO=1;
  
-- CommentsDao의 글 보기할 때 해당 글의 댓글목록
SELECT * FROM COMMENTS WHERE BNO=1 ORDER BY cRDATE DESC;

-- CommentsDao의 댓글 쓰기
INSERT INTO COMMENTS (CNO, BNO, CCONTENT, CIP) 
    VALUES (COMMENTS_SEQ.NEXTVAL, 1, '좋아요','192.168.10.30');
-- CommentsDao의 댓글하나 가져오기
SELECT * FROM COMMENTS WHERE cNO=1;
-- CommentsDao의 댓글 수정
UPDATE COMMENTS SET cCONTENT = '수정함', cIP='192.168.10.30' WHERE cNO=1;
-- CommentsDao의 댓글 삭제
DELETE FROM COMMENTS WHERE CNO=3;
COMMIT;