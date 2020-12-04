/* Various DML Queries*/
/* Type of SQL : MySQL  */


-- 1
SELECT	* 
FROM	EMPLOYEE
WHERE	UPPER(EMP_LNAME) LIKE 'SMITH%'
ORDER BY EMP_NUM;



-- 4
SELECT DISTINCT PROJ_NUM
FROM ASSIGNMENT
ORDER BY PROJ_NUM;

-- 5
SELECT ASSIGN_NUM, EMP_NUM, PROJ_NUM, ASSIGN_CHARGE, ASSIGN_CHG_HR * ASSIGN_HOURS AS CALC_ASSIGN_CHARGE
FROM ASSIGNMENT
ORDER BY ASSIGN_NUM;


-- 7
SELECT PROJ_NUM, Sum(ASSIGN_HOURS) AS SumOfASSIGN_HOURS, Sum(ASSIGN_CHARGE) AS SumOfASSIGN_CHARGE
FROM ASSIGNMENT
GROUP BY PROJ_NUM
ORDER BY PROJ_NUM;

-- 8
SELECT SUM(ASSIGN_HOURS) AS SumOfSumOfASSIGN_HOURS, SUM(ASSIGN_CHARGE) AS SumOfSumOfASSIGN_CHARAGE
FROM ASSIGNMENT;

-- 9
SELECT COUNT(*)
FROM INVOICE;

-- 10
SELECT COUNT(*)
FROM CUSTOMER
WHERE CUS_BALANCE >500;



-- 16
SELECT INV_NUMBER, Sum(LINE_UNITS * LINE_PRICE) AS "Invoice Total"
FROM LINE
GROUP BY INV_NUMBER
ORDER BY INV_NUMBER;


-- 17
SELECT	CUS_CODE, INVOICE.INV_NUMBER, Sum(LINE_UNITS * LINE_PRICE) AS "Invoice Total"
FROM INVOICE JOIN LINE ON INVOICE.INV_NUMBER = LINE.INV_NUMBER
GROUP BY CUS_CODE, INVOICE.INV_NUMBER;


-- 18
SELECT CUS_CODE, COUNT(DISTINCT INVOICE.INV_NUMBER) AS "Number of Invoices", SUM(LINE_UNITS * LINE_PRICE) AS "Total Customer Purchases"
FROM INVOICE JOIN LINE ON INVOICE.INV_NUMBER = LINE.INV_NUMBER
GROUP BY CUS_CODE
ORDER BY CUS_CODE;

-- 19
SELECT SUM(NUMINVOICES) AS "Total Invoices", SUM(TOTPURCH) AS "Total Sales", MIN(TOTPURCH) AS "Minimum Customer Purchases", 
MAX(TOTPURCH) AS "Largest Customer Purchases", AVG(TOTPURCH) AS "Average Customer Purchases"
FROM (SELECT CUS_CODE, COUNT(DISTINCT INVOICE.INV_NUMBER) AS NUMINVOICES, SUM(LINE_UNITS * LINE_PRICE) AS TOTPURCH
      FROM INVOICE JOIN LINE ON INVOICE.INV_NUMBER = LINE.INV_NUMBER
      GROUP BY CUS_CODE) as emptotals;

-- 20
SELECT DISTINCT CUS_CODE, CUS_BALANCE
FROM CUSTOMER JOIN INVOICE ON CUSTOMER.CUS_CODE = INVOICE.CUS_CODE
ORDER BY CUS_CODE;

-- 21
SELECT MIN(CUS_BALANCE) AS "Minimum Balance", MAX(CUS_BALANCE) AS "Maximum Balance", AVG(CUS_BALANCE) AS "Average Balance"
FROM CUSTOMER JOIN INVOICE ON CUSTOMER.CUS_CODE = INVOICE.CUS_CODE;


-- 22
SELECT Sum(CUS_BALANCE) AS "Total Balance", Min(CUS_BALANCE) AS "Minimum Balance", Max(CUS_BALANCE) AS "Maximum Balance", Avg(CUS_BALANCE) AS "Average Balance"
FROM CUSTOMER;


