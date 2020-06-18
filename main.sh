#!/bin/sh
echo "$INPUT_SECRETS" > /temp.json
gcloud auth activate-service-account --key-file=/temp.json
project_id=$(grep -o '"project_id": "[^"]*' /temp.json | grep -o '[^"]*$')
rm /temp.json
# $1 arg corresponds to inputs.bucket_pattern
# $2 arg corresponds to inputs.bucket_suffix and is either dev/prod
bucket=$(gsutil ls -p $project_id | grep "gs://.*$1-$2/$")
echo "Syncing bucket: $bucket"
gsutil -m rsync -r -c -d /github/workspace $bucket