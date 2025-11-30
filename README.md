# 🚀 Terraform + Ansible on AWS 

🚀 New DevOps Project Drop: Fully Automated AWS Infrastructure with Terraform, Ansible
 
After some time focusing on learning and growth, I’m excited to share a new DevOps project I’ve been building — one that brings together Infrastructure as Code, automated configuration management, and best-practice deployment workflows.
This project simulates a real production environment and includes:

🔧 Infrastructure Automation (Terraform)
• VPC, subnets, EC2 provisioning
• Secure networking and reusable modules
• Automated, repeatable environment creation

🛠️ Configuration Management (Ansible)
• Server bootstrapping
• Automated package installation
• App deployment using structured playbooks
• Handling real-world issues like inventory parsing, SSH access, Python installation, etc.

☁️ AWS Cloud Architecture
• Compute
• Networking
• Security
• Automation from scratch



PROJECT_ROOT/
│
├─ terraform/
│  ├── main.tf                # root calling modules (vpc, security, keypair, ec2)
│  ├── providers.tf
│  ├── variables.tf
│  ├── outputs.tf             # includes module.ec2.public_ips_by_env output
│  └── modules/
│      ├── vpc/
│      │   ├── main.tf
│      │   ├── variables.tf
│      │   └── outputs.tf
│      ├── security/
│      │   ├── main.tf
│      │   ├── variables.tf
│      │   └── outputs.tf
│      ├── keypair/
│      │   ├── main.tf
│      │   ├── variables.tf
│      │   └── outputs.tf
│      └── ec2/
│          ├── main.tf        #  locals loop (dev/stage/prod)
│          ├── variables.tf
│          └── outputs.tf     
│   
│
└── ansible/
│   ├── ansible.cfg            # inventory = ./inventory/hosts.ini, remote_user = ubuntu
│   ├── playbook.yml           
│   ├── inventory/
│   │   └── hosts.ini          # generated inventory (dev/stage/prod groups)
│   └── roles/
│       └── webserver/
│           ├── tasks/
│           │   └── main.yml   # (1) install nginx, (2) copy index-{{ env }}.html, (3) restart nginx inline
│           └── files/
│              ├── index-dev.html
│              ├── index-stage.html
│              └── index-prod.html
├── scripts/
│   └── create_inv.py  
│
└── README.md





