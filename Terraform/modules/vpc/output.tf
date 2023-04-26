# Output variables

output "vpc" {
    value = aws_vpc.default
}

output "subnets" {
    value = aws_subnet.subnets
}
