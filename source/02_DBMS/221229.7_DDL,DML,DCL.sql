--[ VII ] DDL, DCL, DML
--SQL = DDL(테이블 생성, 테이블삭제, 테이블구조변경, 테이블 모든 데이터 제거) + 
--      DML(SELECT, INSERT, UPDATE, DELETE) + 
--      DCL(사용자계정 생성, 사용자에게권한부여, 권한박탈, 사용자계정삭제, 트랜젝션 명령어)

-- ★ ★ ★ DDL ★ ★ ★
-- 1. 테이블 생성(CREATE TABLE 테이블명...) : 테이블 구조를 정의하기
CREATE TABLE BOOK (
    BOOKID NUMBER(4), -- BOOKID 필드의 타입은 숫자 4자리
    BOOKNAME VARCHAR2(20), -- BOOKNAME필드의 타입은 문자 20BYTE
    PUBLISHER VARCHAR2(20), -- PUBLISHER 필드의 타입은 문자 20BYTE
    RDATE     DATE,         -- RDATE 필드의 타입은 DATE형
    PRICE     NUMBER(8, 2),  -- PRICE필드의 타입은 숫자 전체 8자리, 소수점 2, 소수점앞 6. 소수점은 자리수 포함되지 않음
    PRIMARY KEY(BOOKID) -- 제약조건 : BOOKID필드가 주키(PRIMARY KEY : NOT NULL, UNIQUE)
);
SELECT * FROM BOOK;
DESC BOOK;

DROP TABLE BOOK; -- 테이블 삭제
CREATE TABLE BOOK(
    BID       NUMBER(4) PRIMARY KEY,
    BNAME     VARCHAR2(20),
    PUBLISHER VARCHAR2(20),
    RDATE     DATE,
    PRICE     NUMBER(8));
SELECT * FROM BOOK;
DESC BOOK;

    -- ex. EMP와 유사한 EMP01 테이블 : EMPNO(숫자4), ENAME(문자10), SAL(숫자7,2)
CREATE TABLE EMP01(
    EMPNO NUMBER(4),
    ENAME VARCHAR2(10),
    SAL   NUMBER(7,2)
);
SELECT * FROM EMP01;
    -- ex. DEPT01 테이블 : DEPTNO(숫자2:PK), DNAME(문자14), LOC(문자13)
CREATE TABLE DEPT01 ( 
    DEPTNO NUMBER(2) PRIMARY KEY,
    DNAME  VARCHAR2(14),
    LOC    VARCHAR2(13)
);
SELECT * FROM DEPT01;
-- 서브쿼리를 이용한 테이블 생성
CREATE TABLE EMP02
    AS
    SELECT * FROM EMP; -- 서브쿼리 결과로 EMP02 테이블 생성 후 데이터도 들어감(제약조건 미포함)
SELECT * FROM EMP02;
DESC EMP02;
    -- EMP03 : EMP 테이블에서 EMPNO, ENAME, DEPTNO만 추출한 데이터
CREATE TABLE EMP03 AS SELECT EMPNO, ENAME, DEPTNO FROM EMP;
SELECT * FROM EMP03;
    -- EMP04 : EMP테이블에서 10번 부서만 추출한 데이터
CREATE TABLE EMP04 AS SELECT * FROM EMP WHERE DEPTNO=10;
SELECT * FROM EMP04;
    -- EMP05 : EMP테이블 구조만 추출(데이터를 추출하지 않음)
CREATE TABLE EMP05 AS SELECT * FROM EMP WHERE 0=1;
SELECT * FROM EMP05;

DESC EMP;
SELECT * FROM EMP;
SELECT ROWNUM, EMPNO, ENAME, JOB FROM EMP; -- 테이블에서 행의 논리적 순서(읽어들인 순서)

