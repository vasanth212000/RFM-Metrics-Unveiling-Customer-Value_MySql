# RFM Analysis Project

## Overview

This project demonstrates the use of MySQL to perform RFM (Recency, Frequency, Monetary) Analysis, a powerful marketing analytics technique used to identify and categorize a company's most valuable customers. The analysis focuses on examining customer purchasing behaviors to aid in targeted marketing strategies.

## Project Steps

1. **Data Preparation**:
   - The dataset includes fields such as Customer ID, Purchase Date, and Transaction Amount.
   - Purchase Date is formatted as a date, and Transaction Amount is formatted as a numeric value.

2. **Data Import**:
   - A SQL table is created to match the structure of the dataset.
   - Data is imported into the SQL environment for analysis.

3. **RFM Metric Calculation**:
   - **Recency (R)**: Measures how recently a customer made a purchase.
   - **Frequency (F)**: Measures how often a customer makes a purchase.
   - **Monetary (M)**: Measures the total money spent by a customer.

4. **RFM Score Computation**:
   - SQL queries are used to compute each RFM metric.
   - Metrics are combined to generate RFM scores for each customer.

5. **Customer Segmentation**:
   - Customers are segmented based on their RFM scores using SQL CASE statements to classify them into different categories (e.g., loyal customers, at-risk customers).

## Dataset

The dataset for this project can be downloaded from [here](#). It includes customer transaction data essential for performing RFM Analysis.

## Tools Used

- **MySQL**: For database management and executing SQL queries to calculate RFM metrics.
- **SQL**: For data manipulation and analysis.

## How to Run

1. Set up a MySQL environment.
2. Import the dataset into the SQL database.
3. Execute the provided SQL scripts to perform RFM analysis and segment customers.

## Conclusion

This project provides a comprehensive approach to using SQL for RFM Analysis, which is crucial for understanding customer behavior and optimizing marketing efforts.

## Author

[Your Name]

