
gcloud auth list

export PROJECT_ID=$(gcloud config get-value project)

export PROJECT_ID=$DEVSHELL_PROJECT_ID

bq mk --dataset ecommerce

gsutil mb gs://$DEVSHELL_PROJECT_ID/


curl -LO https://raw.githubusercontent.com/Techcps/GSP-Short-Trick/master/Ingesting%20New%20Datasets%20into%20BigQuery/products.csv

curl -LO https://raw.githubusercontent.com/Techcps/GSP-Short-Trick/master/Ingesting%20New%20Datasets%20into%20BigQuery/techcps.csv


gsutil cp products.csv gs://$DEVSHELL_PROJECT_ID/

gsutil cp techcps.csv gs://$DEVSHELL_PROJECT_ID/


bq --location=US load --source_format=CSV --autodetect --skip_leading_rows=1 ecommerce.products gs://$DEVSHELL_PROJECT_ID/products.csv

bq --location=US load --source_format=CSV --autodetect --skip_leading_rows=1 ecommerce.products gs://data-insights-course/exports/products.csv


bq query --use_legacy_sql=false \
"
#standardSQL
SELECT
  *,
  SAFE_DIVIDE(orderedQuantity,stockLevel) AS ratio
FROM
  ecommerce.products
WHERE
# include products that have been ordered and
# are 80% through their inventory
orderedQuantity > 0
AND SAFE_DIVIDE(orderedQuantity,stockLevel) >= .8
ORDER BY
  restockingLeadTime DESC
"

cat > external_table_definition.json <<EOF_CP
{
  "sourceFormat": "GOOGLE_SHEETS",
  "sourceUris": ["https://docs.google.com/spreadsheets/d/1Pyr2ifVgC82eCDNxBKgEXc33fkzMTPa2/edit?usp=sharing"],
  "schema": {
    "fields": [
      {"name": "column1", "type": "STRING"},
      {"name": "column2", "type": "INTEGER"},
      {"name": "column3", "type": "FLOAT"}
    ]
  }
}
EOF_CP

bq mk --external_table_definition=external_table_definition.json ecommerce.products_comments

