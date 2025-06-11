# CS312-Course-Project
Course Project Part 2 for CS 312 (System Administration)

## Overview
The goal of this project is to fully automate the provisioning, configuration, and deployment of a Minecraft server through AWS. In place of manually running the AWS console, or using ssh, Infrastructure as Code (IaC) tools and configuration management were used to create a deployable server.

## Tool Requirements
OS: Ubuntu v24.04.1  
Terraform: v1.12.1  
Ansible: core v2.18.5  
AWS CLI: v2.27.25  
nmap: v7.94SVN  
Python: v3.13.3  

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

## Sources
1. [Install WSL](https://learn.microsoft.com/en-us/windows/wsl/install#install-wsl-command)
2. [Install Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
3. [Install Ansible](https://docs.ansible.com/ansible/latest/installation_guide/installation_distros.html#id6)
4. [Install or Update AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
