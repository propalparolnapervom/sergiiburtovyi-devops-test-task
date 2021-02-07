output "webserver_loadbalancer_dns_name" {
    description = "The DNS name of the created LoadBalancer for Webserver."
    value = aws_lb.webserver_lb.dns_name
}