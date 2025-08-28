# Objective

The code base will help the user to plan & bootstrap infrastructure on AWS along with basic CI/CD. The motive of this code base is to have a Dockerized Node js app (monolith) running securely. It is also manageable, easy to configure and secure design for his infrastructure & CI/CD.

### The following deliverables have been identified:
A VPC setup on AWS which includes public & private subnets (multi-AZ). Public subnets should be used for only exposing required services. This VPC should be managed via Terraform.

#### Following instances will be needed:
+ **Jenkins** - For CI purpose.
+ **App** - For running the containerized version of the app.
+ **Bastion** - In a public subnet for accessing private instances.
+ **ALB** for accessing App and Jenkins.
+ A **Jenkins** pipeline to build nodejs app image & deploy it on the app instance.

## Task 1:
**Make sure AWS CLI, Terraform are installed and configured with full access in your linux machine**
1. Create a folder named 'terraform' in your home directory.
    - Copy all .tf files from this repository to terraform folder.
    - Now run **terraform init** command
    - Run **terraform plan**
    - Run **terraform apply**
    - 
#### The above commands will perform the following tasks:
1. Initialize a bucket in s3 for the backend state store using Terraform. This bucket will be used later in this project to use the state files of Terraform.
2. **Create the following:** 
   - AWS VPC,
   - 1 IGW,
   - 1 NAT-GW in AZ-a, 
   - Subnets (2 public & 2 private, 1 each in AZ-a &b), 
   - Route Tables for both subnets
   - Bastion SG - Allow self ip to ssh to ‘bastion’ instance and allow all egress.
   - Private SG - Allow all incoming traffic from within VPC and all egress.
   - Public SG - Allow incoming to port 80 from self IP and all egress.
   - Create a key pair that will be used by the users to access the EC2 instances.
   - Create 3 ec2 instances with the names - bastion, Jenkins, app- using Ubuntu-20 official AMI.
   - Only the ‘bastion’ instance should be directly accessible over the internet.

## Task 2:
**ssh to bastion host**
+ Create a folder named 'Ansible'
+ Copy 'docker_insall.yml' file from this repository to 'Ansible' directory.
+ Now type **sudo nano /etc/ansible/hosts**.
+ Add IP addresses of Jenkins and App hosts in hosts file.
+ Now type **ansible-playbook docker_install.yaml**

---
### To be completed
