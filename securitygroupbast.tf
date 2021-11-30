# Security Group PUB
resource "aws_security_group" "sg_pub_bastiao_silale" {
  name        = "sg_pub_bastiao_silale"
  description = "SG para controlar o acesso SSH do bastiao"
  vpc_id      = aws_vpc.vpc1-silale.id


  ingress {
    description = "SG para controlar SSH do bastiao"
    from_port   = 80 // recebe comunicação da internet
    to_port     = 80 // 
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    description = "SG para controlar SSH do bastiao"
    from_port   = 22 // recebe comunicação em qualquer porta com todo mundo via SSH
    to_port     = 22 // 
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  /*
    ingress {
    description      = "sg_tcp_as_silale"
    from_port        = 5000 //http
    to_port          = 5000
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]    
  }

      ingress {
    description      = "sg_tcp_as_silale"
    from_port        = 5001 //http
    to_port          = 5001
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]    
  }
  */

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] // se comunica em qualquer porta com todo mundo.
  }

  tags = {
    Name = "sg_pub_bastiao_silale"
  }
}