#!/bin/bash

S3_BUCKET=$1
S3_PREFIX=$2

touch dummy.txt
aws s3 cp dummy.txt s3://$S3_BUCKET/$S3_PREFIX/
aws s3 rm --recursive --exclude dummy.txt s3://$S3_BUCKET/$S3_PREFIX/

aws s3 cp --recursive data/minio/bucket/current/model/ s3://$S3_BUCKET/$S3_PREFIX/model/
aws s3 cp --recursive data/minio/bucket/current/ip/ s3://$S3_BUCKET/$S3_PREFIX/ip/
aws s3 cp data/minio/bucket/current/training_params.yml s3://$S3_BUCKET/$S3_PREFIX/
aws s3 rm s3://$S3_BUCKET/$S3_PREFIX/dummy.txt