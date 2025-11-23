#!/bin/bash
set -e # exit on error

echo "Running terraform Apply........"
cd terraform
terraform init
terraform apply -auto-approve

terraform output -json instance_public_ips > output.json

sleep 15

echo -e "\n infrastructure created!!"