from airflow import DAG
from airflow.operators.dummy import DummyOperator
from airflow.operators.python import PythonOperator
from datetime import datetime
from airflow.hooks.base_hook import BaseHook
from airflow.models import Variable
from airflow.providers.google.cloud.transfers.gcs_to_bigquery import GCSToBigQueryOperator


def get_conn(**kwargs):
    conn = BaseHook.get_connection(kwargs['my_conn_id'])
    print(f"Password: {conn.password}, Login: {conn.login}, URI: {conn.get_uri()}, Host: {conn.host}")

def get_var(**kwargs):
    print(f"{kwargs['var_name']} {Variable.get(kwargs['var_name'])}")
    

with DAG('example_secrets_dag', start_date=datetime(2021, 1, 1), schedule_interval=None) as dag:

    start = DummyOperator(
        task_id='start'
    )

    conn_task = PythonOperator(
        task_id='conn-task',
        python_callable=get_conn,
        op_kwargs={'my_conn_id': 'smtp_default'},
    )

    var_task = PythonOperator(
        task_id='var-task',
        python_callable=get_var,
        op_kwargs={'var_name': 'hello'}
    )

    bq_load_task = GCSToBigQueryOperator(
        task_id='bqload',
        bucket=Variable.get('bucket_secret'),
        source_objects=['astro_word_count.csv'],
        destination_project_dataset_table=Variable.get('bqtable_secret'),
        skip_leading_rows=1,
        schema_fields=[
        {'name': 'word', 'type': 'STRING'},
        {'name': 'count', 'type': 'INT64'},
        ],
        write_disposition='WRITE_TRUNCATE'
    )


    start >> [conn_task, var_task, bq_load_task]