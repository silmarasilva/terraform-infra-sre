
resource "aws_alb_listener" "listener_silale" {
  load_balancer_arn = aws_lb.lb-silale.arn
  port              = "80"
  protocol          = "HTTP"
  depends_on        = [aws_lb_target_group.tg_silale_clientes, aws_lb_target_group.tg_silale_enderecos, aws_lb_target_group.tg_silale_produtos, aws_lb_target_group.tg_silale_vendas]
  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/html"
      message_body = "A página não foi encontrada. Verifique  a sua rota."
      status_code  = 200
      }
    }
}
# RULES
#-----------------API CLIENTES--------------------------

resource "aws_lb_listener_rule" "listener_rule_clientes" {
  listener_arn = aws_alb_listener.listener_silale.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_silale_clientes.arn
  }
  condition {
    path_pattern {
      values = ["/clientes"]
    }
  }
}


resource "aws_lb_listener_rule" "listener_rule_clientes_id" {
  listener_arn = aws_alb_listener.listener_silale.arn
  priority     = 99

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_silale_clientes.arn
  }
  condition {
    path_pattern {
      values = ["/clientes/*"]
    }
  }
}


#-------------------API ENDERECOS--------------------------

resource "aws_lb_listener_rule" "listener_rule_enderecos" {
  listener_arn = aws_alb_listener.listener_silale.arn
  priority     = 98

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_silale_enderecos.arn
  }

  condition {
    path_pattern {
      values = ["/enderecos"]
    }
  }

}

resource "aws_lb_listener_rule" "listener_rule_enderecos_id" {
  listener_arn = aws_alb_listener.listener_silale.arn
  priority     = 97

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_silale_enderecos.arn
  }

   condition {
    path_pattern {
      values = ["/enderecos/*"]
    }
  }
  
}


#----------------------API PRODUTOS----------------------

resource "aws_lb_listener_rule" "listener_rule_produtos" {
  listener_arn = aws_alb_listener.listener_silale.arn
  priority     = 96

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_silale_produtos.arn
  }
  condition {
    path_pattern {
      values = ["/cursos"]
    }
  }
}

resource "aws_lb_listener_rule" "listener_rule_produtos_id" {
  listener_arn = aws_alb_listener.listener_silale.arn
  priority     = 95

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_silale_produtos.arn
  }
  condition {
    path_pattern {
      values = ["/cursos/*"]
    }
  }
}

resource "aws_lb_listener_rule" "listener_rule_produtos_status" {
  listener_arn = aws_alb_listener.listener_silale.arn
  priority     = 94

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_silale_produtos.arn
  }
  condition {
    path_pattern {
      values = ["/cursos/status/*"]
    }
  }
}

#--------------------API VENDAS---------------------------

resource "aws_lb_listener_rule" "listener_rule_vendas" {
  listener_arn = aws_alb_listener.listener_silale.arn
  priority     = 93
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_silale_vendas.arn
  }
  condition {
    path_pattern {
      values = ["/cliente/compras"]
    }
  }
}

resource "aws_lb_listener_rule" "listener_rule_vendas_id" {
  listener_arn = aws_alb_listener.listener_silale.arn
  priority     = 92
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_silale_vendas.arn
  }
  condition {
    path_pattern {
      values = ["/cliente/compras/*"]
    }
  }
}
