output "webserver_dns_name" {
    description = "The DNS name of the created LoadBalancer for Webserver."
    value = module.webserver.webserver_loadbalancer_dns_name
}