WITH ingresos_por_categoria AS (
    SELECT 
        p.product_category_name,
        SUM(oi.price) AS ingresos_categoria
    FROM order_items oi
    JOIN products p ON oi.product_id = p.product_id
    WHERE p.product_category_name IS NOT NULL
    GROUP BY p.product_category_name
),
ingresos_ordenados AS (
    SELECT 
        product_category_name,
        ingresos_categoria,
        SUM(ingresos_categoria) OVER (ORDER BY ingresos_categoria DESC) AS ingresos_acumulados,
        SUM(ingresos_categoria) OVER () AS ingresos_totales
    FROM ingresos_por_categoria
)
SELECT 
    product_category_name,
    ingresos_categoria,
    ROUND((ingresos_acumulados / ingresos_totales) * 100, 2) AS porcentaje_acumulado
FROM ingresos_ordenados;