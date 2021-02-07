# DevOps Test Task: Sergii Burtovyi
&nbsp;
______________
#### The task
To deploy a **Web Application** (LB + Web + DB) to **AWS** with help of **Ansible** and **Terraform**.

#### The solution
One of the possible solutions is to build AMI with all necessary software installed/configured and than use it to run EC2 instances required.
_____________

&nbsp;
## Requirements
The following tools have to be installed to create the infrastructure.\
Only specified versions were used to test the IaaC.\
Thus, every specific version from below is hardcoded as *required*.

| Tool | Version | Version hardcoded | Purpose of use |
| ------ | ------ | ------ | ------ |
| [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) | 2.9.11 | Y | Packer uses it as a provider, which makes necessary configuration management during AMI creation: updates OS, installs LAMP stack, etc.
| [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli) | 0.14.5 | Y | Builds all necessary infrastructure in AWS, based on our new AMI: LoadBalancer, AutoScaling Group, Security Group, etc.
| [Packer](https://learn.hashicorp.com/tutorials/packer/getting-started-install#installing-packer) | 1.5.6 | Y | Builds new AMI on top of basic one, customizing it with help of other specified tools.
| [Goss Packer Provisioner](https://github.com/YaleUniversity/packer-provisioner-goss) | 0.3.0+ | N | Provider for the Packer, that allows to run [Goss](https://github.com/aelsabbahy/goss) tests on an AMI during its creation: are necessary processes running? were it configured as OS services? are necessary files present and its permissions are correct? etc.
| [Make](https://www.gnu.org/software/make/) | 3.81+ | N | Automation tool, which is used to hide all complexity of working with IaaC.
| [Git](https://git-scm.com/downloads) | 2.20.1+ | N | Repository for the IaaC.


&nbsp;
&nbsp;
## Deploy WebServer into AWS
### 0. Sign in to your AWS account
Correct AWS security credentials should be already present on your local PC.\
For example, it could be one of:
- temporary ones, presented via `assume-role`;
- constant ones, configured via `aws configure`;
- constant ones, added manually to `~/.aws/credentials`.

### 1. Make a preparation
> Default values from [variables.mk](https://github.com/propalparolnapervom/sergiiburtovyi-devops-test-task/blob/main/variables.mk) are in use. Update it if needed.

Let's build the AMI with all necessary software installed and configured.
```
make ami
```

### 2. Create the infrastructure
> Default values from [terraform/instances/webserver/terraform.tfvars](https://github.com/propalparolnapervom/sergiiburtovyi-devops-test-task/blob/main/terraform/instances/webserver/terraform.tfvars) are in use. Update it if needed.

Once the AMI was successfully built, we can use it to start EC2 instances for our infrastructure.\
See the plan of infrasctructure creation.
```
make terraformplan
```

Create the infrastructure itself.
```
make terraformapply
```

The output of the command above shows a DNS name you can now use to go to the WebServer. For example:
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
By default, only HTTP traffic is allowed. There's additional option to SSH, tho.\
P.S. It's better to have separate bastion server, but for simplifying purposes for this DevOps Test Task connection directrly to the EC2 instance is in use (as it has Public IP, provided by default subnet, which is in use for simplifying puproses as well).\
To enable this option, the following should be done.
- Before building AMI, update [variables.mk](https://github.com/propalparolnapervom/sergiiburtovyi-devops-test-task/blob/0bf60a9161abff6e7ed13f9859b2c0ebdb340ef2/variables.mk#L18-L20) as follows.\
This will add a ssh key for your user to the server.
```
webserver_ssh_acces_is_needed="yes"
webserver_ssh_username="<some_user>"
webserver_ssh_public_key="<public_part_of_ssh_key>"
```
- Before working with Terraform, update [terraform/instances/webserver/main.tf](https://github.com/propalparolnapervom/sergiiburtovyi-devops-test-task/blob/main/terraform/instances/webserver/main.tf#L16) as follows.\
This will open port 22 in the SecurityGroup, applied to the server.
```
enable_ssh_access_in_sg  = [1]
```


&nbsp;
## TO-DO
While this DevOps Test Task was made with the least effort needed to make it running in its current form, at least following steps might be considered as a next levels of improvements:
- create custom VPC and subnets (as a minimum, default subnets provide servers with Public IP, which is not what you want when the principle of least privilege/access is in use. SecutiryGroup controlls all access, tho);
- add DNS name, pointing to LB;
- make it available via HTTPS by adding a certificates, terminating on LB;
- make it available via HTTPS only, by redirecting a traffic (if any) from port 80 to port 443;
- add bastion to access EC2 instance via SSH;
- place Web and DB part of the WebServer on separate EC2 instances;
- put TF state file to some shared place (s3 bucket, for example);
- encrypt files with sensitive data in the WebServer git repository.



