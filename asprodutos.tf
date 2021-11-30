# Sobe máquinas conforme a demanda 
resource "aws_launch_configuration" "launchconfig-produtos-silale" {
  name = "launchconfig-produtos-silale"
  //image_id      = data.aws_ami.api-clientes-silmara.id //colocar a minha imagem client aqui
  image_id      = var.image_api_produtos
  instance_type = var.instance_type
  //associate_public_ip_address = false
  key_name        = var.my_key_name
  security_groups = [aws_security_group.sg_as_silale.id]
  user_data = <<-EOF
            #!/bin/bash
            sudo apt -y update
            sudo apt -y upgrade -y
            cd /home/ubuntu
            cd apiPRODUTOS
            sudo python3 main_cursos.py
            EOF
  root_block_device {
    volume_size = 8
    delete_on_termination = true
  }
}


resource "aws_autoscaling_group" "ASG-silale-produtos" {
  name                      = "ASG-silale-produtos"
  max_size                  = 4
  min_size                  = 2
  health_check_grace_period = 30 //segundos
  health_check_type         = "EC2"
  desired_capacity          = 2
  force_delete              = true
  launch_configuration      = aws_launch_configuration.launchconfig-produtos-silale.name
  vpc_zone_identifier       = [aws_subnet.subnet4-app-priv1A-silale.id, aws_subnet.subnet5-app-priv1C-silale.id]
  tag {
    key                 = "Name"
    value               = "ASG-silale-produtos-app"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "policy-ASG-silale-produtos" {
  name                   = "policy-ASG-silale-produtos"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 60
  autoscaling_group_name = aws_autoscaling_group.ASG-silale-produtos.name
}

resource "aws_autoscaling_attachment" "asg_attachment_silale-produtos" {
  autoscaling_group_name = aws_autoscaling_group.ASG-silale-produtos.id
  alb_target_group_arn   = aws_lb_target_group.tg_silale_produtos.arn
}





/*
resource "aws_cloudwatch_metric_alarm" "cloudwatch-ASG-silale" {
  alarm_name          = "cloudwatch-ASG-silale"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "80"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.ASG-silale.name
  }

  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = [aws_autoscaling_policy.policy-ASG-silale.arn]
}
*/


/*#imagens - CLIENTES
resource "aws_ami_from_instance" "api-cli-silale" {
  name               = "api-cli-silale"
  source_instance_id = aws_instance.api-cli-silale.id
  tags = {
    Name = "api-cli-silale"
  }
}

resource "aws_instance" "api-cli-silale" {    
    ami = data.aws_ami.ubuntu.id
    instance_type = "t2.micro"
    subnet_id = aws_subnet.subnet4-app-priv1A-silale.id
    vpc_security_group_ids = [aws_security_group.sg_as_silale.id, aws_vpc.vpc1-silale.default_security_group_id]
    associate_public_ip_address = true
    key_name = "aws-silale"
    user_data = <<EOF
    #!/bin/bash
    sudo install http -y
    echo "Welcome to my First EC2 Instance Web Server"> /var/www/html/index.html
    sudo update -y
    service httpd start
    EOF
    tags = {
    Name = "api-cli-silale"
  }
}
  
*/