-- 23
SELECT CUS_CODE, CUS_BALANCE
FROM CUSTOMER
WHERE CUSTOMER.CUS_CODE NOT IN
	(SELECT CUS_CODE FROM INVOICE)
ORDER BY CUS_CODE;


-- 24
SELECT	SUM(CUS_BALANCE) AS "Total Balance", 
	MIN(CUS_BALANCE) AS "Minimum Balance", 
	MAX(CUS_BALANCE) AS "Maximum Balance", 
	AVG(CUS_BALANCE) AS "Average Balance"
FROM 	CUSTOMER
WHERE	CUS_CODE NOT IN (SELECT CUS_CODE FROM INVOICE);


-- 25
SELECT P_DESCRIPT, P_QOH, P_PRICE, P_QOH * P_PRICE AS Subtotal
FROM PRODUCT
ORDER BY SUBTOTAL DESC;


-- 26
SELECT SUM(P_QOH*P_PRICE) AS "Total Value of Inventory"
FROM PRODUCT;


-- 27
SELECT *
FROM LGDEPARTMENT
ORDER BY DEPT_NAME;


-- 28
SELECT PROD_SKU, PROD_DESCRIPT,PROD_TYPE, PROD_BASE, PROD_CATEGORY, PROD_PRICE
FROM LGPRODUCT
WHERE PROD_BASE = 'Water' AND PROD_CATEGORY = 'Sealer';


-- 29
SELECT EMP_FNAME, EMP_LNAME, EMP_EMAIL
FROM LGEMPLOYEE
WHERE EMP_HIREDATE Between '2005-01-01' And '2014-12-31'
ORDER BY EMP_LNAME, EMP_FNAME;


-- 30
SELECT EMP_FNAME, EMP_LNAME, EMP_PHONE, EMP_TITLE, DEPT_NUM
FROM LGEMPLOYEE
WHERE DEPT_NUM=300 Or EMP_TITLE='CLERK I'
ORDER BY EMP_LNAME, EMP_FNAME;


-- 31
SELECT EMP.EMP_NUM, EMP_LNAME, EMP_FNAME, SAL_FROM, SAL_END, SAL_AMOUNT
FROM LGEMPLOYEE EMP JOIN LGSALARY_HISTORY SAL ON EMP.EMP_NUM = SAL.EMP_NUM
WHERE EMP.EMP_NUM In (83731, 83745, 84039)
ORDER BY EMP.EMP_NUM, SAL_FROM;


-- 32
SELECT DISTINCT CUST_FNAME, CUST_LNAME, CUST_STREET, CUST_CITY, CUST_STATE, CUST_ZIP
FROM LGCUSTOMER AS C JOIN LGINVOICE AS I ON C.CUST_CODE = I.CUST_CODE 
     JOIN LGLINE AS L ON I.INV_NUM = L.INV_NUM JOIN LGPRODUCT AS P ON L.PROD_SKU = P.PROD_SKU JOIN LGBRAND AS B ON P.BRAND_ID = B.BRAND_ID
WHERE BRAND_NAME = 'FORESTERS BEST'
      AND PROD_CATEGORY = 'Top Coat'
      AND INV_DATE BETWEEN '2017-7-15' AND '2017-7-31'
ORDER BY CUST_STATE, CUST_LNAME, CUST_FNAME;


-- 33
SELECT E.EMP_NUM, EMP_LNAME, EMP_EMAIL, EMP_TITLE, DEPT_NAME
FROM LGEMPLOYEE AS E JOIN LGDEPARTMENT AS D ON E.DEPT_NUM = D.DEPT_NUM
WHERE EMP_TITLE LIKE '%ASSOCIATE'
ORDER BY DEPT_NAME, EMP_TITLE;


-- 34
SELECT BRAND_NAME, Count(PROD_SKU) AS NUMPRODUCTS
FROM LGBRAND AS B JOIN LGPRODUCT AS P ON B.BRAND_ID = P.BRAND_ID
GROUP BY BRAND_NAME
ORDER BY BRAND_NAME;


-- 35
SELECT PROD_CATEGORY, Count(*) AS NUMPRODUCTS
FROM LGPRODUCT
WHERE PROD_BASE = 'Water'
GROUP BY PROD_CATEGORY;


