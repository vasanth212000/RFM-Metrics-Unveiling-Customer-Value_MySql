-- Create the `rfm_data2` table structure
CREATE TABLE `rfm_data2` (
  `CustomerID` int DEFAULT NULL,
  `PurchaseDate` datetime DEFAULT NULL,
  `TransactionAmount` double DEFAULT NULL,
  `ProductInformation` text,
  `OrderID` int DEFAULT NULL,
  `Location` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Copy data from `rfm_data` to `rfm_data2`
INSERT INTO rfm_data2
SELECT * FROM rfm_data;

-- Verify the data in `rfm_data2`
SELECT * FROM rfm_data2;

-- Show the structure of the `rfm_data2` table
DESCRIBE rfm_data2;

-- Modify the `PurchaseDate` column type from datetime to date
ALTER TABLE rfm_data2
MODIFY COLUMN PurchaseDate DATE;

-- Create a temporary table `temp_rfm` to calculate RFM metrics
CREATE TEMPORARY TABLE temp_rfm AS
WITH recency AS (
    SELECT CustomerID, 
           MAX(PurchaseDate) AS Last_purchase_date,
           DATEDIFF(CURRENT_DATE, MAX(PurchaseDate)) AS recency_days
    FROM rfm_data2
    GROUP BY CustomerID
),
frequency AS (
    SELECT CustomerID, 
           COUNT(*) AS frequent_purchase 
    FROM rfm_data2
    GROUP BY CustomerID
),
monetary AS (
    SELECT CustomerID, 
           ROUND(SUM(TransactionAmount), 2) AS total_amount 
    FROM rfm_data2
    GROUP BY CustomerID
)
SELECT r.CustomerID,
       r.Last_purchase_date, 
       r.recency_days, 
       f.frequent_purchase, 
       m.total_amount
FROM recency AS r
JOIN frequency AS f ON r.CustomerID = f.CustomerID
JOIN monetary AS m ON f.CustomerID = m.CustomerID;

-- Calculate and display statistics for recency, frequency, and monetary values
SELECT MIN(recency_days) AS min_recency_days, 
       MAX(recency_days) AS max_recency_days, 
       AVG(recency_days) AS avg_recency_days,
       MIN(frequent_purchase) AS min_frequent_purchase, 
       MAX(frequent_purchase) AS max_frequent_purchase, 
       AVG(frequent_purchase) AS avg_frequent_purchase,
       MIN(total_amount) AS min_total_amount, 
       MAX(total_amount) AS max_total_amount, 
       AVG(total_amount) AS avg_total_amount
FROM temp_rfm;

-- Create a temporary table `rfm_score` with RFM scores
CREATE TEMPORARY TABLE rfm_score AS
SELECT CustomerID,
       CASE 
           WHEN recency_days <= 30 THEN 'HIGH'
           WHEN recency_days BETWEEN 31 AND 60 THEN 'MEDIUM'
           ELSE 'LOW'
       END AS recency_score,
       CASE 
           WHEN frequent_purchase >= 10 THEN 'HIGH'
           WHEN frequent_purchase BETWEEN 6 AND 9 THEN 'MEDIUM'
           ELSE 'LOW'
       END AS frequency_score,
       CASE 
           WHEN total_amount >= 500 THEN 'HIGH'
           WHEN total_amount BETWEEN 200 AND 499 THEN 'MEDIUM'
           ELSE 'LOW'
       END AS monetary_score
FROM temp_rfm;

-- Display the contents of the `rfm_data2` table
SELECT * FROM rfm_data2;

-- Display the contents of the `temp_rfm` table
SELECT * FROM temp_rfm;

-- Display the contents of the `rfm_score` table
SELECT * FROM rfm_score;
