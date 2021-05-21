#!/bin/bash

set -euf -o pipefail

if [ $# -lt 3 ]
  then
    echo "Not enough arguments supplied"
    echo "Usage:"
    echo "./backup.sh /path/of/directory/to/backup backup-bucket-name aws-profile-name"
fi

DIR_TO_BACKUP=${1-foo}
BUCKET_NAME=${2-bar}
AWS_PROFILE=${3-baz}

TEMPDIR=$(mktemp -d)
DATE=$(date +%Y-%m-%d_%H-%M-%S)

pushd $TEMPDIR
cp -R ${DIR_TO_BACKUP} .
tar -czf ${DATE}.tar.gz $(ls)
aws s3 cp ${DATE}.tar.gz s3://${BUCKET_NAME} --profile ${AWS_PROFILE}
popd

rm -rf $TEMPDIR