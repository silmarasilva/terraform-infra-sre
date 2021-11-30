resource "aws_route_table" "private-C-route-silale" {
  vpc_id = aws_vpc.vpc1-silale.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw1C-silale.id
  }

  tags = {
    Name = "private-C-route-silale"
  }
}

resource "aws_route_table_association" "association-subnet5" {
  subnet_id      = aws_subnet.subnet5-app-priv1C-silale.id
  route_table_id = aws_route_table.private-C-route-silale.id
}
resource "aws_route_table_association" "association-subnet7" {
  subnet_id      = aws_subnet.subnet7-db-priv1C-silale.id
  route_table_id = aws_route_table.private-C-route-silale.id
}