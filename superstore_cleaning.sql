USE super_store_data;
SELECT * FROM Sample;
ALTER TABLE Sample RENAME TO super_store_info;
CREATE TABLE super_store_info_raw LIKE super_store_info;
INSERT INTO super_store_info_raw SELECT * FROM super_store_info;

SELECT * FROM super_store_info;
DESCRIBE super_store_info;
UPDATE super_store_info
SET `Ship Date` = STR_TO_DATE(`Ship Date`, '%m/%d/%Y');
UPDATE super_store_info
SET `Order Date`= STR_TO_DATE(`Order Date`, '%m/%d/%Y');

#CHECKING FOR DUPLICATES 

WITH ROW_NUM AS(
SELECT *, ROW_NUMBER()OVER(PARTITION BY `ROW ID`,`Order ID`,`Order Date`,`Ship Date`,`Ship Mode`,`Customer ID`,`Customer Name`,
`Customer Name`,Segment, Country,City, State, `Postal Code`, Category, `Sub-Category`, `Product Name`, Sales, 
Quantity, Discount, Profit) AS rownum FROM super_store_info)

SELECT * FROM ROW_NUM WHERE rownum>1;

#NO DUPLICATES FOUND

#STANDARDISING DATA

SELECT 	* FROM super_store_info
WHERE 
	`Customer Name` <> TRIM(`Customer Name`) OR
    Segment <> TRIM( Segment) OR
    Country <> TRIM(Country) OR
    City <> TRIM(City) OR
    State<>TRIM(State) OR
    Category<>TRIM( Category) OR
    `Sub-Category`<>TRIM(`Sub-Category`) OR
     `Product Name`<>TRIM(`Product Name`);
	
UPDATE super_store_info SET 
`Customer Name`=TRIM(`Customer Name`),
  Segment=TRIM(Segment),
  Country =TRIM(Country),
  City=TRIM(City),
 State=TRIM(State), 
 Category=TRIM(Category),
 `Sub-Category`=TRIM(`Sub-Category`),
 `Product Name`=TRIM(`Product Name`);
 
SELECT DISTINCT(`Customer Name`) FROM super_store_info ORDER BY `Customer Name`;
SELECT DISTINCT(Segment) FROM super_store_info ORDER BY Segment;
SELECT DISTINCT(Country) FROM super_store_info ORDER BY Country;
SELECT DISTINCT(City) FROM super_store_info ORDER BY City;
SELECT DISTINCT(State) FROM super_store_info ORDER BY State;
SELECT DISTINCT(Category) FROM super_store_info ORDER BY Category;
SELECT DISTINCT(`Sub-Category`) FROM super_store_info ORDER BY `Sub-Category`;
SELECT DISTINCT(`Product Name`) FROM super_store_info ORDER BY `Product Name`;


#CHECKING FOR NULLS 

SELECT 
	SUM(`Row ID` IS NULL) AS ROWID_NULL,
    SUM(`Order ID` IS NULL) AS ORDERID_NULL, 
    SUM(`Order Date` IS NULL) AS ORDERDATE_NULL, 
    SUM(`Ship Date` IS NULL) AS SHIPDATE_NULL, 
    SUM(`Ship Mode` IS NULL) AS SHIPMODE_NULL, 
    SUM(`Customer ID` IS NULL) AS CUSTOMERID_NULL, 
    SUM(`Customer Name` IS NULL) AS CUSTOMERNAME_NULL, 
    SUM(Segment IS NULL) AS SegmentNULL, 
    SUM(Country IS NULL) AS CountryNULL, 
    SUM(City IS NULL) AS CityNULL, 
    SUM(State IS NULL) AS StateNULL, 
    SUM(`Postal Code` IS NULL) AS postalcodeNULL, 
    SUM(Region IS NULL) AS regionNULL, 
    SUM(`Product ID` IS NULL) AS productIDNULL, 
    SUM(Category IS NULL) AS CategoryNULL,
    SUM(`Sub-Category` IS NULL) AS subcategoryNULL, 
    SUM(`Product Name` IS NULL) AS productnameNULL, 
    SUM(Sales IS NULL) AS SalesNULL, 
    SUM(Quantity IS NULL) AS QuanitityNULL, 
    SUM(Discount IS NULL) AS DiscountNULL, 
    SUM(Profit IS NULL) AS ProfitNULL
FROM super_store_info;

SELECT sales FROM super_store_info;

SELECT * FROM super_store_info;

SELECT * FROM super_store_info WHERE `Product Name` LIKE  '%�%';
UPDATE super_store_info SET  `Product Name`=REPLACE(`Product Name`,'�','');
    



    

    
    