--  LAB REGRESSION: Laura Ballesteros, Aída García y Monica Basile
-- Create a database called house_price_regression.
-- Create a table house_price_data with the same columns as given in the csv file. Please make sure you use the correct data types for the columns.
CREATE TABLE house_price_data (
    id INT,
    date DATE,
    bedrooms INT,
    bathrooms INT,
    sqft_living INT,
    sqft_lot INT,
    floors INT,
    waterfront INT,
    `view`INT,
    condition_rating INT,
    grade INT,
    sqft_above INT,
    sqft_basement INT,
    yr_built INT,
    yr_renovated INT,
    zipcode INT,
    lat DECIMAL(9,6),
    `long` DECIMAL(9,6),
    sqft_living15 INT,
    sqft_lot15 INT,
    price INT
);
-- Select all the data from table house_price_data to check if the data was imported correctly
SELECT * FROM house_price_data;
-- Use the alter table command to drop the column date from the database, as we would not use it in the analysis with SQL. Select all the data from the table to verify if the command worked. 
-- Limit your returned results to 10.
ALTER TABLE house_price_data DROP COLUMN date;
SELECT * FROM house_price_data LIMIT 10;
-- Use sql query to find how many rows of data you have.
SELECT COUNT(*) FROM house_price_data;
-- Now we will try to find the unique values in some of the categorical columns:
-- 1. What are the unique values in the column bedrooms?
-- 2. What are the unique values in the column bathrooms?
-- 3. What are the unique values in the column floors?
-- 4. What are the unique values in the column condition?
-- 5. What are the unique values in the column grade?
SELECT DISTINCT bedrooms FROM house_price_data;
SELECT DISTINCT bathrooms FROM house_price_data;
SELECT DISTINCT floors FROM house_price_data;
SELECT DISTINCT condition_rating FROM house_price_data;
SELECT DISTINCT grade FROM house_price_data;
-- Arrange the data in a decreasing order by the price of the house.
-- Return only the IDs of the top 10 most expensive houses in your data.
SELECT id
FROM house_price_data
ORDER BY price DESC
LIMIT 10;
-- What is the average price of all the properties in your data?
SELECT AVG(price) AS average_price
FROM house_price_data;
-- In this exercise we will use simple group by to check the properties of some of the categorical variables in our data
-- 1. What is the average price of the houses grouped by bedrooms? The returned result should have only two columns, bedrooms and Average of the prices. 0
-- Use an alias to change the name of the second column.
SELECT bedrooms, AVG(price) AS `Average of the prices`
FROM house_price_data
GROUP BY bedrooms;
-- 2. What is the average sqft_living of the houses grouped by bedrooms? The returned result should have only two columns, bedrooms and Average of the sqft_living. 
-- Use an alias to change the name of the second column.
select bedrooms, avg(sqft_living) as `Average of the sqft_living`
from house_price_data
group by bedrooms;
-- 3. What is the average price of the houses with a waterfront and without a waterfront? The returned result should have only two columns, waterfront and Average of the prices. 
-- Use an alias to change the name of the second column.
SELECT waterfront, AVG(price) AS `Average of the prices`
FROM house_price_data
GROUP BY waterfront;
-- 4. Is there any correlation between the columns condition and grade? You can analyse this by grouping the data by one of the variables and then aggregating the results of the other column. 
-- Visually check if there is a positive correlation or negative correlation or no correlation between the variables.
SELECT condition_rating, AVG(grade) AS `Average Grade`
FROM house_price_data
GROUP BY condition_rating;
-- One of the customers is only interested in the following houses: Number of bedrooms either 3 or 4; Bathrooms more than 3;
-- One Floor; No waterfront; Condition should be 3 at least, Grade should be 5 at least and Price less than 300000
-- For the rest of the things, they are not too concerned. Write a simple query to find what are the options available for them?
SELECT *
FROM house_price_data
WHERE bedrooms IN (3, 4)
    AND bathrooms > 3
    AND floors = 1
    AND waterfront = 'No'
    AND condition_rating >= 3
    AND grade >= 5
    AND price < 300000;
-- According to our database, and doing the cleaning and filtering, we see that there is no house available with the data that the client has given.

-- Your manager wants to find out the list of properties whose prices are twice more than the average of all the properties in the database.
--  Write a query to show them the list of such properties. You might need to use a sub query for this problem.
SELECT *
FROM house_price_data
WHERE price > (SELECT AVG(price) * 2 FROM house_price_data);
-- Since this is something that the senior management is regularly interested in, create a view of the same query.
CREATE VIEW expensive_properties AS 
SELECT *
FROM house_price_data
WHERE price > (SELECT AVG(price) * 2 FROM house_price_data);
-- Most customers are interested in properties with three or four bedrooms. What is the difference in average prices of the properties with three and four bedrooms?
SELECT AVG(price) AS average_price, bedrooms
FROM house_price_data
WHERE bedrooms IN (3, 4)
GROUP BY bedrooms;
-- What are the different locations where properties are available in your database? (distinct zip codes)
SELECT DISTINCT zipcode
FROM house_price_data;
-- Show the list of all the properties that were renovated.
SELECT *
FROM house_price_data
WHERE yr_renovated > 0;
-- Provide the details of the property that is the 11th most expensive property in your database.
SELECT *
FROM house_price_data
ORDER BY price DESC
LIMIT 1 OFFSET 10;
