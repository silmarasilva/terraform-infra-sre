# Security Group LOAD BALANCE 

resource "aws_security_group" "sg_lb_silale" {
  name        = "lb_sg_silale"
  description = "Security group for load balancer"
  vpc_id      = aws_vpc.vpc1-silale.id


  ingress {
    from_port   = 80 // porta padrão http - www
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  /*
    ingress {
    from_port        = 5000 // porta da API Clientes
    to_port          = 5000
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]    
  }

    ingress {
    from_port        = 5001 // porta da API Enderecos
    to_port          = 5001
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]    
  }
*/

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg_lb_silale"
  }
}

