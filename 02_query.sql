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
-- What is the volatility of different cryptocurrencies?

SELECT name, symbol, 
       MAX(quote_USD_price) - MIN(quote_USD_price) as price_volatility
FROM APIPull
GROUP BY name, symbol
ORDER BY price_volatility DESC;



