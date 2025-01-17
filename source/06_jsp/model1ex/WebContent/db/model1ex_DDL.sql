-- TABLE & SEQUENCE DROP
DROP TABLE FILEBOARD;
DROP TABLE CUSTOMER;
DROP TABLE BOOK;
DROP SEQUENCE FILEBOARD_SEQ;
DROP SEQUENCE BOOK_SEQ;

-- TABLE & SEQUENC CREATE
CREATE TABLE CUSTOMER(
    cID    VARCHAR2(50) PRIMARY KEY,
    cPW    VARCHAR2(50) NOT NULL,
    cNAME  VARCHAR2(50) NOT NULL,
    cTEL   VARCHAR2(50),
    cEMAIL VARCHAR2(50),
    cADDRESS VARCHAR2(250),
    cGENDER  VARCHAR2(10),
    cBIRTH   DATE,
    cRDATE   DATE DEFAULT SYSDATE
);

CREATE SEQUENCE FILEBOARD_SEQ MAXVALUE 9999999 NOCACHE NOCYCLE;
CREATE TABLE FILEBOARD(
    fNUM     NUMBER(7) PRIMARY KEY,
    cID      VARCHAR2(50) REFERENCES CUSTOMER(CID),
    fSUBJECT VARCHAR2(250) NOT NULL,
    fCONTENT VARCHAR2(4000),
    fFILENAME VARCHAR2(50),                -- 첨부파일명(첨부 안 할 경우 null)
    fPW       VARCHAR2(50) NOT NULL,
    fHIT      NUMBER(7) DEFAULT 0 NOT NULL,-- 조회수
    fREF      NUMBER(7) NOT NULL,
    fRE_STEP  NUMBER(7) NOT NULL,
    fRE_LEVEL NUMBER(1) NOT NULL,
    fIP       VARCHAR2(50) NOT NULL,
    fRDATE    DATE DEFAULT SYSDATE NOT NULL
);
  
CREATE SEQUENCE BOOK_SEQ MAXVALUE 9999999 NOCACHE NOCYCLE;
CREATE TABLE BOOK(
    bID NUMBER(7) PRIMARY KEY,
    bTITLE VARCHAR2(50) NOT NULL, -- 책제목
    bPRICE NUMBER(7)     NOT NULL, -- 책가격
    bIMAGE1 VARCHAR2(50) NOT NULL, -- 책 대표 이미지(첨부 안 할 경우 : noImg.png)
    bIMAGE2 VARCHAR2(50) NOT NULL, -- 책 부가 이미지(첨부 안 할 경우 : NOTHING.JPG)
    bCONTENT VARCHAR2(4000),       -- 책 설명(한글 1,333글자 이내)
    bDISCOUNT NUMBER(3) NOT NULL,  -- 할인율(0~100% 이내)
    bRDATE DATE DEFAULT SYSDATE    -- 책 등록일    
);

SELECT * FROM CUSTOMER;
SELECT * FROM FILEBOARD;
SELECT * FROM BOOK;
-- 인덱스나 뷰 생성이 필요하면 추가