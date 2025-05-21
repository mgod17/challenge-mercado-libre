import os
import requests
import pandas as pd
from dotenv import load_dotenv
from datetime import datetime
import pytz

DEFAULT_PAIRS = ["USD-BRL", "EUR-BRL", "BTC-BRL"]
API_URL = "https://economia.awesomeapi.com.br/json/last/{pairs}?token={token}"


def fetch_rates(pairs, token):
    url = API_URL.format(pairs=",".join(pairs), token=token)
    resp = requests.get(url)
    resp.raise_for_status()
    return resp.json()


def to_dataframe(data):
    rows = []
    for v in data.values():
        dt = datetime.strptime(v["create_date"], "%Y-%m-%d %H:%M:%S")
        dt = pytz.utc.localize(dt)
        rows.append({
            "moneda_base": v["code"],
            "moneda_destino": v["codein"],
            "precio_compra": float(v["bid"]),
            "precio_venta": float(v["ask"]),
            "fecha_hora": dt.strftime("%Y-%m-%d %H:%M:%S")
        })
    return pd.DataFrame(rows)


def save_csv(df, path="datos_monedas.csv"):
    df.to_csv(path, index=False)
    print(f"Guardado {len(df)} registros en {path}")


def main():
    load_dotenv()
    token = os.getenv("API_TOKEN")
    df = to_dataframe(fetch_rates(DEFAULT_PAIRS, token))
    save_csv(df)


if __name__ == "__main__":
    main()
