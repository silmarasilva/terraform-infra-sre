data "template_file" "dns_name" {
    template = file ("/home/sil_silva/workspace/terraform/project-infra-sre/deployment.tpl")
    vars = {
    lb_endpoint = "${aws_lb.lb-silale.dns_name}"
}
}