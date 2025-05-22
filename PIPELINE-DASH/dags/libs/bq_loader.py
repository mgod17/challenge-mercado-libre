import logging
from google.cloud import bigquery
from google.api_core.exceptions import GoogleAPICallError, RetryError

logger = logging.getLogger(__name__)

def load_to_bq(project_id: str, dataset_id: str, table_id: str, rows: list[dict]):
    client = bigquery.Client(project=project_id)
    table_ref = client.dataset(dataset_id).table(table_id)

    errors = client.insert_rows_json(table_ref, rows)
    if errors:
        for err in errors:
            logger.error("Error al insertar fila en BigQuery: %s", err)
        raise RuntimeError(f"Fallaron {len(errors)} inserciones en BigQuery.")
