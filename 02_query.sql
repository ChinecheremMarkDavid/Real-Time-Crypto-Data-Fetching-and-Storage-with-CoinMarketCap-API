-- For the SQL Part, i will be perfoming some exploratory data analysis to learn more about the data, ask questions, get answers
-- try and get as much information as i can from the dataset.





-- Question 1
-- Which cryptocurrency has the highest market capitalization?

SELECT top 100 name, symbol, max(quote_USD_market_cap) as max_market_cap
FROM APIPull
GROUP BY name, symbol
ORDER BY max_market_cap DESC;


-- Question 2
-- How does the supply of each cryptocurrency (circulating supply vs. max supply)
-- compare, and which currencies are nearing their supply limits?

SELECT name, symbol, circulating_supply, max_supply,
       (circulating_supply / max_supply) * 100 as supply_percentage
FROM APIPull
WHERE max_supply IS NOT NULL
  AND max_supply != 0
ORDER BY supply_percentage DESC;

-- Question 3
-- What are the most popular use cases for cryptocurrencies based on tags (e.g., platform, marketplace, stablecoin)?

SELECT name, symbol, 
       MAX(quote_USD_price) - MIN(quote_USD_price) as price_volatility
FROM APIPull
GROUP BY name, symbol
ORDER BY price_volatility DESC;

-- Question 4
-- which platforms or cryptocurrencies have the best staking rewards

SELECT tags, COUNT(*) as frequency
FROM APIPull
GROUP BY tags
ORDER BY frequency DESC;

-- Question 5
-- Which cryptocurrencies are gaining market share in terms of trading volume?

SELECT name, symbol, quote_USD_volume_24h
FROM APIPull
ORDER BY quote_USD_volume_24h DESC;

-- Question 6
-- Which cryptocurrency has shown the most significant price growth over a specific period?

SELECT name, symbol, 
       (MAX(quote_USD_price) - MIN(quote_USD_price)) / MIN(quote_USD_price) * 100 as percentage_growth
FROM APIPull
GROUP BY name, symbol
ORDER BY percentage_growth DESC;

-- Other Exploratory Data Analysis i performed on the dataset

-- Price Fluctuations Across Cryptocurrencies:
SELECT name, symbol, date_added, quote_USD_price
FROM APIPull
ORDER BY date_added, name;

-- Correlation Between Price and Circulating Supply:
SELECT name, symbol, circulating_supply, quote_USD_price,
       (circulating_supply / max_supply) * 100 as supply_percentage
FROM APIPull
WHERE max_supply IS NOT NULL
AND max_supply != 0
ORDER BY supply_percentage DESC;

-- Top Cryptocurrencies by Rank:
SELECT distinct name, symbol, cmc_rank
FROM APIPull
ORDER BY cmc_rank ASC;

-- Historical Price Trends for Different Platforms:
SELECT platform#name, name, symbol, date_added, quote_USD_price
FROM APIPull
WHERE platform#name IS NOT NULL
ORDER BY platform#name, date_added;

-- Identify coins with infinite supply
SELECT name, symbol, circulating_supply, max_supply
FROM APIPull
WHERE infinite_supply = 'TRUE'
ORDER BY circulating_supply DESC;



-- The visualizations for this queries and more will be created using power bi.
-- A snapshot and link to the dashboard will be shared here



