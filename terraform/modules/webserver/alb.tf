resource "aws_lb" "webserver_lb" {
    name_prefix                = "websrv"
    internal                   = false
    load_balancer_type         = "application"

    security_groups = [
        aws_security_group.webserver_sg.id
    ]

    subnets     = [
        aws_default_subnet.default_az1.id,
        aws_default_subnet.default_az2.id,
        aws_default_subnet.default_az3.id
    ]

    tags = {
        Name        = "${random_pet.random_pet_name.id}-alb"
    }    

}


resource "aws_lb_target_group" "webserver_target_group" {
    name_prefix = "websrv"

    port        = "80"

    health_check {
        path = "/"
    }

    protocol    = "HTTP"
    vpc_id      = aws_default_vpc.default.id

    tags = {
        Name        = "${random_pet.random_pet_name.id}-alb-tg"
    } 
}


resource "aws_lb_listener" "webserver_port_80" {
    load_balancer_arn = aws_lb.webserver_lb.id
    port              = "80"
    protocol          = "HTTP"

    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.webserver_target_group.arn
    }

    depends_on = [
        aws_lb.webserver_lb,
        aws_lb_target_group.webserver_target_group
    ]
}
