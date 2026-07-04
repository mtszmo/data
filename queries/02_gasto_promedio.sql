SELECT 
    SUM(payment_value) / COUNT(DISTINCT order_id) AS gasto_promedio_por_compra
FROM order_payments;