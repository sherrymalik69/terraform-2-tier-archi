
resource "aws_vpc" "myvpc" {

  cidr_block = "${var.vpc_cidr}"

  tags = {

    Name = "myvpc"

  }

}



resource "aws_subnet" "public" {
  for_each = var.public_subnets

  vpc_id = aws_vpc.myvpc.id

  cidr_block = each.value.cidr_block

  availability_zone = each.value.availability_zone

  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-${each.key}"
  }

}

resource "aws_subnet" "private" {
  for_each = var.private_subnets

  vpc_id = aws_vpc.myvpc.id

  cidr_block = each.value.cidr_block

  availability_zone = each.value.availability_zone

  map_public_ip_on_launch = false

  tags = {
    Name = "private-subnet-${each.key}"
  }
}


resource "aws_internet_gateway" "myigw" {
  vpc_id = aws_vpc.myvpc.id

  tags = {
    Name = "myinternetgw"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id = "${aws_subnet.public["1"].id}"
  depends_on = [
    aws_internet_gateway.myigw
  ]
  tags = {
    Name = "mynatgw"
  }
}

resource "aws_eip" "nat" {

  vpc = true
}

resource "aws_route" "internet_gateway-route-for-public-subnet" {
  route_table_id            = aws_vpc.myvpc.default_route_table_id
  destination_cidr_block    = "${var.route-for-public-rt["igw"]}"
  gateway_id                = aws_internet_gateway.myigw.id
}

resource "aws_route_table" "Private_rt" {

  vpc_id = aws_vpc.myvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "Private-rt"
  }
}
