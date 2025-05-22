import requests
from libs.config import (
    BASE_URL, COUNTRY_CODE, INDICATORS,
    DATE_RANGE, PER_PAGE, FORMAT, SOURCE
)

def fetch_wdi():
    indicators_param = ";".join(INDICATORS)
    url = f"{BASE_URL}/country/{COUNTRY_CODE}/indicator/{indicators_param}"
    all_records = []
    page = 1

    while True:
        params = {
            "date": DATE_RANGE,
            "per_page": str(PER_PAGE),
            "page": str(page),
            "format": FORMAT,
            "source": str(SOURCE),
        }
        resp = requests.get(url, params=params)
        resp.raise_for_status()
        payload = resp.json()
        meta, records = payload[0], payload[1]
        all_records.extend(records)
        total_pages = int(meta.get("pages", 1))
        if page >= total_pages:
            break
        page += 1
    return all_records