-- 36
SELECT PROD_BASE, PROD_TYPE, Count(*) AS NUMPRODUCTS
FROM LGPRODUCT
GROUP BY PROD_BASE, PROD_TYPE
ORDER BY PROD_BASE, PROD_TYPE;


-- 37
SELECT BRAND_ID, Sum(PROD_QOH) AS TOTALINVENTORY
FROM LGPRODUCT
GROUP BY BRAND_ID
ORDER BY BRAND_ID DESC;


-- 38
SELECT P.BRAND_ID, BRAND_NAME, Round(Avg(PROD_PRICE),2) AS AVGPRICE
FROM LGBRAND AS B JOIN LGPRODUCT AS P ON B.BRAND_ID = P.BRAND_ID
GROUP BY P.BRAND_ID, BRAND_NAME
ORDER BY BRAND_NAME;


-- 39
SELECT DEPT_NUM, Max(EMP_HIREDATE) AS MOSTRECENT
FROM LGEMPLOYEE
GROUP BY DEPT_NUM
ORDER BY DEPT_NUM;


-- 40
SELECT E.EMP_NUM, EMP_FNAME, EMP_LNAME, Max(SAL_AMOUNT) AS LARGESTSALARY
FROM LGEMPLOYEE AS E JOIN LGSALARY_HISTORY AS S ON E.EMP_NUM = S.EMP_NUM
WHERE DEPT_NUM = 200
GROUP BY E.EMP_NUM, EMP_FNAME, EMP_LNAME
ORDER BY max(sal_amount) DESC;


-- 41
SELECT C.CUST_CODE, CUST_FNAME, CUST_LNAME, Sum(INV_TOTAL) AS TOTALINVOICES
FROM LGCUSTOMER AS C JOIN LGINVOICE AS I ON C.CUST_CODE = I.CUST_CODE
GROUP BY C.CUST_CODE, CUST_FNAME, CUST_LNAME
HAVING Sum(INV_TOTAL) > 1500
ORDER BY Sum(INV_TOTAL) DESC;


-- 42
SELECT D.DEPT_NUM, DEPT_NAME, DEPT_PHONE, D.EMP_NUM, EMP_LNAME
FROM LGDEPARTMENT AS D JOIN LGEMPLOYEE AS E ON D.EMP_NUM = E.EMP_NUM
ORDER BY DEPT_NAME;


-- 43
SELECT V.VEND_ID, VEND_NAME, BRAND_NAME, Count(*) AS NUMPRODUCTS
FROM LGBRAND AS B JOIN LGPRODUCT AS P ON B.BRAND_ID = P.BRAND_ID 
     JOIN LGSUPPLIES AS S ON P.PROD_SKU = S.PROD_SKU 
     JOIN LGVENDOR AS V ON S.VEND_ID = V.VEND_ID
GROUP BY V.VEND_ID, VEND_NAME, BRAND_NAME
ORDER BY VEND_NAME, BRAND_NAME;


-- 44
SELECT EMP_NUM, EMP_LNAME, EMP_FNAME, Sum(INV_TOTAL) AS TOTALINVOICES
FROM LGINVOICE JOIN LGEMPLOYEE ON EMP_NUM = EMPLOYEE_ID
GROUP BY EMP_NUM, EMP_LNAME, EMP_FNAME
ORDER BY EMP_LNAME, EMP_FNAME;



-- 45
SELECT Max(AVGPRICE) AS "LARGEST AVERAGE"
FROM (SELECT BRAND_ID, Round(Avg(PROD_PRICE),2) AS AVGPRICE
      FROM LGPRODUCT P
      GROUP BY BRAND_ID) AS BRANDAVGS;


-- 46
SELECT P.BRAND_ID, BRAND_NAME, BRAND_TYPE, Round(Avg(PROD_PRICE),2) AS AVGPRICE
FROM LGPRODUCT AS P JOIN LGBRAND AS B ON P.BRAND_ID = B.BRAND_ID
GROUP BY P.BRAND_ID, BRAND_NAME, BRAND_TYPE
HAVING Round(Avg(PROD_PRICE),2) = 
	(SELECT Max(AVGPRICE) AS "LARGEST AVERAGE"
                          FROM (SELECT BRAND_ID, 
					  Round(Avg(PROD_PRICE),2) AS AVGPRICE
                                FROM LGPRODUCT P
                                GROUP BY BRAND_ID) AS BRANDAVGS
		);


