# Criação da VPC

resource "aws_vpc" "vpc1-silale" {
  cidr_block           = "10.0.0.0/21"
  enable_dns_hostnames = true
  tags = {
    Name = "vpc1-silale"
  }
}