-- 2. 테이블 구조 변경 (ALTER TABLE 테이블명 ADD || MODIFY || DROP ~)
-- (1) 필드 추가(ADD)
SELECT * FROM EMP03; -- EMPNO(수4), ENAME(문10), DEPTNO(수2)
ALTER TABLE EMP03 ADD (JOB VARCHAR2(20), SAL NUMBER(7,2) );
SELECT * FROM EMP03; -- 필드 추가시 데이터 NULL로
ALTER TABLE EMP03 ADD (COMM NUMBER(7,2));
--(2) 필드 수정(MODIFY)
SELECT * FROM EMP03; -- EMPNO(수4), ENAME(문10), DEPTNO(수2), JOB, SAL, COMM은 NULL
ALTER TABLE EMP03 MODIFY (EMPNO VARCHAR2(5)); -- 숫자데이터가 들어있어서 숫자로만 변경.
ALTER TABLE EMP03 MODIFY (EMPNO NUMBER(5)); 
ALTER TABLE EMP03 MODIFY (EMPNO NUMBER(4)); -- 숫자 데이터는 줄이는게 안 됨
ALTER TABLE EMP03 MODIFY (SAL VARCHAR2(10)); -- NULL 필드는 마음대로 수정 가능
ALTER TABLE EMP03 MODIFY (ENAME VARCHAR2(20)); -- 문자데이터 늘리거나 줄이거나 가능
DESC EMP03;
SELECT * FROM EMP03;
SELECT MAX(LENGTH(ENAME)) FROM EMP03;
ALTER TABLE EMP03 MODIFY (ENAME VARCHAR2(6)); -- 가능
ALTER TABLE EMP03 MODIFY (ENAME VARCHAR2(5)); -- 불가능
-- (3)필드 삭제(DROP)
ALTER TABLE EMP03 DROP COLUMN JOB; -- NULL인 필드 삭제(NULL이 아닌 필드는 데이터까지 삭제)
SELECT * FROM EMP03;
ALTER TABLE EMP03 DROP COLUMN DEPTNO;
-- 논리적으로 특정 필드를 접근 못하도록(낮)
ALTER TABLE EMP03 SET UNUSED (COMM);
SELECT * FROM EMP03;
--논리적으로 접근 불가했던 필드 물리적으로 삭제(새벽)
ALTER TABLE EMP03 DROP UNUSED COLUMNS;

-- 3. 테이블 삭제(DROP TABLE 테이블명)
DROP TABLE EMP01;
SELECT * FROM EMP01;
DROP TABLE DEPT; -- EMP테이블에서 DEPT테이블을 참조하는 경우 EMP테이블을 삭제한 후 DEPT 테이블 삭제

-- 4. 테이블의 모든 행을 제거(TRUNCATE TABLE 테이블명)
SELECT * FROM EMP03;
TRUNCATE TABLE EMP03; -- ROLLBACK 안 됨
SELECT * FROM EMP03;

-- 5. 테이블명 변경(RENAME 테이블명 TO 바꿀테이블명)
SELECT * FROM EMP02;
RENAME EMP02 TO EMP2;
SELECT * FROM EMP2;

-- 6. 데이터 딕셔너리(접근불가) VS. 데이터딕셔너리 뷰(접근용)
-- 종류
    --(1) USER_XXX : 현 계정이 소유하고 있는 객체(테이블, 제약조건, 뷰, 인덱스)
       -- USER_TABLES, USER_CONSTRAINTS, USER_INDEXES, USER_VIEWS
SELECT * FROM USER_TABLES;
SELECT * FROM USER_CONSTRAINTS;
SELECT * FROM USER_INDEXES;
SELECT * FROM USER_VIEWS;
    --(2) ALL_XXX : 현 계정에서 접근 가능한 객체(테이블, 제약조건, 뷰, 인덱스)
       -- ALL_TABLES, ALL_CONSTRAINTS, ALL_INDEXES, ALL_VIEWS
SELECT * FROM ALL_TABLES;
SELECT * FROM ALL_VIEWS;
    --(3) DBA_XXX ; DBA권한에서만 접근가능. DBMS의 모든 객체
       -- DBA_TABLES, DBA_CONSTRAINTS, DBA_INDEXES, DBA_VIEWS
