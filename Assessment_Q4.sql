SELECT
    u.id AS customer_id,  
    CONCAT(u.first_name, ' ', u.last_name) AS name, 
    TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()) AS tenure_months, 
    COUNT(sa.id) AS total_transactions, 
    ROUND(  
        (COUNT(sa.id) / TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE())) * 12 * (AVG(sa.amount) * 0.001),
        2
    ) AS estimated_clv  
FROM
    users_customuser u  
JOIN
    savings_savingsaccount sa ON u.id = sa.owner_id  
GROUP BY
    u.id, u.first_name, u.last_name, u.date_joined  
ORDER BY
    estimated_clv DESC;  