# O balanceador de carga examina o tráfego para os servidores web executando verificações de integridade nos servidores virtuais anexados a ele. 

resource "aws_lb" "lb-silale" {
  name               = "lb-silale"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.subnet0-pub1A-silale.id, aws_subnet.subnet1-pub1C-silale.id]
  security_groups    = [aws_security_group.sg_lb_silale.id]

  tags = {
    Name = "lb-silale"
  }
}

# TARGET GROUP CLIENTES 
resource "aws_lb_target_group" "tg_silale_clientes" {
  name        = "tg-silale-clientes"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc1-silale.id
  target_type = "instance"

  health_check {
    interval            = 30
    healthy_threshold   = 4
    unhealthy_threshold = 2
    timeout             = 5
    matcher             = "200-401"
  }
}


# TARGET GROUP ENDERECOS
resource "aws_lb_target_group" "tg_silale_enderecos" {
  name        = "tg-silale-enderecos"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc1-silale.id
  target_type = "instance"

  health_check {
    interval            = 30
    healthy_threshold   = 5
    unhealthy_threshold = 10
    timeout             = 5
    matcher             = "200-401"
  }
}

# TARGET GROUP PRODUTOS

resource "aws_lb_target_group" "tg_silale_produtos" {
  name        = "tg-silale-produtos"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc1-silale.id
  target_type = "instance"

  health_check {
    interval            = 30
    healthy_threshold   = 5
    unhealthy_threshold = 10
    timeout             = 5
    matcher             = "200-401"
  }
}

# TARGET GROUP VENDAS
resource "aws_lb_target_group" "tg_silale_vendas" {
  name        = "tg-silale-vendas"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc1-silale.id
  target_type = "instance"

  health_check {
    interval            = 30
    healthy_threshold   = 5
    unhealthy_threshold = 10
    timeout             = 5
    matcher             = "200-401"
  }
}