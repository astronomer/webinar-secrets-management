# webinar-secrets-management

This repo contains an example DAG and configurations that were used in an Astronomer webinar on Secrets Management with Airflow 2.0. 
 
### Use Case
The example highlights the concept of using a hybrid appraoch to Secrets Managment by using Workload Identity (IAM Role Integration), Hashicorp Vault, and both the Airflow Metastore DB and Environment Variables. 

Tasks:
1. **bqload** - This shows using Workload Identity as it does not specify a connection ID. And the one it defauts to is empty.
2. **conn_tak** - This pulls a Connection from Vault and prints it to STDOUT.
2. **var_task** - This pulls a Variable stored in Environment Variables (prempting the one in the Metastore DB). You will need to configure the same variable with different vaules in both places to test.

### Getting Started
The easiest way to run these example DAGs is to use the Astronomer CLI to get an Airflow instance up and running locally:

 1. [Install the Astronomer CLI](https://www.astronomer.io/docs/cloud/stable/develop/cli-quickstart)
 2. Clone this repo somewhere locally and navigate to it in your terminal
 3. Initialize an Astronomer project by running `astro dev init`
 4. Start Airflow locally by running `astro dev start`
 5. Navigate to localhost:8080 in your browser and you should see the tutorial DAGs there
 6. Set your Connections in [Vault](https://www.vaultproject.io/docs/platform/k8s/helm) (or other Alternative Secrets Bakend).
 7. Set your Variables in the Airflow Metastore DB and/or Environment Variables. (Try putting them in Vault to see what happens.)
 8. Conifgure [Workload Identity](https://cloud.google.com/kubernetes-engine/docs/how-to/workload-identity) for GCP.
