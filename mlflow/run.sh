#!/bin/bash

poetry run mlflow server \
    --backend-store-uri $DB_URI \
    --default-artifact-root s3://$S3_BUCKET \
    --host 0.0.0.0
    --port 5000
