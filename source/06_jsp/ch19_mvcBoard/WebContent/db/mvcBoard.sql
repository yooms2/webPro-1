-- TABLE & SEQUENCE DROP
DROP TABLE MVC_BOARD;
DROP SEQUENCE MVC_BOARD_SEQ;
-- TABLE & SEQUENCE CREATE
CREATE TABLE MVC_BOARD(
  bID   NUMBER(6),
  bNAME VARCHAR2(50) NOT NULL,
  bTITLE VARCHAR2(100) NOT NULL,
  bCONTENT VARCHAR2(1000),
  
  PRIMARY KEY(BID)
);
-- DUMMY DATA

-- DAO에 들어갈 QUERY