-- 47
SELECT MANAGER.EMP_FNAME, MANAGER.EMP_LNAME, DEPT_NAME, DEPT_PHONE, E.EMP_FNAME, E.EMP_LNAME, CUST_FNAME, CUST_LNAME, INV_DATE, INV_TOTAL
FROM LGDEPARTMENT AS D JOIN LGEMPLOYEE AS E ON D.DEPT_NUM = E.DEPT_NUM JOIN LGEMPLOYEE AS MANAGER ON D.EMP_NUM = MANAGER.EMP_NUM
     JOIN LGINVOICE AS I ON E.EMP_NUM = I.EMPLOYEE_ID JOIN LGCUSTOMER AS C ON I.CUST_CODE = C.CUST_CODE
WHERE CUST_LNAME = 'HAGAN'
      AND INV_DATE = '2017-05-18'; 


-- 48
SELECT E.EMP_NUM, EMP_LNAME, EMP_FNAME, SAL_AMOUNT
FROM LGEMPLOYEE AS E JOIN LGSALARY_HISTORY AS SH ON E.EMP_NUM = SH.EMP_NUM
WHERE SAL_END IS NULL
ORDER BY SAL_AMOUNT DESC;

-- 49
SELECT E.EMP_NUM, EMP_LNAME, EMP_FNAME, SAL_AMOUNT
FROM LGEMPLOYEE AS E JOIN LGSALARY_HISTORY AS SH ON E.EMP_NUM = SH.EMP_NUM
WHERE SAL_FROM = (SELECT MIN(SAL_FROM) FROM LGSALARY_HISTORY WHERE EMP_NUM = E.EMP_NUM)
ORDER BY E.EMP_NUM;

-- 50
SELECT L1.INV_NUM, L1.LINE_NUM, P1.PROD_SKU, P1.PROD_DESCRIPT, L2.LINE_NUM, P2.PROD_SKU, P2.PROD_DESCRIPT, P1.BRAND_ID
FROM (LGLINE AS L1 JOIN LGPRODUCT AS P1 ON L1.PROD_SKU = P1.PROD_SKU) 
JOIN (LGLINE AS L2 JOIN LGPRODUCT AS P2 ON L2.PROD_SKU = P2.PROD_SKU)
ON L1.INV_NUM = L2.INV_NUM
WHERE P1.PROD_CATEGORY = 'Sealer' AND P2.PROD_CATEGORY = 'Top Coat' AND P1.BRAND_ID = P2.BRAND_ID
ORDER BY L1.INV_NUM, L1.LINE_NUM, L2.LINE_NUM DESC;

-- 51
SELECT emp.emp_num, emp_fname, emp_lname, emp_email, total
FROM lgemployee emp JOIN
                (SELECT employee_id, Sum(line_qty) AS total
                 FROM lginvoice i join lgline l ON i.inv_num = l.inv_num join lgproduct p ON l.prod_sku = p.prod_sku join lgbrand b ON b.brand_id = p.brand_id
                 WHERE brand_name = 'BINDER PRIME' AND INV_DATE BETWEEN '2017-11-01' AND '2017-12-06'
                 GROUP BY employee_id) EMPSALES
      ON emp.emp_num = empsales.employee_id
WHERE total = (SELECT Max(total)
               FROM (SELECT employee_id, Sum(line_qty) AS total
                     FROM lginvoice i join lgline l ON i.inv_num = l.inv_num join lgproduct p ON l.prod_sku = p.prod_sku join lgbrand b ON b.brand_id = p.brand_id
                     WHERE brand_name = 'BINDER PRIME' AND INV_DATE BETWEEN '2017-11-01' AND '2017-12-06'
                     GROUP BY employee_id) AS EMPSALES2)
ORDER BY EMP_LNAME;

-- 52
SELECT C.CUST_CODE, CUST_FNAME, CUST_LNAME 
FROM LGCUSTOMER C JOIN LGINVOICE I ON C.CUST_CODE = I.CUST_CODE 
WHERE EMPLOYEE_ID = 83649 AND C.CUST_CODE IN (SELECT CUST_CODE FROM LGINVOICE WHERE EMPLOYEE_ID = 83677)
ORDER BY CUST_LNAME, CUST_FNAME;

