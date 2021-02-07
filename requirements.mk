##############################################
##############################################
# AMI with LAMP installed is gonna be created
# to implement DevOps Test Task
# with help of following variables
##############################################
##############################################

##############################################
# DO NOT update variables below,
# as it specify only versions of the tools,
# which were used to test IaaC from this repo
##############################################
packerversion:=1.5.6
ansibleversion:=2.9.11
terraformversion:=0.14.5

.PHONY: check_packer_ansible_versions
check_packer_ansible_versions:
	@echo "Checking Packer version" ; \
	pak_current=$$(packer --version | awk 'NR==1' | sed 's/[^0-9.]*\([0-9.]*\).*/\1/') ; \
	if [ "$${pak_current}" != "$(packerversion)" ] ; then \
	  echo  ; \
	  echo "    The code was not tested for your Packer version." ; \
	  echo "    Please, use following Packer version instead: $(packerversion)" ; \
	  echo  ; \
	  exit 1 ; \
	fi

	@echo "Checking Ansible version" ; \
	ans_current=$$(ansible --version | awk 'NR==1' | sed 's/[^0-9.]*\([0-9.]*\).*/\1/') ; \
	if [ "$${ans_current}" != "$(ansibleversion)" ] ; then \
	  echo  ; \
	  echo "    The code was not tested for your Ansible version." ; \
	  echo "    Please, use following Ansible version instead: $(ansibleversion)" ; \
	  echo  ; \
	  exit 1 ; \
	fi

.PHONY: check_terraform_version
check_terraform_version:
	@echo "Checking Terraform version" ; \
	tf_current=$$(terraform version | awk 'NR==1' | sed 's/[^0-9.]*\([0-9.]*\).*/\1/') ; \
	if [ "$${tf_current}" != "$(terraformversion)" ] ; then \
	  echo  ; \
	  echo "    The code was not tested for your Terraform version." ; \
	  echo "    Please, use following Terraform version instead: $(terraformversion)" ; \
	  echo  ; \
	  exit 1 ; \
	fi
