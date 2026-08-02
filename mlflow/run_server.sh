DBURI=mysql+pymysql://root:${MYSQL_ROOT_PASSWORD}@mysql:3306/mlflow

test $MLFLOW_MIGRATION && mlflow db upgrade $DBURI

mlflow server \
    --backend-store-uri  $DBURI \
    --default-artifact-root s3://${S3_BUCKET} \
    --host 0.0.0.0 \
    --port 5000