-- 53
SELECT c.cust_code, cust_fname, cust_lname, cust_street, cust_city, cust_state, cust_zip, inv_date, inv_total AS "Largest Invoice"
FROM lgcustomer c join lginvoice i ON c.cust_code = i.cust_code
WHERE cust_state = 'AL' AND inv_total = (SELECT Max(inv_total) FROM lginvoice i2 WHERE i2.cust_code = c.cust_code)
UNION
SELECT cust_code, cust_fname, cust_lname, cust_street, cust_city, cust_state, cust_zip, NULL, 0
FROM lgcustomer
WHERE cust_state = 'AL' AND cust_code NOT IN (SELECT cust_code FROM lginvoice)
ORDER BY cust_lname, cust_fname;

-- 54
SELECT brand_name, brand_type, Round(avgprice,2) AS "Average Price", USOLD AS "Units Sold"
FROM lgbrand b join (SELECT brand_id, Avg(prod_price) AS avgprice FROM lgproduct GROUP BY brand_id) sub1 ON b.brand_id = sub1.brand_id
     join (SELECT brand_id, Sum(line_qty) AS USOLD FROM lgproduct p join lgline l ON p.prod_sku = l.prod_sku GROUP BY brand_id) sub2
     ON b.brand_id = sub2.brand_id
ORDER BY brand_name;

-- 55
SELECT brand_name, brand_type, prod_sku, prod_descript, prod_price
FROM lgproduct p join lgbrand b ON p.brand_id = b.brand_id
WHERE brand_type <> 'PREMIUM'
      AND prod_price > (SELECT Max(prod_price) FROM lgproduct p join lgbrand b ON p.brand_id = b.brand_id WHERE brand_type = 'PREMIUM');

-- 56
SELECT BOOK_TITLE, BOOK_COST, BOOK_YEAR
FROM BOOK
ORDER BY BOOK_TITLE;


-- 57
SELECT PAT_FNAME, PAT_LNAME
FROM PATRON
ORDER BY UPPER(PAT_LNAME), UPPER(PAT_FNAME);

-- 58
SELECT CHECK_NUM, CHECK_OUT_DATE, CHECK_DUE_DATE
FROM CHECKOUT
ORDER BY CHECK_NUM;

-- 59
SELECT BOOK_NUM, BOOK_TITLE AS TITLE, BOOK_SUBJECT AS "Subject of Book"
FROM BOOK
ORDER BY BOOK_NUM;

-- 60
SELECT DISTINCT BOOK_YEAR
FROM BOOK
ORDER BY BOOK_YEAR;


-- 61
SELECT DISTINCT BOOK_SUBJECT
FROM BOOK
ORDER BY BOOK_SUBJECT;

-- 62
SELECT BOOK_NUM, BOOK_TITLE, BOOK_COST AS "Replacement Cost"
FROM BOOK
ORDER BY BOOK_NUM;

-- 63
SELECT CHECK_NUM, BOOK_NUM, PAT_ID, CHECK_OUT_DATE, CHECK_DUE_DATE
FROM CHECKOUT
ORDER BY CHECK_OUT_DATE DESC, CHECK_NUM;

-- 64
SELECT BOOK_TITLE, BOOK_YEAR, BOOK_SUBJECT
FROM BOOK
ORDER BY BOOK_SUBJECT, BOOK_YEAR DESC, BOOK_TITLE;

-- 65
SELECT BOOK_NUM, BOOK_TITLE, BOOK_COST
FROM BOOK
WHERE BOOK_COST = 59.95
ORDER BY BOOK_NUM;

-- 66
SELECT BOOK_NUM, BOOK_TITLE, BOOK_COST
FROM BOOK
WHERE BOOK_SUBJECT = 'Database'
ORDER BY BOOK_NUM;

-- 67
SELECT CHECK_NUM, BOOK_NUM, CHECK_OUT_DATE
FROM checkout
WHERE CHECK_OUT_DATE < '2017-04-05'
ORDER BY CHECK_NUM;


