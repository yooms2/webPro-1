DROP TABLE RESERVATION;
DROP TABLE MEMBER CASCADE CONSTRAINTS;
CREATE TABLE MEMBER(
    mID VARCHAR2(30) PRIMARY KEY,
    mNAME VARCHAR2(30) );
INSERT INTO MEMBER VALUES ('aaa','홍길동');
INSERT INTO MEMBER VALUES ('bbb','김길동');
SELECT * FROM MEMBER;
DROP TABLE CAMPGROUND;
CREATE TABLE CAMPGROUND(
  CNO NUMBER(4) PRIMARY KEY,
  CNAME VARCHAR2(100) NOT NULL, -- 장소명
  IMAGE VARCHAR2(100) NOT NULL, -- 사진
  TARGET VARCHAR2(100)
);
INSERT INTO CAMPGROUND VALUES 
  (1, '난지캠핑장', 'nanji.jpg','모든연령');
INSERT INTO CAMPGROUND VALUES 
  (2, '포천캠핑장', 'pochon.jpg', '노키즈존');
SELECT * FROM CAMPGROUND;
CREATE TABLE RESERVATION (
  RNO NUMBER(4) PRIMARY KEY,
  mId VARCHAR2(30) REFERENCES MEMBER(MID) NOT NULL,
  CNO NUMBER(4) REFERENCES CAMPGROUND(cNO) NOT NULL,
  ReservationDATE DATE,
  RegistrationDate DATE DEFAULT SYSDATE,
  DAY NUMBER(2)-- 달력에 뿌려주기 위해 필요함
);
DROP SEQUENCE RESERVATION_SEQ;
CREATE SEQUENCE RESERVATION_SEQ MAXVALUE 9999 NOCACHE NOCYCLE;
INSERT INTO RESERVATION (RNO, MID, CNO, ReservationDATE, DAY)
  VALUES (RESERVATION_SEQ.NEXTVAL, 'aaa', 1, '2023-03-22', to_char(to_date('2023-03-22'),'dd'));
INSERT INTO RESERVATION (RNO, MID, CNO, ReservationDATE, DAY)
  VALUES (RESERVATION_SEQ.NEXTVAL, 'aaa', 1, '2023-04-10', to_char(to_date('2023-04-10'),'dd'));
SELECT * FROM RESERVATION ORDER BY RegistrationDate;
INSERT INTO RESERVATION (RNO, MID, CNO, ReservationDATE, DAY)
  VALUES (RESERVATION_SEQ.NEXTVAL, 'aaa', 1, '2023-05-03', to_char(to_date('2023-05-03'),'dd'));
SELECT * FROM RESERVATION ORDER BY RegistrationDate;
-- 1. 캠핑장들 list
SELECT * FROM CAMPGROUND ORDER BY CNO;
-- 2. 특정 캠핑장
SELECT * FROM CAMPGROUND WHERE CNO=1;
-- 3. 해당 년월에 예약되었는지 파악
SELECT * FROM RESERVATION WHERE CNO=1 AND ReservationDATE='2023-03-22';
-- 4 . 캠핑장 예약하기
INSERT INTO RESERVATION (RNO, MID, CNO, ReservationDATE, DAY)
  VALUES (RESERVATION_SEQ.NEXTVAL, 'bbb', 1, 
        to_date('2023-04-05', 'yyyy-mm-dd'), to_char(to_date('2023-04-05', 'yyyy-mm-dd'),'dd'));
-- 5. 해당 년월에 예약된 내용들 보기
SELECT DAY FROM RESERVATION
  WHERE CNO=2 AND TO_CHAR(ReservationDATE, 'YYYY-MM') = '2023'|| '-' || '03'
  ORDER BY DAY;
commit;