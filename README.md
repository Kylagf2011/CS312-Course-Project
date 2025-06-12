# CS312-Course-Project
Course Project Part 2 for CS 312 (System Administration)

## Overview
The goal of this project is to fully automate the provisioning, configuration, and deployment of a Minecraft server through AWS. In place of manually running the AWS console, or using ssh, Infrastructure as Code (IaC) tools and configuration management were used to create a deployable server.

## Tool Requirements
**OS**: Ubuntu v24.04.1  
**Terraform**: v1.12.1  
**Ansible**: core v2.18.5  
**AWS CLI**: v2.27.25  
**nmap**: v7.94SVN  
**Python**: v3.12.3  

## Tool Installation
### Ubuntu
#### On Windows
1. Open Windows PowerShell as an administrator
2. Run:
```
   wsl --install -d Ubuntu 24.04
```
4. Restart the Windows PowerShell
5. Reopen the Windows Powershell
6. Verify the installation using:
```
   wsl --list --verbose
```
7. Open the Ubuntu Terminal using `ubuntu2404.exe` in the PowerShell

#### On Mac
1. Install a Virtualization Software ([VitualBox](https://www.virtualbox.org/))
2. Download the Ubuntu ISO image ([Ubuntu ISO](https://ubuntu.com/download/desktop))
3. Launch VirtualBox
4. Select the "New" button
5. Select Linux and Ubuntu 64-bit as the operating types
6. Configure the memory and storage acording to Ubuntu specifications ([Ubuntu VirtualBox Tutorial](https://ubuntu.com/tutorials/how-to-run-ubuntu-desktop-on-a-virtual-machine-using-virtualbox#1-overview))
7. Attatch the Ubuntu ISO image to the virtual machine

### Terraform
1. Ensure the system is up to date by and the `gnupg`, `software-properties-common`, and `curl` packages are installed by running:
```
   sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
```
3. Install the HashiCorp GPG key by running:
```
   wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
```
5. Verify the key's fingerpint by running:
```
  gpg --no-default-keyring \
  --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
  --fingerprint
```
5. Add the HashiCorp repository to the system by running:
```
   echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list`
```
8. Download the package information by running:
```
   sudo apt update
```
10. Install Terraform from a the new repository by running:
```
  sudo apt-get install terraform
```
12. Verify that Terraform is working by opening a new terminal running:
```
  terraform -help
```

### Ansible
1. Update system package:
```
   sudo apt update
```
2. Install dependencies:
```
   sudo apt install software-properties-common
```
3. Add the Ansible PPA:
```
   sudo add-apt-repository --yes --update ppa:ansible/ansible
```
4. Install Ansible:
```
   sudo apt install ansible
```
5. Verify the installation:
```
   ansible --version
```

### AWS CLI
**If a version of AWS CLI is already installed, remove it by running `sudo yum remove awscli`**
1. Download the installation file by running:
```
   curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
```
3. Install unzip onto the Ubuntu machine using
```
   sudo apt install unzip
```
5. Unzip the installer:
```
   unzip awscliv2.zip
```
7. Run the install program:
```
   sudo ./aws/install
```
9. Verify the installation using:
```
   aws --version
```

### Python
1. Update the system:
```
sudo apt update -y && sudo apt upgrade -y
```
2. Check for previous versions of Python:
```
python -V
```
3. Install Python 3 using the following command:
```
sudo apt install python3
```
4. Verify Installation:
```
python3 -V
```

### Nmap
1. Update the package list:
```
sudo apt update
```
2. Install the Nmap package:
```
sudo apt install nmap
```
3. Verify Nmap Installation:
```
nmap -v
```

## Credentials & Environment Variables
### AWS Credentials
Locate the Access Key Id, the Secret Key, and the Session Token (if using learner lab)

### Environment Variables
To set the variables within the environment, run the following in the main directory of the project:
```
aws configure set aws_access_key_id "your_key"
aws configure set aws_secret_access_key "your_secret"
aws configure set aws_session_token "your_session" #only if using the learner lab
```

## Steps to Starting the Server
1. Open the Ubuntu Terminal
2. Either download the files from this repository and make sure they are in the Ubuntu system **OR** use the following command:
```
git clone https://github.com/Kylagf2011/CS312-Course-Project <name_new_directory>
```
3. Navigate into the Minecraft sever directory
4. Following the steps from the *Environment Variables* section, set up credentials information
5. Navigate into the *Terraform* directory
6. Run the following command to build the AWS EC2 instance:
```
terraform init
```
7. Then run the following to actually apply the configuration and type yes when prompted to:
```
terraform apply
```
8. Make note of the Public IP that is printed out so you do not have to track it down later
9. Navigate back to the main project directory
10. Navigate to the *Ansible* directory
11. the `setup.yml` is used to setup Java and the other Minecraft essentials. A secondary file `ansible.cfg` has been setup to configure any flags that are used for ease of execution. To run it, simply use the following:
```
ansible-playbook setup.yml
```
12. To ensure that the Minecraft port (25565) is open and listening, run the following command:
```
nmap -sV -Pn -p T:25565 $(grep -v '\[' inventory.ini)
```
13. Open Minecraft
14. Select Multiplayer
15. Select Direct Connection
16. Enter to Public IP that you saved earlier. If you did not save it use the following command to obtain it:
```
terraform output public_ip
```

## Pipeline Diagram
```mermaid
graph TD
    A[Your Local Machine: Ubuntu 24.04] --> B[Terraform: Provision EC2]
    B --> C[Terraform: Configure Security Group (Port 25565 Open)]
    C --> D[Ansible: Install Java, Download Minecraft Server, Enable Systemd Service]
    D --> E[Minecraft Server Running and Accessible]
```

## Sources
1. [Install WSL](https://learn.microsoft.com/en-us/windows/wsl/install#install-wsl-command)
2. [Install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
3. [Install Ansible](https://docs.ansible.com/ansible/latest/installation_guide/installation_distros.html#id6)
4. [Install or Update AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
5. [Install Python](https://www.rosehosting.com/blog/how-to-install-python-on-ubuntu-24-04/)
6. [Install Nmap](https://www.stationx.net/install-nmap-ubuntu/)
