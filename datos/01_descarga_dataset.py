import os
import zipfile
from kaggle.api.kaggle_api_extended import KaggleApi

# Autenticar con la API
api = KaggleApi()
api.authenticate()

# Definir el dataset 
dataset = 'olistbr/brazilian-ecommerce'
path_descarga = './dataset_destino'

# Descarga el archivo zip
api.dataset_download_files(dataset, path=path_descarga, unzip=True)
