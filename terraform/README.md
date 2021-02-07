# Step 2 of 2: Deploy infra into AWS

Once we have AMI available with all software installed and configured, the WebServer infrastructure could be created, based on that AMI.
&nbsp;
[Terraform](https://www.terraform.io/) was used as a tool to describe and create a fair minimum of infrastructure needed to run our LAMP AMI in the AWS cloud:
- **EC2 Auto Scaling Group** - to keep necessary amount of servers running;
- **Application Load Balancer** - to serve as endpoint of our WebSite (and load balancer, in general);
- **EC2 Security Group** - to make HTTP traffic on port 80 the only one allowed by default (SSH connection on port 22, direct to the EC2 instance, could be allowed in addition, if needed: please, see appropriate How-To's chapter of README file in root of the repo);
- **Virtual Private Cloud** and **Subnets**, default for your AWS Region, were used to keep it simple.