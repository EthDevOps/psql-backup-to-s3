#!/bin/bash
echo "Starting PostgreSQL backup to S3..."
echo "Setup minio client..."
mc alias set s3 ${S3_ENDPOINT} ${S3_ACCESSKEY} ${S3_SECRETKEY}
echo "Backup database..."
PGPASSWORD=${PSQL_PASS} pg_dump -h ${PSQL_HOST} -U ${PSQL_USER}  -C ${PSQL_NAME} > /backups/backup.sql
echo "Compress backup..."
gzip /backups/backup.sql
echo "Copy to S3..."
mc cp /backups/backup.sql.gz s3/${S3_BUCKET}/db-${PSQL_NAME}-$(date "+%Y-%m-%dT%H-%M-%S").sql.gz
echo "Notify HC..."
curl ${HC_UR}
echo "done."
