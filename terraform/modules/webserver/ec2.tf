######
# ASG 
######
data "aws_ami" "webserver_ami" {
  most_recent = true
  owners      = ["self"]

  filter {
    name   = "tag:purpose"
    values = ["webserver"]
  }

  filter {
    name   = "tag:managed_by"
    values = ["sergiiburtovyi"]
  }

}

resource "aws_launch_configuration" "webserver_lc" {
  name_prefix   = "${random_pet.random_pet_name.id}-websrv-lc-"
  image_id      = data.aws_ami.webserver_ami.id
  instance_type = var.instance_type

  security_groups = [
      aws_security_group.webserver_sg.id
   ]

  user_data = data.template_cloudinit_config.cloud_init.rendered

  root_block_device {
    volume_size = var.volume_size_in_gib
    volume_type = var.volume_type
  }

  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_autoscaling_group" "webserver_asg" {
  name                      = "${random_pet.random_pet_name.id}-asg"
  min_size                  = var.asg_min_size
  max_size                  = var.asg_max_size
  launch_configuration      = aws_launch_configuration.webserver_lc.id
  target_group_arns         = [aws_lb_target_group.webserver_target_group.arn]
  health_check_type         = "EC2"
  health_check_grace_period = 300
  termination_policies      = ["OldestLaunchConfiguration", "OldestInstance"]
  vpc_zone_identifier       = [
        aws_default_subnet.default_az1.id,
        aws_default_subnet.default_az2.id,
        aws_default_subnet.default_az3.id
    ]

  tag {
    key                 = "Name"
    value               = "${random_pet.random_pet_name.id}-asg"
    propagate_at_launch = true
  }

  depends_on = [
    aws_lb_target_group.webserver_target_group,
  ]

}




#############################
#############################
# 1. Prepare User Data files
#############################
#############################

#####################################
# 1.1. Server-wide 'cloud_init' file
#####################################
data "template_file" "cloud_init_sh" {
  template = file("${path.module}/templates/cloud_init.sh")
}


#######################
# 1.2. WebServer files
#######################

data "template_file" "index_php" {
  template = file("${path.module}/templates/web/index.php")
}

data "template_file" "page2_php" {
  template = file("${path.module}/templates/web/page2.php")
}

data "template_file" "page3_php" {
  template = file("${path.module}/templates/web/page3.php")
}

data "template_file" "page4_php" {
  template = file("${path.module}/templates/web/page4.php")
}

data "template_file" "footer_html" {
  template = file("${path.module}/templates/web/footer.html")
}

data "template_file" "header_html" {
  template = file("${path.module}/templates/web/header.html")
}

data "template_file" "insert_into_db_table_html" {
  template = file("${path.module}/templates/web/insert_into_db_table.html")
}

data "template_file" "insert_into_db_table_php" {
  template = file("${path.module}/templates/web/insert_into_db_table.php")

  vars = {
    DB_HOST       = var.mysql_db_host
    DB_NAME       = var.mysql_db_name
    DB_TABLE_NAME = var.mysql_table_name  
    DB_USER_NAME  = var.mysql_db_admin_username 
    DB_USER_PWD   = var.mysql_db_admin_password
  }

}

data "template_file" "select_from_db_table_php" {
  template = file("${path.module}/templates/web/select_from_db_table.php")

  vars = {
    DB_HOST       = var.mysql_db_host
    DB_NAME       = var.mysql_db_name
    DB_TABLE_NAME = var.mysql_table_name  
    DB_USER_NAME  = var.mysql_db_admin_username 
    DB_USER_PWD   = var.mysql_db_admin_password
  }

}


################
# 1.3. DB files
################

data "template_file" "configure_db_sql" {
  template = file("${path.module}/templates/db/configure_db.sql")

  vars = {
    DB_NAME       = var.mysql_db_name
    DB_TABLE_NAME = var.mysql_table_name  
    DB_USER_NAME  = var.mysql_db_admin_username 
    DB_USER_PWD   = var.mysql_db_admin_password
  }

}


###########################
###########################
# 2. Handle prepared files
###########################
###########################

data "template_cloudinit_config" "cloud_init" {
  gzip = true


  #####################################
  # 2.1. Server-wide 'cloud_init' file
  #####################################
  part {
    content_type = "text/part-handler"
    content      = file("${path.module}/files/cloudinit-handler.py")
  }

  part {
    content      = data.template_file.cloud_init_sh.rendered
    content_type = "text/x-shellscript"
  }


  #######################
  # 2.2. WebServer files
  #######################

  part {
    content      = data.template_file.index_php.rendered
    content_type = "text/custom"
    filename     = "/var/www/html/index.php"
  }

  part {
    content      = data.template_file.page2_php.rendered
    content_type = "text/custom"
    filename     = "/var/www/html/page2.php"
  }

  part {
    content      = data.template_file.page3_php.rendered
    content_type = "text/custom"
    filename     = "/var/www/html/page3.php"
  }

  part {
    content      = data.template_file.page4_php.rendered
    content_type = "text/custom"
    filename     = "/var/www/html/page4.php"
  }

  part {
    content      = data.template_file.header_html.rendered
    content_type = "text/custom"
    filename     = "/var/www/html/header.html"
  }

  part {
    content      = data.template_file.footer_html.rendered
    content_type = "text/custom"
    filename     = "/var/www/html/footer.html"
  }

  part {
    content      = data.template_file.insert_into_db_table_html.rendered
    content_type = "text/custom"
    filename     = "/var/www/html/insert_into_db_table.html"
  }

  part {
    content      = data.template_file.insert_into_db_table_php.rendered
    content_type = "text/custom"
    filename     = "/var/www/html/insert_into_db_table.php"
  }

  part {
    content      = data.template_file.select_from_db_table_php.rendered
    content_type = "text/custom"
    filename     = "/var/www/html/select_from_db_table.php"
  }


  ################
  # 2.3. DB files
  ################

  part {
    content      = data.template_file.configure_db_sql.rendered
    content_type = "text/custom"
    filename     = "/var/www/html/configure_db.sql"
  }

}

