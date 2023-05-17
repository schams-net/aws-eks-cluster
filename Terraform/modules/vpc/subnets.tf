# Subnets
#
# Description:
# A subnet is a range of IP addresses in your VPC.
#
# AWS Documentation:
# https://docs.aws.amazon.com/vpc/latest/userguide/configure-subnets.html
#
# Terraform Documentation:
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet

resource "aws_subnet" "subnets_public" {
    count = var.subnet_count
    vpc_id = aws_vpc.default.id
    availability_zone = data.aws_availability_zones.available.names[count.index]
    cidr_block = cidrsubnet(var.cidr_block, 8, count.index + 10)
    map_public_ip_on_launch = true
    tags = merge(var.tags, {
        Name = "[${var.tags.Name}] public zone ${data.aws_availability_zones.available.names[count.index]}"
        "kubernetes.io/role/elb" = "1"
    })
}

resource "aws_subnet" "subnets_private" {
    count = var.subnet_count
    vpc_id = aws_vpc.default.id
    availability_zone = data.aws_availability_zones.available.names[count.index]
    cidr_block = cidrsubnet(var.cidr_block, 8, count.index + 20)
    map_public_ip_on_launch = false
    tags = merge(var.tags, {
        Name = "[${var.tags.Name}] private zone ${data.aws_availability_zones.available.names[count.index]}"
    })
}
