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
        Name = "${var.tags.Name} public subnets"
        billing-id = var.tags.billing-id
    }
}

resource "aws_route_table_association" "subnets" {
    count = var.subnet_count
    subnet_id = aws_subnet.subnets[count.index].id
    route_table_id = aws_route_table.public.id
}
