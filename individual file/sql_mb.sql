-- creating new empty table house_price_data and fixing the type of each column
CREATE TABLE house_price_data (
    id INT,
    date DATE,
    bedrooms INT,
    bathrooms INT,
    sqft_living INT,
    sqft_lot INT,
    floors INT,
    waterfront INT,
    view INT,
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

-- importig the data from csv file with Tabla Data Import Wizard

-- select all the data from the table. 
select * from house_price_data;

-- drop the column date from the database
alter table house_price_data
drop column date;

-- counting how many row has the data  
select count(*)
from house_price_data;

-- unique values of bedrooms, bathrooms, floors, conditions and grade 
select distinct bedrooms
from house_price_data
order by bedrooms asc;

select distinct bathrooms
from house_price_data
order by bathrooms asc;

select distinct floors
from house_price_data
order by floors asc;

select distinct condition_rating
from house_price_data
order by condition_rating asc;

select distinct grade
from house_price_data
order by grade asc;

-- data orderd by decreasing order of the price
select * from house_price_data
order by price desc;

-- top 10 most expensive houses
select id from house_price_data
order by price desc
limit 10;

-- average price of all the properties
select avg(price) from house_price_data;

-- average price of the houses grouped by 2bedrooms
select bedrooms, avg(price) as avg_price_2bd from house_price_data
where bedrooms = 2
group by bedrooms ;

--  average sqft_living of the houses grouped by bedrooms
select bedrooms, avg(sqft_living) as avg_sqft from house_price_data
group by bedrooms 
order by bedrooms asc;

-- average price of the houses with a waterfront and without a waterfront
select waterfront , avg(price) as avg_price_waterfront from house_price_data
group by waterfront ;

-- correlation between the columns condition and grade
select condition_rating, avg(grade) as avg_grade
from house_price_data
group by condition_rating;

-- what are the options available for the costumer that is intestred only on houses with 3 or 4 bds, mort than 3 bathrooms, no waterfront, conditions 3 at leat, grade 5 at least, price less 300000 
select *
from house_price_data
where bedrooms in (3, 4)
  and bathrooms > 3
  and floors = 1
  and waterfront = 0
  and condition_rating >= 3
  and grade >= 5
  and price < 300000;

-- properties whose prices are twice more than the average of all the properties
select *
from house_price_data
where price > 2 * (select avg(price) from house_price_data);

-- create a view of the same query
create view propertiesTwiceAbovetheAvg as
select *
from house_price_data
where price > 2 * (select avg(price) from house_price_data);

-- What is the difference in average prices of the properties with three and four bedrooms?
-- 1st step calculate the avg per typology
select bedrooms, avg(price) as avg_price_per_bedrooms from house_price_data
where bedrooms in (3, 4)
group by bedrooms;

-- 2nd step calculate the difference in average prices between the two typologies.
select
    (select avg(price) from house_price_data where bedrooms = 4) -
    (select avg(price) from house_price_data where bedrooms = 3) as price_difference;


-- different locations where properties are available in the data
select distinct zipcode from house_price_data;

--  list of all the properties that were renovated (the value of 'yr_renovated' is set to 0 for properties that have not been refurbished)
select * from house_price_data
where yr_renovated > 0;

-- Provide the details of the property that is the 11th most expensive properties
select *
from house_price_data
order by price desc
limit 1 offset 10;
