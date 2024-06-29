resource "aws_vpc" "VPC" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "VPC"
  }
}

resource "aws_subnet" "public_subnet_1a" {
  vpc_id                  = aws_vpc.VPC.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1c"

  tags = {
    Name = "public_subnet_1a"
  }
}

resource "aws_subnet" "public_subnet_1b" {
  vpc_id                  = aws_vpc.VPC.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1d"

    tags = {
        Name = "public_subnet_1b"
    }
}

resource "aws_subnet" "private_subnet_1a" {
  vpc_id            = aws_vpc.VPC.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = "private_subnet_1a"
  }
}

resource "aws_subnet" "private_subnet_1b" {
  vpc_id            = aws_vpc.VPC.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-1d"

  tags = {
    Name = "private_subnet_1b"
  }
}

resource "aws_internet_gateway" "IG" {
  vpc_id = aws_vpc.VPC.id

    tags = {
        Name = "Internet gateway"
    }
}

resource "aws_route_table" "RT" {
  vpc_id = aws_vpc.VPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IG.id
  }
}

resource "aws_route_table_association" "RTA1A" {
  subnet_id      = aws_subnet.public_subnet_1a.id
  route_table_id = aws_route_table.RT.id
}

resource "aws_route_table_association" "RTA1B" {
  subnet_id      = aws_subnet.public_subnet_1b.id
  route_table_id = aws_route_table.RT.id
}