SELECT * FROM DBA_TABLES;
        
-- ★ ★ ★ DML ★ ★ ★
-- 1. INSERT INTO 테이블명 VALUES (값1, 값2, ...);
   -- INSERT INTO 테이블명 (필드명1, 필드명2,..) VALUES (값1, 값2, ..);
SELECT * FROM DEPT01;
ROLLBACK;
INSERT INTO DEPT01 VALUES (50, 'ACCOUNTING', 'NEW YORK');
INSERT INTO DEPT01 VALUES (60, 'SALES', NULL); -- 명시적으로 NULL추가
INSERT INTO DEPT01 (DEPTNO, DNAME, LOC) VALUES (70, 'RESEARCH', '서대문');
INSERT INTO DEPT01 (LOC, DEPTNO, DNAME) VALUES ('마포', 80, 'IT');
INSERT INTO DEPT01 (DEPTNO, DNAME) VALUES (90, 'OPERATION'); -- 묵시적으로 NULL 추가
SELECT * FROM DEPT01;
-- 서브쿼리를 이용한 INSERT
    -- ex. dept테이블에서 10~30번 부서를 dept01테이블로 
INSERT INTO DEPT01 SELECT * FROM DEPT WHERE DEPTNO<40;
SELECT * FROM DEPT01;
-- EX. BOOK (BID는 11, BNAME은 '스포츠의학', 출판사는 '한솔출판', 출판일은 오늘, 가격은 90000)
DESC BOOK;
INSERT INTO BOOK VALUES (11, '스포츠의학', '한솔출판', SYSDATE, 90000);

-- 트랜젝션 명령어 (DML명령어에서만 적용)
    -- 트랜젝션은 데이터 처리의 한 단위. DML 명령어들이 실행됨과 동시에 트랜잭션이 진행.
COMMIT; -- 현 트랜젝션의 작업을 DB에 반영
INSERT INTO BOOK VALUES (12, '스포츠의학', '한솔출판', SYSDATE, 90000);
SELECT * FROM BOOK;
ROLLBACK;-- 현 트랜젝션의 작업을 취소

-- ※ 연습문제 (1페이지) ※
DROP TABLE SAM01;
CREATE TABLE SAM01(
    EMPNO NUMBER(4) PRIMARY KEY,
    ENAME VARCHAR2(10),
    JOB   VARCHAR2(9),
    SAL   NUMBER(7,2)
);
SELECT * FROM SAM01;
INSERT INTO SAM01 (EMPNO, ENAME, JOB, SAL) 
    VALUES (1000,'APPLE','POLICE',10000);
INSERT INTO SAM01 VALUES (1010,'BANANA','NURSE',15000);
INSERT INTO SAM01 VALUES (1020,'ORANGE','DOCTOR',25000);
INSERT INTO SAM01 (EMPNO, ENAME, SAL) VALUES (1030,'VERY',25000);
INSERT INTO SAM01 VALUES (1040,'CAT',NULL, 2000);
INSERT INTO SAM01 
    SELECT EMPNO, ENAME, JOB, SAL FROM EMP WHERE DEPTNO=10;
SELECT * FROM SAM01;
COMMIT;

-- 2. UPDATE 테이블명 SET 필드명1=값1 [, 필드명2=값2, 필드명N=값N...] [WHERE 조건];
SELECT * FROM EMP01;
CREATE TABLE EMP01 AS SELECT * FROM EMP;
    -- ex. 부서번호를 30으로 수정
UPDATE EMP01 SET DEPTNO=30;
SELECT * FROM EMP01;
ROLLBACK;
SELECT * FROM EMP01;
    -- ex. 모든 직원(EMP01)의 급여(SAL)를 10%인상
UPDATE EMP01 SET SAL=SAL*1.1 ;
SELECT * FROM EMP01;
    -- ex. emp01테이블 : 10번 부서 직원의 입사일을 오늘로, 부서번호는 30번으로 수정하시오
