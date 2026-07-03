import os
import pandas as pd
from sqlalchemy import create_engine, text 
from pathlib import Path

# Configurar la conexión a tu MySQL local
engine = create_engine('mysql+pymysql://newuser:abc@localhost/olist_ecommerce')

# Definir la carpeta donde se guardó los CSV descargados
home = Path.home()
carpeta_csv = home / "dataset_destino"

orden_carga = [
    ('product_category_name_translation.csv', 'product_category_name_translation'),
    ('olist_geolocation_dataset.csv', 'geolocation'),
    ('olist_customers_dataset.csv', 'customers'),
    ('olist_sellers_dataset.csv', 'sellers'),
    ('olist_products_dataset.csv', 'products'),
    ('olist_orders_dataset.csv', 'orders'),
    ('olist_order_items_dataset.csv', 'order_items'),
    ('olist_order_payments_dataset.csv', 'order_payments'),
    ('olist_order_reviews_dataset.csv', 'order_reviews')
]

print("Iniciando la ingesta de datos a MySQL...")

# Abrir conexión directa manejada por SQLAlchemy
with engine.begin() as conn:
    
    # Apagar las reglas de claves foráneas temporalmente
    conn.execute(text("SET FOREIGN_KEY_CHECKS = 0;"))
    
    for archivo, tabla in orden_carga:
        ruta_completa = os.path.join(carpeta_csv, archivo)
        
        if not os.path.exists(ruta_completa):
            print(f"No se encontró el archivo {archivo}. Saltando...")
            continue
            
        print(f"Cargando {archivo} en la tabla '{tabla}'...")
        
        df = pd.read_csv(ruta_completa)
        
        # Limpieza de duplicados por seguridad
        df = df.drop_duplicates()
        
        # Subida de datos usando la conexión 'conn' 
        df.to_sql(
            name=tabla, 
            con=conn, 
            if_exists='append', 
            index=False, 
            chunksize=10000
        )
        
    # Reactivamos las reglas al terminar el bucle
    conn.execute(text("SET FOREIGN_KEY_CHECKS = 1;"))

print("Ingesta de datos completada exitosamente en la base de datos 'olist_ecommerce'.")