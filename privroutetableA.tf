resource "aws_route_table" "private-A-route-silale" {
  vpc_id = aws_vpc.vpc1-silale.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw1A-silale.id
  }

  tags = {
    Name = "private-A-route-silale"
  }
}

resource "aws_route_table_association" "association-subnet4" {
  subnet_id      = aws_subnet.subnet4-app-priv1A-silale.id
  route_table_id = aws_route_table.private-A-route-silale.id
}
resource "aws_route_table_association" "association-subnet6" {
  subnet_id      = aws_subnet.subnet6-db-priv1A-silale.id
  route_table_id = aws_route_table.private-A-route-silale.id
}