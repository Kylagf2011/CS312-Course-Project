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
2. Run `wsl --install`
3. Restart the Windows PowerShell
4. Reopen the Windows Powershell
5. Run `wsl --install -d Ubuntu 24.04.1`
