#################################################################
# As of now, an AMI with LAMP stack configured inside
# has to be already built.
# If it was not done yet, please go to the 'packer_ansible' dir 
# and do this as explained.
#
# This is to create infrastructure, based on that AMI.
############################################################
module "webserver" {
    source = "../../modules/webserver"

    aws_region          = var.aws_region

    # If uncommented, EC2 SecurityGroup allows SSH connections from anywhere
    # (for actual SSH connection appropriate user should be already added during AMI creation)
    # enable_ssh_access_in_sg  = [1]

    instance_type       = "t2.micro"
    volume_size_in_gib  = "8"
    volume_type         = "gp2"
    asg_min_size        = "1"
    asg_max_size        = "1"

    mysql_db_host           = var.mysql_db_host             
    mysql_db_port           = var.mysql_db_port            
    mysql_db_name           = var.mysql_db_name            
    mysql_db_admin_username = var.mysql_db_admin_username   
    mysql_db_admin_password = var.mysql_db_admin_password
    mysql_table_name        = var.mysql_table_name

}