UPDATE EMP01 SET HIREDATE=SYSDATE, DEPTNO=30 WHERE DEPTNO=10;
SELECT * FROM EMP01;
    -- ex. sal이 3000이상인 사원만 급여를 10%인상시키시오
UPDATE EMP01 SET SAL=SAL*1.1 WHERE SAL>=3000;
    -- ex. DALLAS에 근무하는 직원의 급여를 1000$인상
UPDATE EMP01 SET SAL=SAL+1000 
    WHERE DEPTNO=(SELECT DEPTNO FROM DEPT WHERE LOC='DALLAS');
SELECT * FROM EMP01;
    -- ex. SCOTT의 부서번호 20으로, JOB은 MANAGER로, SAL과 COMM은 500$씩 인상, 
        -- 상사는 KING으로 수정
UPDATE EMP01 SET DEPTNO=20,
                 JOB = 'MANAGER',
                 SAL = SAL + 500,
                 COMM = NVL(COMM,0) + 500,
                 MGR = (SELECT EMPNO FROM EMP WHERE ENAME='KING')
        WHERE ENAME='SCOTT';
SELECT * FROM EMP01 WHERE ENAME='SCOTT';
    -- ex. dept01에서 60번 부서의 지역명을 20번 부서의 지역으로 수정
SELECT * FROM DEPT01;
UPDATE DEPT01 SET LOC=(SELECT LOC FROM DEPT01 WHERE DEPTNO=20)
    WHERE DEPTNO=60;
SELECT * FROM DEPT01;
    -- EMP01에서 모든 사원의 급여와 입사일을 'KING'의 급여와 입사일로 수정
    SELECT SAL FROM EMP WHERE ENAME='KING'; -- UPDATE에 들어갈 서브쿼리
    SELECT HIREDATE FROM EMP WHERE ENAME='KING';-- UPDATE에 들어갈 서브쿼리
UPDATE EMP01 SET SAL = (SELECT SAL FROM EMP WHERE ENAME='KING'),
                HIREDATE = (SELECT HIREDATE FROM EMP WHERE ENAME='KING');
UPDATE EMP01 SET (SAL, HIREDATE) = (SELECT SAL, HIREDATE FROM EMP WHERE ENAME='KING');

-- 3. DELETE FROM 테이블명 [WHERE 조건];
SELECT * FROM EMP01;
DELETE FROM EMP01 ;
ROLLBACK; -- DML 취소 가능
SELECT * FROM EMP01;
    -- ex. emp01에서 30부서 직원만 삭제
    DELETE FROM EMP01 WHERE DEPTNO=30;
    SELECT * FROM EMP01;
    -- ex. 'FORD'사원 퇴사
    DELETE FROM EMP01 WHERE ENAME='FORD';
    -- ex. SAM01테이블에서 JOB이 정해지지 않은 사원을 삭제
    SELECT * FROM SAM01;
    DELETE FROM SAM01 WHERE JOB IS NULL;
    -- EMP01 : 부서명이 SALES인 사원을 삭제 (서브쿼리 이용)
    DELETE FROM EMP01 WHERE DEPTNO = (SELECT DEPTNO FROM DEPT WHERE DNAME='SALES');
    -- EMP01 : 부서명이 RESEARCH부서에 근무하는 사원을 삭제
    DELETE FROM EMP01 WHERE DEPTNO = (SELECT DEPTNO FROM DEPT WHERE DNAME='RESEARCH');
    SELECT * FROM EMP01;
    COMMIT ;

-- ★ ★ 연습문제 (PDF 2~3페이지)
-- 1. 테이블생성
DROP TABLE MY_DATA;
CREATE TABLE MY_DATA(
    ID NUMBER(4),
    NAME VARCHAR2(10),
    USERID VARCHAR2(30),
    SALARY NUMBER(10,2),
    PRIMARY KEY(ID)
);
-- 2. 데이터 입력
INSERT INTO MY_DATA (ID, NAME, USERID, SALARY)
  VALUES (1, INITCAP('SCOTT'), LOWER('sscott'),TO_NUMBER('10,000.00','99,999.99'));
