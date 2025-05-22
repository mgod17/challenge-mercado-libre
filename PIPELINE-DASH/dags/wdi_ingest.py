from airflow import DAG
from airflow.operators.python import PythonOperator
from airflow.providers.google.cloud.transfers.local_to_gcs import LocalFilesystemToGCSOperator
from airflow.providers.google.cloud.transfers.gcs_to_bigquery import GCSToBigQueryOperator
from datetime import datetime, timedelta
import json  
from libs.wdi_client import fetch_wdi
from libs.config     import PROJECT_ID, DATASET, TABLE_RAW

default_args = {
    "depends_on_past": False,
    "email_on_failure": False,
    "retries": 2,
    "retry_delay": timedelta(minutes=5),
}

with DAG(
    dag_id="wdi_ingest_pipeline",
    default_args=default_args,
    schedule_interval="0 6 * * MON",
    start_date=datetime(2025, 5, 1),
    catchup=False,
    tags=["wdi", "ingest"],
) as dag:

    def _fetch_to_local(**kwargs):
        records = fetch_wdi()
        local_path = "/tmp/wdi_raw.ndjson"
        with open(local_path, "w", encoding="utf-8") as f:
            for item in records:
                row = {
                    "series_code":     item["indicator"]["id"],
                    "series_name":     item["indicator"]["value"],
                    "country_code":    item["country"]["id"],
                    "country_name":    item["country"]["value"],
                    "countryiso3code": item.get("countryiso3code"),
                    "date":            f"{item['date']}-01-01",
                    "value":           item.get("value"),
                    "unit":            item.get("unit", ""),
                    "obs_status":      item.get("obs_status", ""),
                    "decimal":         item.get("decimal"),
                }
                f.write(json.dumps(row, ensure_ascii=False) + "\n")
        return local_path

    fetch_json = PythonOperator(
        task_id="fetch_json",
        python_callable=_fetch_to_local,
        do_xcom_push=True,
    )

    upload_raw = LocalFilesystemToGCSOperator(
        task_id="upload_raw",
        src="{{ ti.xcom_pull(task_ids='fetch_json') }}",
        dst="raw/wdi_{{ ds_nodash }}.ndjson",
        bucket="abstract-gizmo-441020-v4-wdi-raw",
    )

    load_to_bq = GCSToBigQueryOperator(
        task_id="load_to_bq",
        bucket="abstract-gizmo-441020-v4-wdi-raw",
        source_objects=["raw/wdi_{{ ds_nodash }}.ndjson"],
        destination_project_dataset_table=f"{PROJECT_ID}.{DATASET}.{TABLE_RAW}",
        source_format="NEWLINE_DELIMITED_JSON",
        write_disposition="WRITE_TRUNCATE",
        create_disposition="CREATE_NEVER",
    )

    fetch_json >> upload_raw >> load_to_bq
