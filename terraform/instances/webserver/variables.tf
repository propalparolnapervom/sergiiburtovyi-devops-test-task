variable "aws_region" {
    description   = "The AWS region to work with. Please, use the one that was used during appropriate AMI creation."
    type          = string
    default       = "eu-west-1"
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
