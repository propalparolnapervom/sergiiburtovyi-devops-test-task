# Step 1 of 2: Build AMI

So the final aim is to have a WebServer running on AWS cloud, available via LoadBalancer, with DB on its backend.
Seems like LAMP (Linux, Apache, MySQL, PHP) meets basic requirements.
One option to make it running on the AWS Cloud is to build an AMI with LAMP stack installed.
Thus, the following was done to create such AMI:
- [Packer](https://www.packer.io/) - was used as a tool to create customized AMI;
- [Ansible](https://www.ansible.com/) - was used by Packer as a tool to manage AMI configuration (install Apache, MySQL and PHP, for instance);
- [Goss](https://github.com/aelsabbahy/goss/) - was used by Packer as a tool to test AMI configuration (for example, to check that specified packages were installed and prosesses were started successfully).