-- 68
SELECT BOOK_NUM, BOOK_TITLE, BOOK_YEAR
FROM BOOK
WHERE BOOK_YEAR > 2015 AND BOOK_SUBJECT = 'Programming'
ORDER BY BOOK_NUM;


-- 69
SELECT BOOK_NUM, BOOK_TITLE, BOOK_SUBJECT, BOOK_COST
FROM BOOK
WHERE (BOOK_SUBJECT = 'Middleware' OR BOOK_SUBJECT = 'Cloud')
      AND BOOK_COST > 70
ORDER BY BOOK_NUM;


-- 70
SELECT AU_ID, AU_FNAME, AU_LNAME, AU_BIRTHYEAR
FROM AUTHOR
WHERE AU_BIRTHYEAR BETWEEN 1980 AND 1989
ORDER BY AU_ID;


-- 71
SELECT BOOK_NUM, BOOK_TITLE, BOOK_SUBJECT
FROM BOOK
WHERE Upper(BOOK_TITLE) LIKE '%DATABASE%'
ORDER BY BOOK_NUM;


-- 72
SELECT PAT_ID, PAT_FNAME, PAT_LNAME
FROM PATRON
WHERE Upper(PAT_TYPE) = 'STUDENT'
ORDER BY PAT_ID;


-- 73
SELECT PAT_ID, PAT_FNAME, PAT_LNAME, PAT_TYPE
FROM PATRON
WHERE Upper(PAT_LNAME) LIKE 'C%'
ORDER BY PAT_ID;


-- 74
SELECT AU_ID, AU_FNAME, AU_LNAME
FROM AUTHOR
WHERE AU_BIRTHYEAR IS NULL
ORDER BY AU_ID;


-- 75
SELECT AU_ID, AU_FNAME, AU_LNAME
FROM AUTHOR
WHERE AU_BIRTHYEAR IS NOT NULL
ORDER BY AU_ID;


-- 76
SELECT CHECK_NUM, BOOK_NUM, PAT_ID, CHECK_OUT_DATE, CHECK_DUE_DATE
FROM CHECKOUT
WHERE CHECK_IN_DATE IS NULL
ORDER BY BOOK_NUM;


-- 77
SELECT AU_ID, AU_FNAME, AU_LNAME, AU_BIRTHYEAR
FROM AUTHOR
ORDER BY AU_BIRTHYEAR DESC, AU_LNAME;


-- 78
SELECT Count(BOOK_NUM) AS "Number of Books"
FROM BOOK;


-- 79
SELECT Count(DISTINCT BOOK_SUBJECT) AS "Number of Subjects"
FROM BOOK;


-- 80
SELECT Count(BOOK_NUM) AS "Available Books"
FROM BOOK
WHERE PAT_ID IS NULL;


-- 81
SELECT Max(BOOK_COST) AS "Most Expensive"
FROM BOOK;


-- 82
SELECT Min(BOOK_COST) AS "Least Expensive"
FROM BOOK;

-- 83
SELECT Count(DISTINCT PAT_ID) AS "DIFFERENT PATRONS"
FROM CHECKOUT;

-- 84
SELECT BOOK_SUBJECT, Count(*) AS "Books In Subject"
FROM BOOK
GROUP BY BOOK_SUBJECT;

-- 85
SELECT AU_ID, Count(*) AS "Books Written"
FROM WRITES
GROUP BY AU_ID
ORDER BY COUNT(*) DESC, AU_ID;

-- 86
SELECT Sum(BOOK_COST) AS "Library Value"
FROM BOOK;

-- 87
SELECT PAT_ID AS PATRON, BOOK_NUM AS BOOK, datediff(CHECK_IN_DATE, CHECK_OUT_DATE) AS "Days Kept"
FROM CHECKOUT
ORDER BY datediff(CHECK_IN_DATE, CHECK_OUT_DATE) DESC, PAT_ID, BOOK_NUM;

-- 88
SELECT PAT_ID, CONCAT(PAT_FNAME, ' ', PAT_LNAME) AS "Patron Name", PAT_TYPE
FROM PATRON
ORDER BY PAT_ID;

