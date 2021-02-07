# Please, use the same Region that was used during AMI creation
aws_region      = "eu-west-1"

# Current version of the TF code supports 
# only this value of the 'mysql_db_host' variable
mysql_db_host             = "localhost"
# Current version of the TF code supports 
# only this value of the 'mysql_db_port' variable
mysql_db_port             = "3306"

mysql_db_name             = "devopsdb"
mysql_db_admin_username   = "devopsuser"
mysql_db_admin_password   = "devopspwd"
mysql_table_name          = "devopstable"
