
# Security Group PRIVADO  
resource "aws_security_group" "sg_as_silale" {
  name        = "sg_as_silale"
  description = "sg_as_silale"
  vpc_id      = aws_vpc.vpc1-silale.id

  # Inbound HTTP from anywhere
  ingress {
    description = "sg_tcp_as_silale"
    from_port   = 80 //http
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  /*

  ingress {
    description      = "sg_tcp_as_silale"
    from_port        = 5000 //http porta clientes
    to_port          = 5000
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]    
  }

    ingress {
    description      = "sg_tcp_as_silale"
    from_port        = 5001 //http porta enderecos
    to_port          = 5001
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]    
  }
*/
  ingress {
    description = "sg_tcp_as_silale"
    from_port   = 22 // se comunica em qualquer porta com todo mundo
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    //security_groups = [aws_security_group.sg_pub_bastiao_silale.id]

  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] // se comunica em qualquer porta com todo mundo
  }

  tags = {
    Name = "sg_as_silale"
  }
}