-- 89
SELECT BOOK_NUM, CONCAT(BOOK_TITLE, ' (', BOOK_YEAR, ')') AS BOOK, BOOK_SUBJECT
FROM BOOK
ORDER BY BOOK_NUM;

-- 90
SELECT AU_LNAME, AU_FNAME, BOOK_NUM
FROM AUTHOR JOIN WRITES ON AUTHOR.AU_ID = WRITES.AU_ID
ORDER BY AU_LNAME, AU_FNAME, BOOK_NUM;

-- 91
SELECT AU_ID, BOOK.BOOK_NUM, BOOK_TITLE, BOOK_SUBJECT
FROM BOOK JOIN WRITES ON BOOK.BOOK_NUM = WRITES.BOOK_NUM
ORDER BY BOOK.BOOK_NUM, AU_ID;

-- 92
SELECT AU_LNAME, AU_FNAME, BOOK_TITLE, BOOK_COST
FROM AUTHOR JOIN WRITES ON AUTHOR.AU_ID = WRITES.AU_ID JOIN BOOK ON WRITES.BOOK_NUM = BOOK.BOOK_NUM
ORDER BY BOOK.BOOK_NUM, AUTHOR.AU_ID;

-- 93
SELECT PATRON.PAT_ID, BOOK_NUM, PAT_FNAME, PAT_LNAME, BOOK_TITLE
FROM PATRON JOIN BOOK ON PATRON.PAT_ID = BOOK.PAT_ID
ORDER BY PAT_LNAME, BOOK_TITLE;


-- 94
SELECT PAT_ID, CONCAT(PAT_FNAME, ' ', PAT_LNAME) AS NAME, PAT_TYPE
FROM PATRON
ORDER BY Upper(PAT_TYPE), Upper(PAT_LNAME), PAT_FNAME;


-- 95
SELECT BOOK_NUM, Count(*) AS "Times Checked Out"
FROM CHECKOUT
GROUP BY BOOK_NUM
ORDER BY COUNT(*) DESC, BOOK_NUM DESC;


-- 96
SELECT AUTHOR.AU_ID, AU_FNAME, AU_LNAME, BOOK.BOOK_NUM, BOOK_TITLE
FROM AUTHOR JOIN WRITES ON AUTHOR.AU_ID = WRITES.AU_ID JOIN BOOK ON WRITES.BOOK_NUM = BOOK.BOOK_NUM
WHERE BOOK_SUBJECT = 'Cloud'
ORDER BY BOOK_TITLE, AU_LNAME;


-- 97
SELECT BOOK_NUM, BOOK_TITLE, PATRON.PAT_ID, PAT_LNAME, PAT_TYPE
FROM BOOK JOIN PATRON ON BOOK.PAT_ID = PATRON.PAT_ID
ORDER BY BOOK_TITLE;


-- 98
SELECT BOOK.BOOK_NUM, BOOK_TITLE, Count(CHECK_NUM) AS "Times Checked Out"
FROM BOOK LEFT JOIN CHECKOUT ON BOOK.BOOK_NUM = CHECKOUT.BOOK_NUM
GROUP BY BOOK.BOOK_NUM, BOOK_TITLE
ORDER BY COUNT(CHECK_NUM) DESC, BOOK_TITLE;


-- 99
SELECT BOOK.BOOK_NUM, BOOK_TITLE, Count(CHECK_NUM) AS "Times Checked Out"
FROM BOOK JOIN CHECKOUT ON BOOK.BOOK_NUM = CHECKOUT.BOOK_NUM
GROUP BY BOOK.BOOK_NUM, BOOK_TITLE
HAVING Count(CHECK_NUM) > 5
ORDER BY COUNT(CHECK_NUM) DESC, BOOK_TITLE;


-- 100
SELECT AUTHOR.AU_ID, AU_LNAME, BOOK_TITLE, CHECK_OUT_DATE, PAT_LNAME
FROM AUTHOR JOIN WRITES ON AUTHOR.AU_ID = WRITES.AU_ID JOIN BOOK ON WRITES.BOOK_NUM = BOOK.BOOK_NUM
JOIN CHECKOUT ON BOOK.BOOK_NUM = CHECKOUT.BOOK_NUM JOIN PATRON ON PATRON.PAT_ID = CHECKOUT.PAT_ID
WHERE PAT_LNAME = 'Miles' AND AU_LNAME = 'Bruer'
ORDER BY CHECK_OUT_DATE;


