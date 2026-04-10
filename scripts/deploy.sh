#!/bin/bash

set -e

ENVIRONMENT=$1
COMMAND=$2  # plan or apply

if [ -z "$ENVIRONMENT" ] || [ -z "$COMMAND" ]; then
  echo "Usage: ./scripts/deploy.sh <environment> <command>"
  echo "Example: ./scripts/deploy.sh dev plan"
  exit 1
fi

if [ "$ENVIRONMENT" != "dev" ] && [ "$ENVIRONMENT" != "prod" ]; then
  echo "Error: environment must be dev or prod"
  exit 1
fi

if [ "$COMMAND" != "plan" ] && [ "$COMMAND" != "apply" ]; then
  echo "Error: command must be plan or apply"
  exit 1
fi

cd environments/$ENVIRONMENT

echo "Running terraform init..."
terraform init

echo "Running terraform $COMMAND for $ENVIRONMENT..."

if [ "$COMMAND" == "apply" ]; then
  terraform apply -auto-approve
else
  terraform plan -no-color
fi

echo "Done."