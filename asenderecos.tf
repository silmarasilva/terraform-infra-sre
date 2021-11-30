
# Sobe máquinas conforme a demanda 
resource "aws_launch_configuration" "launchconfig-enderecos-silale" {
  name = "launchconfig-enderecos-silale"
  //image_id      = data.aws_ami.api-clientes-silmara.id //colocar a minha imagem client aqui
  image_id      = var.image_api_enderecos
  instance_type = var.instance_type
  //associate_public_ip_address = false
  key_name        = var.my_key_name
  security_groups = [aws_security_group.sg_as_silale.id]
  user_data = <<-EOF
            #!/bin/bash
            sudo apt -y update
            sudo apt -y upgrade -y
            cd /home/ubuntu
            cd apiENDERECOS
            sudo python3 main_enderecos.py
            EOF
  root_block_device {
    volume_size = 8
    delete_on_termination = true
  }
}


resource "aws_autoscaling_group" "ASG-silale-enderecos" {
  name                      = "ASG-silale-enderecos"
  max_size                  = 4
  min_size                  = 2
  health_check_grace_period = 30 //segundos
  health_check_type         = "EC2"
  desired_capacity          = 2
  force_delete              = true
  launch_configuration      = aws_launch_configuration.launchconfig-enderecos-silale.name
  vpc_zone_identifier       = [aws_subnet.subnet4-app-priv1A-silale.id, aws_subnet.subnet5-app-priv1C-silale.id]
  tag {
    key                 = "Name"
    value               = "ASG-silale-app-enderecos"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "policy-ASG-silale-enderecos" {
  name                   = "policy-ASG-silale-enderecos"
  scaling_adjustment     = -1                 // Um valor positivo adiciona à capacidade atual e um número negativo subtrai da capacidade atual.
  adjustment_type        = "ChangeInCapacity" //aumenta a capacidade do grupo do com base nos seguintes ajustes em etapas (pressupondo-se um limite de alarme do CloudWatch de 60%):
  cooldown               = 60
  autoscaling_group_name = aws_autoscaling_group.ASG-silale-enderecos.name
}

resource "aws_autoscaling_attachment" "asg_attachment_silale-enderecos" {
  autoscaling_group_name = aws_autoscaling_group.ASG-silale-enderecos.id
  alb_target_group_arn   = aws_lb_target_group.tg_silale_enderecos.arn
}