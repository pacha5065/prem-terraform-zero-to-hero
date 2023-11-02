resource "aws_vpc" "day-1" {
  cidr_block = var.cidr_block
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id = aws_vpc.day-1.id
  cidr_block = var.public_cidr_1
}

# resource "aws_subnet" "public_subnet_2" {
#   vpc_id = aws_vpc.day-1.id
#   cidr_block = var.public_cidr_2
# }

# resource "aws_subnet" "public_subnet_3" {
#   vpc_id = aws_vpc.day-1.id
#   cidr_block = var.public_cidr_3
# }

resource "aws_subnet" "private_cidr_1" {
  vpc_id = aws_vpc.day-1.id
  cidr_block = var.private_cidr_1
}
# resource "aws_subnet" "private_cidr_2" {
#   vpc_id = aws_vpc.day-1.id
#   cidr_block = var.private_cidr_2
# }
# resource "aws_subnet" "private_cidr_3" {
#   vpc_id = aws_vpc.day-1.id
#   cidr_block = var.private_cidr_3
# }

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.day-1.id
}

resource "aws_route_table" "public_1_rtb" {
  vpc_id = aws_vpc.day-1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_eip" "eip" {
  vpc = true
}

resource "aws_nat_gateway" "nat" {
  subnet_id = aws_subnet.public_subnet_1.id
  allocation_id = aws_eip.eip.id
  depends_on = [ aws_internet_gateway.igw ]
}

resource "aws_route_table" "private_1_rtb" {
  vpc_id = aws_vpc.day-1.id

  route {
    cidr_block = var.private_cidr_1
    gateway_id = aws_nat_gateway.nat.id
  }
}

resource "aws_route_table_association" "rtb_associate" {

  route_table_id = aws_route_table.public_1_rtb.id
  subnet_id = aws_subnet.public_subnet_1.id
    
}

resource "aws_route_table_association" "rtb_private_associate" {
  route_table_id = aws_route_table.private_1_rtb.id
  subnet_id = aws_subnet.private_cidr_1.id
}