INSERT INTO MY_DATA VALUES (2, 'Ford', 'fford',13000.00);
INSERT INTO MY_DATA VALUES (3, 'Patel', 'ppatel',33000);
INSERT INTO MY_DATA VALUES (4,'Report','rreport',23500);
INSERT INTO MY_DATA  VALUES (5, 'Good', 'ggood',44450);
-- 3. 입력한 자료 확인
SELECT ID, NAME, USERID, TO_CHAR(SALARY, '99,999,999.99') FROM MY_DATA;
-- 4. 트랜젝션 작업 반영
COMMIT;
-- 5. ID가 3인 사람 수정
UPDATE MY_DATA SET SALARY=65000.00 WHERE ID=3;
COMMIT;
-- 6. Ford 삭제
DELETE FROM MY_DATA WHERE NAME='Ford';
COMMIT;
-- 7.
UPDATE MY_DATA SET SALARY = 15000 WHERE SALARY <= 15000;
-- 8 테이블 삭제
DROP TABLE MY_DATA;

-- EMP 테이블과 같은 구조와 같은 내용의 테이블 EMP01을 생성(테이블이 있을시
    -- 제거한 후)하고, 모든 사원의 부서번호를 30번으로 수정합니다.
DROP TABLE EMP01;
CREATE TABLE EMP01 AS SELECT * FROM EMP;
SELECT * FROM EMP01;
UPDATE EMP01 SET DEPTNO=30;
-- EMP01테이블의 모든 사원의 급여를 10% 인상시키는 UPDATE문을 작성
UPDATE EMP01 SET SAL=SAL*1.1;
-- 급여가 3000이상인 사원만 급여를 10%인상
UPDATE EMP01 SET SAL=SAL*1.1 WHERE SAL>=3000;
-- EMP01테이블에서 ‘DALLAS’에서 근무하는 직원들의 연봉을 1000인상
UPDATE EMP01 SET SAL= SAL+1000 WHERE DEPTNO=(SELECT DEPTNO FROM DEPT WHERE LOC='DALLAS');
-- SCOTT사원의 부서번호는 20번으로, 직급은 MANAGER로 한꺼번에 수정
UPDATE EMP01 SET DEPTNO=20, JOB='MANAGER' WHERE ENAME='SCOTT';
-- 부서명이 SALES인 사원을 모두 삭제하는 SQL작성
DELETE FROM EMP01 WHERE DEPTNO=(SELECT DEPTNO FROM DEPT WHERE DNAME='SALES');
-- 사원명이 ‘FORD’인 사원을 삭제하는 SQL 작성
DELETE FROM EMP01 WHERE ENAME='FORD';
-- SAM01 테이블에서 JOB이 NULL인 사원을 삭제하시오
DELETE FROM SAM01 WHERE JOB IS NULL;
-- SAM01테이블에서 ENAME이 ORANGE인 사원을 삭제하시오
DELETE FROM SAM01 WHERE ENAME='ORANGE';

-- ★ ★ ★ 제약조건
-- (1) PRIMARY KEY : 테이블의 각 행을 유일한 값으로 식별하기 위한 필드
-- (2) FOREIGN KEY : 테이블의 열이 다른 테이블의 열을 참조
-- (3) NOT NULL    : NULL을 포함하지 않는다
-- (4) UNIQUE : 모든 행의 값이 유일해야. NULL값은 허용(NULL은 여러개 입력 가능)
-- (5) CHECK (조건) : 해당 조건이 만족 (NULL값 허용)
-- DEFAULT : 기본값 설정(해당 열의 데이터 입력을 하지 않으면 원래는 NULL이 들어갈 것을 DEFAULT값이)

    -- DEPT1 & EMP1 테이블 생성
