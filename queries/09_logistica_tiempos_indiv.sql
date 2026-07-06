SELECT 
    o.order_id,
    o.customer_id,
    c.customer_state,
    o.order_estimated_delivery_date,
    o.order_delivered_customer_date,
    DATEDIFF(o.order_delivered_customer_date, o.order_estimated_delivery_date) AS dias_anticipacion,
    r.review_score
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_reviews r ON o.order_id = r.order_id
WHERE o.order_status = 'delivered' 
  AND o.order_delivered_customer_date IS NOT NULL;