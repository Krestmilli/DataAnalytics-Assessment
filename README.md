# DataAnalytics-Assessment

This repository contains the SQL queries for the data analytics assessment.  It includes solutions for the following questions:

* High-Value Customers with Multiple Products
* Transaction Frequency Analysis
* Account Inactivity Alert
* Customer Lifetime Value (CLV) Estimation

##   Repository Structure

The repository contains the following files:

* Assessment_Q1.sql: SQL query for identifying high-value customers with multiple products.
* Assessment_Q2.sql: SQL query for analyzing transaction frequency.
* Assessment_Q3.sql: SQL query for flagging inactive accounts.
* Assessment_Q4.sql: SQL query for estimating customer lifetime value.
* README.md: This file, providing an overview of the repository.

##   Per-Question Explanations

###   Question 1: High-Value Customers with Multiple Products

The query identifies customers who have both a savings and an investment plan.

* *Tables Used*: users_customuser, savings_savingsaccount, and plans_plan.
* *Logic*:
    1.  Join the tables to link customers to their savings accounts and plans.
    2.  Use conditional COUNT statements to count the number of savings and investment plans for each customer.
    3.  Calculate the total deposits by summing the confirmed amounts for savings and the amounts for investment plans.
    4.  Filter for customers who have at least one savings plan and one investment plan.
    5.  Order the results by total deposits in descending order.

###   Question 2: Transaction Frequency Analysis

The query analyzes customer transaction frequency and categorizes them.

* *Tables Used*: users_customuser, savings_savingsaccount.
* *Logic*:
    1.  Calculate the monthly transaction count for each customer.
    2.  Calculate the average monthly transaction count for each customer.
    3.  Categorize customers into "High Frequency," "Medium Frequency," and "Low Frequency" based on their average monthly transactions using a CASE statement.
    4.  Count the number of customers in each category and calculate the average transactions per month for each category.
    5.  Order the results by frequency category.

###   Question 3: Account Inactivity Alert

The query identifies active accounts with no inflow transactions for over one year.

* *Tables Used*: plans_plan, savings_savingsaccount.
* *Logic*:
    1.  Join the tables to link plans to their transactions.
    2.  Filter for active plans (savings or investments).
    3.  Determine the last transaction date for each plan using COALESCE to handle plans with no transactions.
    4.  Calculate the number of days since the last transaction.
    5.  Filter for plans with more than 365 days of inactivity.
    6.  Order the results by inactivity days.

###   Question 4: Customer Lifetime Value (CLV) Estimation

The query estimates CLV for each customer.

* *Tables Used*: users_customuser, savings_savingsaccount.
* *Logic*:
    1.  Calculate account tenure in months.
    2.  Calculate the total number of transactions for each customer.
    3.  Calculate the estimated CLV using the formula:  CLV = (total_transactions / tenure) \* 12 \* avg_profit_per_transaction, where profit_per_transaction is 0.1% of the transaction value.
    4.  Order the results by estimated CLV in descending order.

##   Challenges

* "I had some challenges with correctly identifying the inflow and outflow transactions, and ensuring that the amounts were correctly aggregated. I addressed this by carefully reviewing the table schemas and using CASE statements within the SUM functions to differentiate between transaction types."
* "I also had challenges with filtering using the HAVING clause, but I was able to overcome that. Additionally, the name column was initially null, and I figured out that I needed to concatenate the 'first_name' and 'last_name' columns to get the full name. I also ensured that the final CLV value was rounded to two decimal places for better readability."

##   Author

Okoronkwo Ifeanyi Eric
ifeanyiokoronkwo52@gmail.com
[2025-05-18]
