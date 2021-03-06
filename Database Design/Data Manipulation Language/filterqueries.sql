
/* Various filter Queries*/
/* Type of SQL : MySQL  */

SELECT BOOK_TITLE, BOOK_COST, BOOK_YEAR
FROM BOOK
ORDER BY BOOK_TITLE;



SELECT PAT_FNAME, PAT_LNAME
FROM PATRON
ORDER BY UPPER(PAT_LNAME), UPPER(PAT_FNAME);


SELECT CHECK_NUM, CHECK_OUT_DATE, CHECK_DUE_DATE
FROM CHECKOUT
ORDER BY CHECK_NUM;


SELECT BOOK_NUM, BOOK_TITLE AS TITLE, BOOK_SUBJECT AS "Subject of Book"
FROM BOOK
ORDER BY BOOK_NUM;


SELECT DISTINCT BOOK_YEAR
FROM BOOK
ORDER BY BOOK_YEAR;



SELECT DISTINCT BOOK_SUBJECT
FROM BOOK
ORDER BY BOOK_SUBJECT;


SELECT BOOK_NUM, BOOK_TITLE, BOOK_COST AS "Replacement Cost"
FROM BOOK
ORDER BY BOOK_NUM;


SELECT CHECK_NUM, BOOK_NUM, PAT_ID, CHECK_OUT_DATE, CHECK_DUE_DATE
FROM CHECKOUT
ORDER BY CHECK_OUT_DATE DESC, CHECK_NUM;


SELECT BOOK_TITLE, BOOK_YEAR, BOOK_SUBJECT
FROM BOOK
ORDER BY BOOK_SUBJECT, BOOK_YEAR DESC, BOOK_TITLE;


SELECT BOOK_NUM, BOOK_TITLE, BOOK_COST
FROM BOOK
WHERE BOOK_COST = 59.95
ORDER BY BOOK_NUM;


SELECT BOOK_NUM, BOOK_TITLE, BOOK_COST
FROM BOOK
WHERE BOOK_SUBJECT = 'Database'
ORDER BY BOOK_NUM;


SELECT CHECK_NUM, BOOK_NUM, CHECK_OUT_DATE
FROM checkout
WHERE CHECK_OUT_DATE < '2017-04-05'
ORDER BY CHECK_NUM;



SELECT BOOK_NUM, BOOK_TITLE, BOOK_YEAR
FROM BOOK
WHERE BOOK_YEAR > 2015 AND BOOK_SUBJECT = 'Programming'
ORDER BY BOOK_NUM;



SELECT BOOK_NUM, BOOK_TITLE, BOOK_SUBJECT, BOOK_COST
FROM BOOK
WHERE (BOOK_SUBJECT = 'Middleware' OR BOOK_SUBJECT = 'Cloud')
      AND BOOK_COST > 70
ORDER BY BOOK_NUM;



SELECT AU_ID, AU_FNAME, AU_LNAME, AU_BIRTHYEAR
FROM AUTHOR
WHERE AU_BIRTHYEAR BETWEEN 1980 AND 1989
ORDER BY AU_ID;


SELECT BOOK_NUM, BOOK_TITLE, BOOK_SUBJECT
FROM BOOK
WHERE Upper(BOOK_TITLE) LIKE '%DATABASE%'
ORDER BY BOOK_NUM;



SELECT PAT_ID, PAT_FNAME, PAT_LNAME
FROM PATRON
WHERE Upper(PAT_TYPE) = 'STUDENT'
ORDER BY PAT_ID;



SELECT PAT_ID, PAT_FNAME, PAT_LNAME, PAT_TYPE
FROM PATRON
WHERE Upper(PAT_LNAME) LIKE 'C%'
ORDER BY PAT_ID;



SELECT AU_ID, AU_FNAME, AU_LNAME
FROM AUTHOR
WHERE AU_BIRTHYEAR IS NULL
ORDER BY AU_ID;



SELECT AU_ID, AU_FNAME, AU_LNAME
FROM AUTHOR
WHERE AU_BIRTHYEAR IS NOT NULL
ORDER BY AU_ID;



SELECT CHECK_NUM, BOOK_NUM, PAT_ID, CHECK_OUT_DATE, CHECK_DUE_DATE
FROM CHECKOUT
WHERE CHECK_IN_DATE IS NULL
ORDER BY BOOK_NUM;


SELECT AU_ID, AU_FNAME, AU_LNAME, AU_BIRTHYEAR
FROM AUTHOR
ORDER BY AU_BIRTHYEAR DESC, AU_LNAME;