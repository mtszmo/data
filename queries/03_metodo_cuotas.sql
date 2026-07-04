SELECT 
    payment_type AS metodo_de_pago,
    COUNT(order_id) AS cantidad_transacciones,
    ROUND(AVG(payment_installments), 1) AS promedio_cuotas
FROM order_payments
GROUP BY payment_type
ORDER BY cantidad_transacciones DESC;