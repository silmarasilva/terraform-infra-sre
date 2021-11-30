
#-----------Subnets públicas------------------
resource "aws_subnet" "subnet0-pub1A-silale" {
  vpc_id            = aws_vpc.vpc1-silale.id
  availability_zone = "us-east-1a"
  cidr_block        = "10.0.0.0/24"
  tags = {
    Name = "subnet0-pub1A-silale"
  }
}

resource "aws_subnet" "subnet1-pub1C-silale" {
  vpc_id            = aws_vpc.vpc1-silale.id
  availability_zone = "us-east-1c"
  cidr_block        = "10.0.1.0/24"
  tags = {
    Name = "subnet1-pub1C-silale"
  }
}


#----------Subnets privadas----------------------
# AZ - A

resource "aws_subnet" "subnet4-app-priv1A-silale" {
  vpc_id            = aws_vpc.vpc1-silale.id
  availability_zone = "us-east-1a"
  cidr_block        = "10.0.4.0/24"
  tags = {
    Name = "subnet4-app-priv1A-silale"
  }
}

resource "aws_subnet" "subnet6-db-priv1A-silale" {
  vpc_id            = aws_vpc.vpc1-silale.id
  availability_zone = "us-east-1a"
  cidr_block        = "10.0.6.0/24"
  tags = {
    Name = "subnet6-db-priv1A-silale"
  }
}

#--------------Subnets privadas------------------
# AZ - C

resource "aws_subnet" "subnet5-app-priv1C-silale" {
  vpc_id            = aws_vpc.vpc1-silale.id
  availability_zone = "us-east-1c"
  cidr_block        = "10.0.5.0/24"
  tags = {
    Name = "subnet5-app-priv1C-silale"
  }
}

resource "aws_subnet" "subnet7-db-priv1C-silale" {
  vpc_id            = aws_vpc.vpc1-silale.id
  availability_zone = "us-east-1c"
  cidr_block        = "10.0.7.0/24"
  tags = {
    Name = "subnet7-db-priv1C-silale"
  }
}





