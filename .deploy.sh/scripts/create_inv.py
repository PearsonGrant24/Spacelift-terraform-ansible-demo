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
            inv.write(f"{ip}\n")
        inv.write("\n")

    
    # adddd globalvariables
    inv.write("[all:vars]\n")
    inv.write("ansible_user=ubuntu\n")
    inv.write("ansible_ssh_private_key_file=~/.ssh/appKey\n")
    inv.write("ansible_python_interpreter=/usr/bin/python3 \n\n\n")

    # Add per-env variables
    for env in data.keys():
        inv.write(f"[{env}:vars]\n")
        inv.write(f"env={env}\n\n\n")

print(f"Inventory created successfully , check at {inventory_path}")        
