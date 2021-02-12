DBURI=mysql://root:${MYSQL_ROOT_PASSWORD}@mysql:3306/mlflow

test $MLFLOW_MIGRATION && poetry run mlflow db upgrade $DBURI

poetry run mlflow server \
    --backend-store-uri  $DBURI \
    --default-artifact-root s3://${S3_BUCKET} \
    --host 0.0.0.0 \
    --port 5000