-- 101
SELECT PATRON.PAT_ID, PAT_FNAME, PAT_LNAME
FROM PATRON LEFT JOIN CHECKOUT ON PATRON.PAT_ID = CHECKOUT.PAT_ID
WHERE CHECK_NUM IS NULL
ORDER BY PAT_LNAME, PAT_FNAME;


-- 102
SELECT PATRON.PAT_ID, PAT_LNAME, Count(CHECK_NUM) AS "NUM CHECKOUTS", Count(DISTINCT BOOK_NUM) AS "NUM DIFFERENT BOOKS"
FROM CHECKOUT JOIN PATRON ON CHECKOUT.PAT_ID = PATRON.PAT_ID
GROUP BY PATRON.PAT_ID, PAT_LNAME
HAVING Count(CHECK_NUM) > 2
ORDER BY COUNT(DISTINCT BOOK_NUM) DESC, COUNT(CHECK_NUM) DESC, PATRON.PAT_ID;


-- 103
SELECT Round(Avg(datediff(CHECK_IN_DATE, CHECK_OUT_DATE)), 2) AS "Average Days Kept"
FROM CHECKOUT;


-- 104
SELECT PAT_ID, Round(Avg(datediff(CHECK_IN_DATE, CHECK_OUT_DATE)), 2) AS "Average Days Kept"
FROM CHECKOUT
GROUP BY PAT_ID
HAVING Count(CHECK_NUM) > 2
ORDER BY ROUND(AVG(datediff(CHECK_IN_DATE, CHECK_OUT_DATE)), 2) DESC;


-- 105
SELECT BOOK_NUM, BOOK_TITLE, BOOK_COST
FROM BOOK
WHERE BOOK_COST = (SELECT Min(BOOK_COST) FROM BOOK)
ORDER BY BOOK_NUM;


-- 106
SELECT AU_ID, AU_FNAME, AU_LNAME
FROM AUTHOR
WHERE AU_ID NOT IN (SELECT AU_ID FROM BOOK JOIN WRITES ON BOOK.BOOK_NUM = WRITES.BOOK_NUM WHERE BOOK_SUBJECT = 'Programming')
ORDER BY AU_LNAME;


-- 107
SELECT BOOK_NUM, BOOK_TITLE, BOOK.BOOK_SUBJECT, Round(AVGCOST, 2) AS "Average Subject Cost", BOOK_COST - Round(AVGCOST, 2) AS DIFFERENCE
FROM BOOK JOIN (SELECT BOOK_SUBJECT, Avg(BOOK_COST) AS AVGCOST 
		FROM BOOK BOOK2
		GROUP BY BOOK_SUBJECT) AS SUBAVGS ON BOOK.BOOK_SUBJECT = SUBAVGS.BOOK_SUBJECT
ORDER BY BOOK_TITLE;



-- 108
SELECT BOOK.BOOK_NUM, BOOK_TITLE, BOOK_SUBJECT, AU_LNAME, NUMBOOKS AS "Num Books by Author"
FROM BOOK JOIN WRITES ON BOOK.BOOK_NUM = WRITES.BOOK_NUM JOIN 
		(SELECT AUTHOR.AU_ID, AU_LNAME, Count(*) AS NUMBOOKS 
		 FROM AUTHOR JOIN WRITES ON AUTHOR.AU_ID = WRITES.AU_ID
		GROUP BY AUTHOR.AU_ID, AU_LNAME) AS AUTHBOOKS ON WRITES.AU_ID = AUTHBOOKS.AU_ID
WHERE BOOK_SUBJECT = 'Cloud'
ORDER BY BOOK_TITLE, AU_LNAME;


-- 109
SELECT Min(AVGCOST) AS "Lowest Avg Cost", Max(AVGCOST) AS "Highest Avg Cost"
FROM (SELECT BOOK_SUBJECT, Round(Avg(BOOK_COST), 2) AS AVGCOST 
FROM BOOK 
GROUP BY BOOK_SUBJECT) AS SUBAVGS;



