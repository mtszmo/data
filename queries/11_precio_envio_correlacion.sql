SELECT 
    oi.order_id AS orden,
    oi.product_id AS producto,
    oi.price AS precio,
    oi.freight_value AS costo_del_transporte,
    p.product_weight_g AS peso_producto_gramos,
    -- Volumen del producto en cm³
    (p.product_length_cm * p.product_height_cm * p.product_width_cm) AS volumen_producto_cm3
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id;