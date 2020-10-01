--Overarching Goals - What drives the most units sold?
---1!. Categorizing the Data 
---A. Understand which products sheerly sold the most units
-- select * from [summer-products]
-- Order By units_sold desc

--Notes:
--- 1. Units sold is not exact number, looks like they're rounded to nearest 10,000ish value
---2. May want to check on the discounts that are playing into effect here

---B. Order products by retail price
-- select * from [summer-products]
-- Order by retail_price DESC
---Notes
---1. Of top 20 only looks like 2 of them sold around 20000 units

---C. Create column measuring difference between retail price and price
---select title_orig, (retail_price - price) Discount, Units_Sold from [summer-products]
---Order by Discount desc

---Notes
---1. Can't tell anything here until we put this on a scatterplot
---a.Make a scatterplot in Jupyter

---D. Organize by Ratings
-- select title_orig, units_sold, rating, rating_count from [summer-products] 
-- Where rating_count > 1000
-- Order by rating DESC
---Notes
---a. Put this into a scatterplot as well. How are higher ratings correlated with units sold?

---E. How does ad boosting support sales?

-- select count(*) from [summer-products]
-- where uses_ad_boosts = 0

-- select count(*) from [summer-products]
-- where uses_ad_boosts = 1

---Notes: Many more products that don't use ad boosts than those that do. If regressing against each other may need to account for this.

-- select avg(units_sold) avg_unit_sales from [summer-products]
-- where uses_ad_boosts = 0

-- select avg(units_sold) avg_unit_sales from [summer-products]
-- where uses_ad_boosts = 1

-- select * from [summer-products]

---2!. Deeper dive into how above average prices, ratings perform in terms of units sold
---A. How do above average price items sell?
-- select title_orig, price, (select avg(price) from [summer-products]) average_price, units_sold from [summer-products]
-- where price > (select avg(price) from [summer-products])
-- order by price desc
---Notes
---1. Scatter plot this
---B. How do above average rating items sell (Restricting for rating count above 1000)?
-- select title_orig, price, rating, (select avg(rating) from [summer-products]) average_rating,rating_count, units_sold from [summer-products]
-- where rating > (select avg(rating) from [summer-products]) and rating_count > 1000
-- order by rating desc
--Note: By running a regression later in this project I was able to determine price does not have a significant effect on sales
---3! Correlation + MLR CSVs
-- Update [summer-products] Set has_urgency_banner = 0 Where has_urgency_banner = NULL

-- select title, units_sold, price, (retail_price - price) discount, uses_ad_boosts, rating_count, merchant_rating_count, 
-- rating, merchant_rating, rating_five_count,product_variation_inventory, shipping_option_price, countries_shipped_to, has_urgency_banner, product_color from [summer-products]
-- Where product_color IN ('black','white','yellow','pink','blue','red','green','grey','purple','armygreen')
-- select count(product_color) product_color_count from [summer-products]
-- Group by product_color
--4! Diving into Color's effect on unit sales
-- select TOP 10 product_color, count(product_color)product_color_count,sum(units_sold) color_units_sold, sum(price) color_price from [summer-products]
-- group by product_color
-- order by product_color_count desc
-- select * from [summer-products]

-- Alter Table [dbo].[summer-products] ADD ColorBin int 
-- GO

-- Select ColorBin From [summer-products]


--1: Create bins for top 10 color selections
-- Update [summer-products] SET [summer-products].[ColorBin] = case
-- When product_color = 'black' then 1
-- When product_color = 'white' then 2
-- When product_color = 'yellow' then 3
-- When product_color = 'pink' then 4
-- When product_color = 'blue' then 5
-- When product_color = 'red' then 6
-- When product_color = 'green' then 7
-- When product_color = 'grey' then 8
-- When product_color = 'purple' then 9
-- When product_color = 'armygreen' then 10
-- else 11

-- End

-- select title, units_sold, price, (retail_price - price) discount, uses_ad_boosts, rating_count, merchant_rating_count, 
-- rating, merchant_rating, rating_five_count,product_variation_inventory, shipping_option_price, countries_shipped_to, has_urgency_banner, product_color, ColorBin from [summer-products]
-- Where ColorBin != 11

-- select  ColorBin, count(ColorBin) from [summer-products]
-- Group by ColorBin
--2: Understand which colors have highest average number of units sold
-- select ColorBin, sum(units_sold) color_units_sold, avg(units_sold) color_average_sold from [summer-products]
-- Where ColorBin != 11
-- Group by ColorBin
-- Order by color_average_sold desc
--Note: We can see here that the top 5 in terms of average are purple, grey, black, white, and blue
--I'll make dummies of those 5 to see what their effects are on prices

-- select ColorBin, sum(units_sold)/(select count(ColorBin) from [summer-products] Where ColorBin = 1 Group By ColorBin)
-- from [summer-products]
-- Where ColorBin = 1
-- Group By ColorBin

-- Alter Table [dbo].[summer-products]
-- ADD is_purple int
-- ADD is_grey int
-- ADD is_black int
-- ADD is_white int
-- ADD is_blue int

-- GO

-- select * from [summer-products]

-- Update [summer-products] SET [summer-products].[is_grey] = case
-- When ColorBin = 8 then 1
-- else 0
-- END

-- Update [summer-products] SET [summer-products].[is_black] = case
-- When ColorBin = 1 then 1
-- else 0
-- END

-- Update [summer-products] SET [summer-products].[is_white] = case
-- When ColorBin = 2 then 1
-- else 0
-- END

-- Update [summer-products] SET [summer-products].[is_blue] = case
-- When ColorBin = 5 then 1
-- else 0
-- END

-- Update [summer-products] SET [summer-products].[is_purple] = case
-- When ColorBin = 9 then 1
-- else 0
-- END


-- select units_sold, (retail_price - price) discount, uses_ad_boosts, rating_count, merchant_rating_count, 
--   product_variation_inventory,  has_urgency_banner, product_color, ColorBin, is_black, is_grey, is_purple, is_white, is_blue from [summer-products]