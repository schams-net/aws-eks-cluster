# NAT Gateway and Elastic IPs (EIP)
#
# Description:
# A NAT gateway is a Network Address Translation (NAT) service. You can use a NAT gateway so that
# EC2 instances in a private subnet can connect to services outside your VPC but external services
# cannot initiate a connection with those instances.
#
# AWS Documentation:
# https://docs.aws.amazon.com/vpc/latest/userguide/vpc-nat-gateway.html
#
# Terrafom Documentation:
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip

resource "aws_nat_gateway" "default" {
    count = var.subnet_count

    # "allocation_id" is required for a NAT Gateway with connectivity type "public".
    allocation_id = aws_eip.default[count.index].id

    subnet_id = aws_subnet.subnets_public[count.index].id

    # To ensure proper ordering, it is recommended to add an explicit dependency on the Internet
    # Gateway for the VPC.
    depends_on = [aws_internet_gateway.default]

    tags = merge(var.tags, {
        Name = "[${var.tags.Name}] NAT Gateway ${data.aws_availability_zones.available.names[count.index]}"
    })
}

resource "aws_eip" "default" {
    count = var.subnet_count
    domain = "vpc"
    tags = merge(var.tags, {
        Name = "[${var.tags.Name}] ${data.aws_availability_zones.available.names[count.index]}"
    })
}
