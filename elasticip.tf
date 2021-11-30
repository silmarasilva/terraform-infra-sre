resource "aws_eip" "eip-natgw1A-silale" {
  depends_on = [aws_internet_gateway.igw-silale]
  tags = {
    Name = "eip-natgw1A-silale"
  }
}

resource "aws_eip" "eip-natgw1C-silale" {
  depends_on = [aws_internet_gateway.igw-silale]
  tags = {
    Name = "eip-natgw1C-silale"
  }

}