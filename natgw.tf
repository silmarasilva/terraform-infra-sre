# NAT
resource "aws_nat_gateway" "natgw1A-silale" {
  allocation_id = aws_eip.eip-natgw1A-silale.id
  subnet_id     = aws_subnet.subnet0-pub1A-silale.id
  tags = {
    Name = "natgw1a-silale"
  }
}

resource "aws_nat_gateway" "natgw1C-silale" {
  allocation_id = aws_eip.eip-natgw1C-silale.id
  subnet_id     = aws_subnet.subnet1-pub1C-silale.id
  tags = {
    Name = "natgw1c-silale"
  }
}