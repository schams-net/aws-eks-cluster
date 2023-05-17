# NAT Gateway
#
# Description:
# @TODO
#
# AWS Documentation:
# @TODO
#
# Terrafom Documentation:
# @TODO

resource "aws_nat_gateway" "default" {
    count = var.subnet_count

    # "allocation_id" is required for a NAT Gateway with connectivity type "public".
    allocation_id = aws_eip.default[count.index].id

    subnet_id = aws_subnet.subnets_private[count.index].id

    # To ensure proper ordering, it is recommended to add an explicit dependency on the Internet
    # Gateway for the VPC.
    depends_on = [aws_internet_gateway.default]

    tags = merge(var.tags, {
        Name = "[${var.tags.Name}] NAT Gateway ${data.aws_availability_zones.available.names[count.index]}"
    })
}

resource "aws_eip" "default" {
    count = var.subnet_count
    vpc = true
    tags = merge(var.tags, {
        Name = "[${var.tags.Name}] ${data.aws_availability_zones.available.names[count.index]}"
    })
}
