# Security Group PUB
resource "aws_security_group" "sg_RDS_silale" {
  name        = "sg_RDS_silale"
  description = "SG para controlar acesso ao RDS"
  vpc_id      = aws_vpc.vpc1-silale.id


  ingress {
    description = "SG para controlar comunicacao com RDS"
    from_port   = 3306
    to_port     = 3306 // porta padrão do mysql
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/21"] // porta mysql
  }

  ingress {
    description = "SG para controlar comunicacao com RDS"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/21" ] // recebe comnicação de toda a VPC
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"          //You can use -1 to mean all types or all codes.
    cidr_blocks = ["0.0.0.0/0"] // se comunica em qualquer porta com todo mundo
  }

  tags = {
    Name = "sg_RDS_silale"
  }
}