


bq query --use_legacy_sql=false "
CREATE OR REPLACE TABLE
  taxirides.${TABLE_NAME} AS
SELECT
  (tolls_amount + fare_amount) AS ${FARE_AMOUNT},
  pickup_datetime,
  pickup_longitude AS pickuplon,
  pickup_latitude AS pickuplat,
  dropoff_longitude AS dropofflon,
  dropoff_latitude AS dropofflat,
  passenger_count AS passengers
FROM
  taxirides.historical_taxi_rides_raw
WHERE
  RAND() < 0.001
  AND trip_distance > ${TRIP_DISTANCE_VALUE}
  AND fare_amount >= ${FARE_AMOUNT_VALUE}
  AND pickup_longitude > -78
  AND pickup_longitude < -70
  AND dropoff_longitude > -78
  AND dropoff_longitude < -70
  AND pickup_latitude > 37
  AND pickup_latitude < 45
  AND dropoff_latitude > 37
  AND dropoff_latitude < 45
  AND passenger_count > ${PASSENGER_COUNT_VALUE}
"



# Construct the SQL query with variable interpolation
SQL_QUERY=$(cat <<EOF_CP
CREATE OR REPLACE MODEL taxirides.${MODEL_NAME}
TRANSFORM(
  * EXCEPT(pickup_datetime),
  ST_Distance(ST_GeogPoint(pickuplon, pickuplat), ST_GeogPoint(dropofflon, dropofflat)) AS euclidean,
  CAST(EXTRACT(DAYOFWEEK FROM pickup_datetime) AS STRING) AS dayofweek,
  CAST(EXTRACT(HOUR FROM pickup_datetime) AS STRING) AS hourofday
)
OPTIONS(input_label_cols=['${FARE_AMOUNT}'], model_type='linear_reg')
AS
SELECT * FROM taxirides.${TABLE_NAME}
EOF_CP
)

# Execute the query using bq command
bq query --use_legacy_sql=false "$SQL_QUERY"



bq query --use_legacy_sql=false "
CREATE OR REPLACE TABLE taxirides.2015_fare_amount_predictions
  AS
SELECT * FROM ML.PREDICT(MODEL taxirides.${MODEL_NAME},(
  SELECT * FROM taxirides.report_prediction_data)
)"



