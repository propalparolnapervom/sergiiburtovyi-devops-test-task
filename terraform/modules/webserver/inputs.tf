variable "aws_region" {
    description   = "The AWS region to work with. Please, use the one that was used during appropriate AMI creation."
    type          = string
    default       = "eu-west-1"
}

# EC2
variable "enable_ssh_access_in_sg" {
    description = "If set to [1], SecurityGroup for the EC2 instance allows SSH connection from anywhere (SSH key added during AMI creation is needed to make actual connection)."
    type        = list(number)
    default     = []
}

variable "instance_type" {
    description     = "Type of the EC2 instance."
    type            = string
    default         = "t2.micro"
}

variable "volume_size_in_gib" {
    description     = "Size of the root block device of the EC2 instance."
    type            = string
    default         = "8"    
}

variable "volume_type" {
    description     = "The type of volume for the EC2 instance."
    type            = string
    default         = "gp2"    
}

variable "asg_min_size" {
    description     = "The minimum size of the Auto Scaling Group."
    type            = string
    default         = "1"    
}

variable "asg_max_size" {
    description     = "The maximum size of the Auto Scaling Group."
    type            = string
    default         = "1"    
}


# MySQL 
variable "mysql_db_host" {
    description   = "MySQL instance for WebServer is available on this hostname."
    type          = string
    default       = "localhost"
}

variable "mysql_db_port" {
    description   = "MySQL instance for WebServer is available on this port."
    type          = string
    default       = "3306"
}

variable "mysql_db_name" {
    description   = "MySQL DB name for WebServer."
    type          = string
    default       = null
}

variable "mysql_db_admin_username" {
    description   = "The user with admin permission on MySQL DB name for WebServer."
    type          = string
    default       = null
}

variable "mysql_db_admin_password" {
    description   = "The password of the user with admin permission on MySQL DB name for WebServer."
    type          = string
    default       = null
}

variable "mysql_table_name" {
    description   = "The name of a table in the MySQL DB, that will be used by WebServer in our case."
    type          = string
    default       = null
}
