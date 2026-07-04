SELECT 
    DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m') AS mes_venta,
    SUM(op.payment_value) AS total_vendido
FROM orders o
JOIN order_payments op ON o.order_id = op.order_id
WHERE o.order_status NOT IN ('canceled', 'unavailable') 
GROUP BY mes_venta
ORDER BY mes_venta;