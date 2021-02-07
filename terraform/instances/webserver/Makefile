git_toplevel:=$(shell git rev-parse --show-toplevel)

include $(git_toplevel)/variables.mk
include $(git_toplevel)/requirements.mk

.PHONY : terraforminit
terraforminit: check_terraform_version
	terraform init --force-copy

.PHONY : terraformplan
terraformplan: check_terraform_version terraforminit
	terraform plan

.PHONY : terraformapply
terraformapply: check_terraform_version terraforminit
	terraform apply -auto-approve

.PHONY : terraformdestroy
terraformdestroy: check_terraform_version
	terraform destroy
