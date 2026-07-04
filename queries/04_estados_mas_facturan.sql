SELECT 
    c.customer_state AS estado,
    SUM(op.payment_value) AS total_facturado
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_payments op ON o.order_id = op.order_id
GROUP BY c.customer_state
ORDER BY total_facturado DESC
LIMIT 5;