DROP TABLE EMP1;
DROP TABLE DEPT1;
CREATE TABLE DEPT1 (
    DEPTNO NUMBER(2) PRIMARY KEY,
    DNAME  VARCHAR2(14) NOT NULL UNIQUE,
    LOC    VARCHAR2(13) NOT NULL
);
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='DEPT1';
DROP TABLE DEPT1;
CREATE TABLE DEPT1 (
    DEPTNO NUMBER(2) CONSTRAINT DEPT_PK PRIMARY KEY,
    DNAME  VARCHAR2(14) CONSTRAINT DEPT_U NOT NULL UNIQUE,
    LOC    VARCHAR2(13) CONSTRAINT DEPT_LOC NOT NULL
);
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='DEPT1';
DROP TABLE DEPT1;
CREATE TABLE DEPT1 (
    DEPTNO NUMBER(2),
    DNAME  VARCHAR2(14) NOT NULL,
    LOC    VARCHAR2(13) NOT NULL,
    CONSTRAINT DEPTNO_P PRIMARY KEY(DEPTNO),
    CONSTRAINT DNAME_U UNIQUE(DNAME)
);
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='DEPT1';
CREATE TABLE DEPT1 (
    DEPTNO NUMBER(2),
    DNAME  VARCHAR2(14) NOT NULL,
    LOC    VARCHAR2(13) NOT NULL,
    PRIMARY KEY(DEPTNO),
    UNIQUE(DNAME)
);
SELECT * FROM DEPT1;
SELECT * FROM USER_INDEXES WHERE TABLE_NAME='DEPT1';

CREATE TABLE EMP1 (
    EMPNO NUMBER(4) PRIMARY KEY,
    ENAME VARCHAR2(10) NOT NULL,
    JOB   VARCHAR2(9)  NOT NULL,
    MGR   NUMBER(4),
    HIREDATE DATE DEFAULT SYSDATE,
    SAL   NUMBER(7,2) NOT NULL CHECK(SAL>0) ,
    COMM  NUMBER(7,2),
    DEPTNO NUMBER(2) REFERENCES DEPT1(DEPTNO)
);
DROP TABLE EMP1;
CREATE TABLE EMP1(
    EMPNO NUMBER(4),
    ENAME VARCHAR2(10) NOT NULL,
    JOB   VARCHAR2(9)  NOT NULL,
    MGR   NUMBER(4),
    HIREDATE DATE DEFAULT SYSDATE,
    SAL   NUMBER(7,2),
    COMM  NUMBER(7,2),
    DEPTNO NUMBER(2),
    PRIMARY KEY(EMPNO),
    CHECK (SAL>0),
    FOREIGN KEY(DEPTNO) REFERENCES DEPT1(DEPTNO));
SELECT * FROM EMP1;

INSERT INTO DEPT1 SELECT * FROM DEPT;
INSERT INTO DEPT1 (DEPTNO, LOC, DNAME)
    VALUES (40, 'SEOUL', 'IT'); -- 에러
INSERT INTO DEPT1 (DEPTNO, LOC, DNAME)
    VALUES (50, 'SEOUL', 'IT'); 
INSERT INTO DEPT1 VALUES (60, 'IT', 'PUSAN'); -- 에러
INSERT INTO DEPT1 VALUES (60, 'PLANNING', 'PUSAN');
INSERT INTO DEPT1 (DEPTNO, DNAME) VALUES (70, 'CS');--에러
INSERT INTO DEPT1 (DEPTNO, DNAME, LOC) 
    VALUES (70, 'CS', 'GANGNAM');
SELECT * FROM DEPT1;

INSERT INTO EMP1 (EMPNO, ENAME, JOB)
    VALUES (1001, 'HONG', 'MANAGER'); -- SAL,DEPTNO NULL가능
SELECT * FROM EMP1;
INSERT INTO EMP1 (EMPNO, ENAME, JOB, SAL)
    VALUES (1002, 'HONG', 'MANAGER', 0); -- 에러
INSERT INTO EMP1 (EMPNO, ENAME, JOB, SAL)
    VALUES (1002, 'HONG', 'MANAGER', 10000); -- 에러
