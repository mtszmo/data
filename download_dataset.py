import os
import zipfile
from kaggle.api.kaggle_api_extended import KaggleApi

# 1. Autenticar con la API
api = KaggleApi()
api.authenticate()

# 2. Definir el dataset 
dataset = 'olistbr/brazilian-ecommerce'
path_descarga = './dataset_destino'

# Descarga el archivo zip
api.dataset_download_files(dataset, path=path_descarga, unzip=True)
print(f"¡Listo! Dataset guardado y descomprimido en: {path_descarga}")