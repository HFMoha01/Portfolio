CREATE TABLE MEMBERSHIP (
MEM_NUM     INT     NOT NULL    UNIQUE,
MEM_FNAME   VARCHAR(25)     NOT NULL,
MEM_LNAME   VARCHAR(25)     NOT NULL,
MEM_STREET  VARCHAR(50)     NOT NULL,
MEM_CITY    VARCHAR(50)     NOT NULL,
MEM_STATE   VARCHAR(2)     NOT NULL,
MEM_ZIP     VARCHAR(10)          NOT NULL,
MEM_BALANCE NUMERIC(5,2)     NOT NULL,
PRIMARY KEY (MEM_NUM));








