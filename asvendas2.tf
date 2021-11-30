
data "aws_ami" "ubuntu_vendas" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}

# Sobe máquinas conforme a demanda 
resource "aws_launch_configuration" "launchconfig-vendas-silale" {
  depends_on = [aws_lb.lb-silale] #wait for the lb to be ready
  name = "launchconfig-vendas-silale"
  image_id = data.aws_ami.ubuntu_vendas.id
  instance_type = var.instance_type
  key_name        = var.my_key_name
  security_groups = [aws_security_group.sg_as_silale.id]
  root_block_device {
    volume_size = 8
    delete_on_termination = true

}
user_data = data.template_file.dns_name.rendered
}


resource "aws_autoscaling_group" "ASG-silale-vendas" {
  name                      = "ASG-silale-vendas"
  max_size                  = 4
  min_size                  = 2
  health_check_grace_period = 30 //segundos
  health_check_type         = "EC2"
  desired_capacity          = 2
  force_delete              = true
  launch_configuration      = aws_launch_configuration.launchconfig-vendas-silale.name
  vpc_zone_identifier       = [aws_subnet.subnet4-app-priv1A-silale.id, aws_subnet.subnet5-app-priv1C-silale.id]
  tag {
    key                 = "Name"
    value               = "ASG-silale-vendas-app"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "policy-ASG-silale-vendas" {
  name                   = "policy-ASG-silale-vendas"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 60
  autoscaling_group_name = aws_autoscaling_group.ASG-silale-vendas.name
}

resource "aws_autoscaling_attachment" "asg_attachment_silale-vendas" {
  autoscaling_group_name = aws_autoscaling_group.ASG-silale-vendas.id
  alb_target_group_arn   = aws_lb_target_group.tg_silale_vendas.arn
}