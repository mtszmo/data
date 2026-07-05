SELECT 
    COALESCE(t.product_category_name_english, p.product_category_name) AS categoria,
    ROUND(SUM(oi.price), 2) AS total_ingresos_generados
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
LEFT JOIN product_category_name_translation t ON p.product_category_name = t.product_category_name
GROUP BY categoria
ORDER BY total_ingresos_generados DESC
LIMIT 10;