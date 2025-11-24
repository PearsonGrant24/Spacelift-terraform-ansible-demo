import json

# path
open_terraform_output = "terraform/output.json"
inventory_path = "ansible/inventory/hosts.ini"

# 
with opem(open_terraform_output, "r") as f:
    data = json.load(f)

# 
with open(inventory_path, "w") as inv:
    for env, ips in data.items():
        inv.write(f"[{env}]\n")
        for ip in ips:
            inv.write(f"")
