# Route Table
#
# Description:
# A route table contains a set of rules, called routes, that determine where network traffic from
# your subnet or gateway is directed.
#
# AWS Documentation:
# https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Route_Tables.html
#
# Terraform Documentation:
# @TODO

resource "aws_route_table" "private_zone_a" {
    vpc_id = aws_vpc.default.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.zone_a.id
    }
#    route {
#        ipv6_cidr_block = "::/0"
#        gateway_id = aws_internet_gateway.default.id
#    }
    tags = {
        Name = "${var.tags.Name} Private Subnet Zone A"
        billing-id = var.tags.billing-id
    }
}

resource "aws_route_table" "private_zone_b" {
    vpc_id = aws_vpc.default.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.zone_b.id
    }
#    route {
#        ipv6_cidr_block = "::/0"
#        gateway_id = aws_internet_gateway.default.id
#    }
    tags = {
        Name = "${var.tags.Name} Private Subnet Zone B"
        billing-id = var.tags.billing-id
    }
}

resource "aws_route_table" "public" {
    vpc_id = aws_vpc.default.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.default.id
    }
#    route {
#        ipv6_cidr_block = "::/0"
#        gateway_id = aws_internet_gateway.default.id
#    }
    tags = {
        Name = "${var.tags.Name} Public Subnets"
        billing-id = var.tags.billing-id
    }
}

resource "aws_route_table_association" "subnet_public_a" {
    subnet_id = aws_subnet.public_a.id
    route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "subnet_public_b" {
    subnet_id = aws_subnet.public_b.id
    route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "subnet_private_a" {
    subnet_id = aws_subnet.private_a.id
    route_table_id = aws_route_table.private_zone_a.id
}

resource "aws_route_table_association" "subnet_private_b" {
    subnet_id = aws_subnet.private_b.id
    route_table_id = aws_route_table.private_zone_b.id
}
