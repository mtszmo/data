SELECT 
    c.customer_unique_id AS cliente,
    
    -- ¿Hace cuántos días fue la última compra? (Recencia)
    DATEDIFF(CURRENT_DATE, MAX(o.order_purchase_timestamp)) AS dias_desde_ultima_compra,
    
    -- ¿Cuántas veces compró en la plataforma? (Frecuencia)
    COUNT(DISTINCT o.order_id) AS cantidad_compras,
    
    -- ¿Cuánto dinero total dejó en el histórico? (Monetario)
    ROUND(SUM(op.payment_value), 2) AS total_gastado

FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_payments op ON o.order_id = op.order_id
WHERE o.order_status NOT IN ('canceled', 'unavailable')
GROUP BY c.customer_unique_id
ORDER BY total_gastado DESC;