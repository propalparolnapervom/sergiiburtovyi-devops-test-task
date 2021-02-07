git_toplevel:=$(shell git rev-parse --show-toplevel)

include $(git_toplevel)/variables.mk
include $(git_toplevel)/requirements.mk


.PHONY: webserver
webserver: check_packer_ansible_versions
	packer build -var 'server_type=webserver' -var 'region=$(region)' -var 'webserver_ssh_acces_is_needed=$(webserver_ssh_acces_is_needed)' -var 'webserver_ssh_username=$(webserver_ssh_username)' -var 'webserver_ssh_public_key=$(webserver_ssh_public_key)' ubuntu.json
