
# Esse recurso agrupa as subnets que o grupo vai ficar
resource "aws_db_subnet_group" "subnet_group_db_silale" {
  name       = "subnet_group_db_silale"
  subnet_ids = [aws_subnet.subnet6-db-priv1A-silale.id, aws_subnet.subnet7-db-priv1C-silale.id] //qual a az que o banco vai ficar.
  tags = {
    Name = "subnet_group_db_silale"
  }
}

resource "aws_db_instance" "db_silale" {
  identifier             = "db-silale"
  allocated_storage      = 10
  engine                 = "mysql"
  engine_version         = "8.0.23" //*Requisito desafio2
  instance_class         = "db.t2.micro"
  name                   = var.db_name
  username               = var.db_user
  password               = var.db_password
  skip_final_snapshot    = true
  multi_az               = true //*Requisito desafio2 
  db_subnet_group_name   = aws_db_subnet_group.subnet_group_db_silale.id
  vpc_security_group_ids = [aws_security_group.sg_RDS_silale.id]

  tags = {
    Name = "db_silale"
  }
}
