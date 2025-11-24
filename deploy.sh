#!/bin/bash
set -e  # exit on error


echo "Running terraform Apply........"
cd terraform
terraform init
terraform apply -auto-approve

terraform output -json instance_public_ips > output.json



echo -e "\n📄 Generating Ansible Inventory..."
cd ..
python3 scripts/create_inv.py

echo -e "\n Sleeping for 15 seconds for Instance Status Check"
sleep 15

echo -e "\n🧩 Running Ansible Playbook..."
cd ansible/
ansible-playbook playbook.yml

echo -e "\n infrastructure created!!"