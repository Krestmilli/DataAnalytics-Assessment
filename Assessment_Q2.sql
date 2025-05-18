WITH MonthlyTransactions AS (
    SELECT
        u.id AS customer_id,
        u.name AS customer_name,
        DATE_FORMAT(sa.transaction_date, '%Y-%m') AS transaction_month,
        COUNT(sa.id) AS monthly_transactions
    FROM
        users_customuser u
    JOIN
        savings_savingsaccount sa ON u.id = sa.owner_id
    GROUP BY
        u.id, u.name, DATE_FORMAT(sa.transaction_date, '%Y-%m')
),
AverageTransactions AS (
    SELECT
        customer_id,
        customer_name,
        AVG(monthly_transactions) AS average_monthly_transactions
    FROM
        MonthlyTransactions
    GROUP BY
        customer_id, customer_name
),
CategorizedTransactions AS (
    SELECT
        customer_id,
        customer_name,
        average_monthly_transactions,
        CASE
            WHEN average_monthly_transactions >= 10 THEN 'High Frequency'
            WHEN average_monthly_transactions >= 3 AND average_monthly_transactions < 10 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category
    FROM
        AverageTransactions
)
SELECT
    frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(average_monthly_transactions), 2) AS avg_transactions_per_month
FROM
    CategorizedTransactions
GROUP BY
    frequency_category
ORDER BY
    CASE
        WHEN frequency_category = 'High Frequency' THEN 1
        WHEN frequency_category = 'Medium Frequency' THEN 2
        ELSE 3
    END;
