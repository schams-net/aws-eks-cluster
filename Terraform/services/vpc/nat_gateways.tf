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

resource "aws_nat_gateway" "zone_a" {
    allocation_id = aws_eip.zone_a.id
    subnet_id = aws_subnet.private_a.id

    tags = {
        Name = "${var.tags.Name} Gateway Zone A"
    }

    # To ensure proper ordering, it is recommended to add an explicit dependency on the Internet
    # Gateway for the VPC.
    depends_on = [aws_internet_gateway.default]
}

resource "aws_nat_gateway" "zone_b" {
    allocation_id = aws_eip.zone_b.id
    subnet_id = aws_subnet.private_b.id

    tags = {
        Name = "${var.tags.Name} Gateway Zone B"
    }

    # To ensure proper ordering, it is recommended to add an explicit dependency on the Internet
    # Gateway for the VPC.
    depends_on = [aws_internet_gateway.default]
}
