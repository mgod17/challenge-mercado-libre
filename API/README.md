## 📋 Descripción
Extrae cotizaciones de divisas (USD, EUR, BTC) desde AwesomeAPI, normaliza los datos y los almacena en CSV.

## 🚀 Quick Start

1. Clona el repositorio:
   ```bash
   git clone https://github.com/mgod17/challenge-mercado-libre
   cd API
   ```
2. Crea y activa un entorno virtual:
   ```bash
   python -m venv venv  
   venv\Scripts\activate     
   ```
3. Instala dependencias:
   ```bash
   pip install -r requirements.txt
   ```
4. Configura tu token API en `.env`:
   ```ini
   API_TOKEN=tu_api_token_aquí
   ```
5. Ejecuta el script:
   ```bash
   python extraccion_monedas.py
   ```

> 📄 Se creará `datos_monedas.csv` con las cotizaciones normalizadas.

## ⚙️ Requisitos

- Python 3.8+  
- requests  
- python-dotenv  
- pandas  
- pytz

## 📂 Estructura de Archivos

- `extraccion_monedas.py` — Script principal.  
- `requirements.txt` — Lista de dependencias.  
- `datos_monedas.csv` — Salida de datos.  
- `.env` — Variables de entorno (no incluir en Git).  
- `README.md` — Documentación.

## 📝 Licencia