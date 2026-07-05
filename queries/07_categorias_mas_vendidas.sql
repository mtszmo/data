SELECT 
    COALESCE(t.product_category_name_english, p.product_category_name) AS categoria,
    COUNT(oi.order_item_id) AS unidades_vendidas
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
LEFT JOIN product_category_name_translation t ON p.product_category_name = t.product_category_name
GROUP BY categoria
ORDER BY unidades_vendidas DESC
LIMIT 10;