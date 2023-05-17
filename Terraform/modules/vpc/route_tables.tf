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

# route table for public subnets
resource "aws_route_table" "public" {
    count = var.subnet_count
    vpc_id = aws_vpc.default.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.default.id
    }
    tags = merge(var.tags, {
        Name = "[${var.tags.Name}] public subnets"
    })
}

resource "aws_route_table_association" "subnets_public" {
    count = var.subnet_count
    subnet_id = aws_subnet.subnets_public[count.index].id
    route_table_id = aws_route_table.public[count.index].id
}

# route table for private subnets
resource "aws_route_table" "private" {
    count = var.subnet_count
    vpc_id = aws_vpc.default.id

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.default[count.index].id
    }
    tags = merge(var.tags, {
        Name = "[${var.tags.Name}] private subnets"
    })
}

# private
resource "aws_route_table_association" "subnets_private" {
    count = var.subnet_count
    subnet_id = aws_subnet.subnets_private[count.index].id
    route_table_id = aws_route_table.private[count.index].id
}
