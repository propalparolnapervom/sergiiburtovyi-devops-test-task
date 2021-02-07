##############################################
# This is implementation of DevOps Test Task
# to create and deploy infrastructure on AWS,
# with LAMP stack as a basis.
##############################################

# Packer + Ansible + Goss
.PHONY: ami
ami: 
	make --directory packer_ansible webserver

# Terraform
.PHONY: terraformplan
terraformplan: 
	make --directory terraform/instances/webserver terraformplan

.PHONY: terraformapply
terraformapply: 
	make --directory terraform/instances/webserver terraformapply

.PHONY: terraformdestroy
terraformdestroy: 
	make --directory terraform/instances/webserver terraformdestroy
