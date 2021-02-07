# DevOps Test Task: Sergii Burtovyi
&nbsp;
______________
The task is to deploy a **Web Application** (LB + Web + DB) to **AWS** with help of **Ansible** and **Terraform**.
_____________

&nbsp;
## Requirements
The following tools have to be installed to create the infrastructure.
Only specified versions were used to test the IaaC. Thus, hardcoded as *required*.

| Tool | Version | Purpose of use |
| ------ | ------ | ------ |
| [Packer](https://learn.hashicorp.com/tutorials/packer/getting-started-install#installing-packer) | 1.5.6 | Builds new AMI on top of basic one, customizing it with help of other specified tools.
| [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) | 2.9.11 | Packer uses it as a provider, which makes necessary configuration management during AMI creation: updates OS, installs LAMP stack, etc.
| [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli) | 0.14.5 | Builds all necessary infrastructure in AWS, based on our new AMI: LoadBalancer, AutoScaling Group, Security Group, etc.
| [Make](https://www.gnu.org/software/make/) | 3.81+ | Automation tool, which is used to hide all complexity of working with IaaC.
| [Git](https://git-scm.com/downloads) | 2.20.1+ | Repository for the IaaC.

No need to install it, but worth to mention:
| Tool | Version | Purpose of use |
| ------ | ------ | ------ |
| [Goss](https://github.com/aelsabbahy/goss) | Installed automatically by Packer on an instance, started from the AMI | Packer uses it as a provider, which makes necessary tests of installed/configured software during AMI creation: it can check that necessary processes are running, that it were configured as OS services, that necessary files are present and its permissions are correct, etc.
&nbsp;
&nbsp;
&nbsp;

## Deploy WebServer into AWS
### 0. Sign in to your AWS account
Correct AWS security credentials should be already present on your local PC.
For example, it could be one of:
- temporary ones, presented via `assume-role`;
- constant ones, configured via `aws configure`;
- constant ones, added manually to `~/.aws/credentials`.

### 1. Make a preparation
> Default values from `variables.mk` are in use. Update it if needed.

Let's build the AMI with all necessary software installed and configured.
```
make ami
```

### 2. Create the infrastructure
> Default values from `terraform/instances/webserver/terraform.tfvars` are in use. Update it if needed.

Once the AMI was successfully built, we can use it to start EC2 instances for our infrastructure.
&nbsp;
See the plan of infrasctructure creation.
```
make terraformplan
```
Create the infrastructure itself.
```
make terraformapply
```
&nbsp;
The output of the command above shows a DNS name you can now use to go to the WebServer.
For example:
```
...
Outputs:

webserver_dns_name = "websrv20210204195426035700000002-1583778335.eu-west-1.elb.amazonaws.com"
```

&nbsp;
## Remove WebServer from AWS
Once deployed infrastructure is no longer needed, remove it.
```
make terraformdestroy
```

&nbsp;
## Notes
- The infrastructure is created within default VPC and subnets of chosen AWS region;
- By default, the access via HTTP (port 80) is the only one allowed;
- Find appropriate steps in **How-To's** section if direct SSH access (port 22) is needed in addition.

&nbsp;
## How-To's
### SSH to the server
By default, only HTTP traffic is allowed. There's additional option to SSH, tho. 
P.S. It's better to have separate bastion server, but for simplifying purposes for this DevOps Test Task connection directrly to the EC2 instance is in use (as it has Public IP, provided by default subnet, which is in use for simplifying puproses as well).
&nbsp;
To enable this option, the following should be done.
1) Before building AMI, update `variables.mk` as follows:
```
webserver_ssh_acces_is_needed="yes"
webserver_ssh_username="<some_user>"
webserver_ssh_public_key="<public_part_of_ssh_key>"
```
This will add ssh key for your user to the server.
&nbsp;
2) Before working with Terraform, update `terraform/instances/webserver/main.tf` as follows:
```
enable_ssh_access_in_sg  = [1]
```
This will open port 22 in the SecurityGroup, applied to the server.
&nbsp;

&nbsp;
## TO-DO
While this DevOps Test Task was made with the least effort needed to make it running in its current form, at least following steps might be considered as a next levels of improvements:
- create custom VPC and subnets (as a minimum, default subnets provide servers with Public IP, which is not what you want when the principle of least privilege/access is in use. SecutiryGroup controlls all access, tho);
- add DNS name, pointing to LB;
- make it available via HTTPS by adding a certificates, terminating on LB;
- make it available via HTTPS only, by redirecting a traffic from port 80 (if any) to port 443;
- add bastion to access EC2 instance via SSH;
- place Web and DB part of the WebServer on separate EC2 instances;
- put TF state file to some shared place (s3 bucket, for example);
- encrypt files with sensitive data in the WebServer git repository.



