SELECT 
    c.customer_state AS estado,
    ROUND(AVG(DATEDIFF(o.order_estimated_delivery_date, o.order_delivered_customer_date)), 1) AS promedio_dias_anticipacion,
    MAX(DATEDIFF(o.order_delivered_customer_date, o.order_estimated_delivery_date)) AS maximo_retraso_historico_dias
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
WHERE o.order_status = 'delivered' 
  AND o.order_delivered_customer_date IS NOT NULL
  AND o.order_estimated_delivery_date IS NOT NULL
GROUP BY c.customer_state
ORDER BY promedio_dias_anticipacion ASC;