-- -- [XI] 인덱스 : 조희를 빠르게 하는 인덱스
SELECT * FROM USER_INDEXES;
DROP TABLE EMP01;
CREATE TABLE EMP01 AS SELECT * FROM EMP; -- EMP테이블과 같은 내용의  EMP01;
SELECT * FROM EMP01; -- 14행
INSERT INTO EMP01 SELECT * FROM EMP01; -- ★데이터뻥튀기 1번(28) 2번(56행)




