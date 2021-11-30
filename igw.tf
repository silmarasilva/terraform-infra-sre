# AWS - INTERNET GATEWAY
resource "aws_internet_gateway" "igw-silale" {
  vpc_id = aws_vpc.vpc1-silale.id

  tags = {
    Name = "igw-silale"
  }
}