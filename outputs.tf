#-------------imprime o LB ENDPOINT --------------------
output "lb_endpoint" {
  value = "http://${aws_lb.lb-silale.dns_name}"
}

#-------------imprime o DB ENDPOINT --------------------
output "db_endpoint" {
  value = aws_db_instance.db_silale.endpoint
}

#-------------imprime o BASTION PUB DNS-----------------
output "bastion_pub_dns" {
  value = "ssh -i ${var.my_key_name}.pem ubuntu@${aws_instance.bastion_silale.public_dns}"
}

#------imprime o RDS JÁ COM AS CHAMADAS PARA CONEXÃO-----
output "RDS" {
  value = "mysql -h ${aws_db_instance.db_silale.endpoint} -P 3306 -u ${var.db_user} -p"
}

#--------------------API-----------------------------

output "API-Clientes" {
  value = "http://${aws_lb.lb-silale.dns_name}/clientes"
}

output "API-Enderecos" {
  value = "http://${aws_lb.lb-silale.dns_name}/enderecos"
}

output "API-Cursos" {
  value = "http://${aws_lb.lb-silale.dns_name}/cursos"
}

output "API-Cursos-Status" {
  value = "http://${aws_lb.lb-silale.dns_name}/cursos/status"
}

output "API-Vendas" {
  value = "http://${aws_lb.lb-silale.dns_name}/cliente/compras"
}

