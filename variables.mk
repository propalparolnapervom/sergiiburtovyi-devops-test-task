##############################################
##############################################
# AMI with LAMP installed is gonna be created
# to implement DevOps Test Task
# with help of following variables
##############################################
##############################################

##############################################
# Make sure following variables are up-to-date
##############################################

# AWS region, where AMI is gonna be created
region=eu-west-1

# If 'webserver_ssh_acces_is_needed' set to "yes", 
# SSH key 'webserver_ssh_public_key' for user 'webserver_ssh_username' will be added to the AMI
webserver_ssh_acces_is_needed="no"
webserver_ssh_username=""
webserver_ssh_public_key=""
