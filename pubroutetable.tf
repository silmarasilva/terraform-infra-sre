resource "aws_route_table" "public-route-silale" {
  vpc_id = aws_vpc.vpc1-silale.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-silale.id
  }

  tags = {
    Name = "public-route-silale"
  }
}

resource "aws_route_table_association" "association-subnet0" {
  subnet_id      = aws_subnet.subnet0-pub1A-silale.id
  route_table_id = aws_route_table.public-route-silale.id
}
resource "aws_route_table_association" "association-subnet1" {
  subnet_id      = aws_subnet.subnet1-pub1C-silale.id
  route_table_id = aws_route_table.public-route-silale.id
}