INSERT INTO EMP1 
    VALUES (1003, 'KIM','MANAGER',NULL, NULL, NULL, NULL, 90);-- 에러
INSERT INTO EMP1 
    VALUES (1003, 'KIM','MANAGER',NULL, NULL, NULL, NULL, 70);
SELECT * FROM EMP1;

-- BOOK & BOOKCATEGORY (재평가 문제)
DROP TABLE BOOK;
DROP TABLE BOOKCATEGORY;
DROP TABLE BOOKCATEGORY CASCADE CONSTRAINTS; -- 참조하는 테이블과 상관없이 (비추)

CREATE TABLE BOOKCATEGORY(
    categoryCODE NUMBER(3),
    categoryName VARCHAR2(50),
    OFFICE_LOC VARCHAR2(50) NOT NULL,
    PRIMARY KEY(categoryCODE),
    UNIQUE(categoryName));
DROP TABLE BOOKCATEGORY;
CREATE TABLE BOOKCATEGORY(
    categoryCODE NUMBER(3) PRIMARY KEY,
    categoryName VARCHAR2(50) UNIQUE,
    OFFICE_LOC VARCHAR2(50) NOT NULL);

INSERT INTO BOOKCATEGORY VALUES (100, '철학','3층 인문실');
INSERT INTO BOOKCATEGORY VALUES (200, '인문','3층 인문실');
INSERT INTO BOOKCATEGORY VALUES (300, '자연과학','3층 과학실');
INSERT INTO BOOKCATEGORY VALUES (400, 'IT','4층 과학실');
SELECT * FROM BOOKCATEGORY;
CREATE TABLE BOOK(
  categoryCODE NUMBER(3) NOT NULL,
  bookNO VARCHAR2(20),
  bookNAME VARCHAR2(100),
  PUBLISHER VARCHAR2(100),
  PUBYEAR NUMBER(4) DEFAULT EXTRACT(YEAR FROM SYSDATE),
  PRIMARY KEY(BOOKNO),
  FOREIGN KEY(categoryCODE) REFERENCES BOOKCATEGORY(categoryCODE));
DROP TABLE BOOK;
CREATE TABLE BOOK(
  categoryCODE NUMBER(3) REFERENCES BOOKCATEGORY(categoryCODE) NOT NULL,
  BOOKNO VARCHAR2(20) PRIMARY KEY,
  BOOKNAME VARCHAR2(100),
  PUBLISHER VARCHAR2(100),
  PUBYEAR NUMBER(4) DEFAULT TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')) );
  
INSERT INTO BOOK (categoryCODE,BOOKNO,  BOOKNAME, PUBLISHER)
  VALUES (100,'100A01','철학자의 삶','이젠출판');
INSERT INTO BOOK VALUES (400,'400A01','이것은 DB다','다음출판', EXTRACT(YEAR FROM SYSDATE));
INSERT INTO BOOK VALUES (900,'400A02','이것은 DB다','아무출판', 2022); --외래키 참조 에러
INSERT INTO BOOK VALUES (NULL, '400B02','아무책','아무출판',2022); -- NOT NULL 에러
SELECT BOOKNO, BOOKNAME, PUBLISHER, PUBYEAR, CATEGORYNAME, OFFICE_LOC
    FROM BOOK B, BOOKCATEGORY C
    WHERE B.categoryCODE=C.categoryCODE;

-- 데이터 삭제시
SELECT * FROM BOOKCATEGORY;
DELETE FROM BOOKCATEGORY WHERE CATEGORYCODE=100; -- 참조하는 데이터는 삭제 불가
DELETE FROM BOOKCATEGORY WHERE CATEGORYCODE=200; -- 참조하지 않는 데이터는 삭제 가능
INSERT INTO BOOK (CATEGORYCODE, BOOKNO, BOOKNAME, PUBLISHER)
    VALUES ((SELECT CATEGORYCODE FROM BOOKCATEGORY WHERE CATEGORYNAME='철학'),
        '100A02','이것이 철학이다','이젠출판');



