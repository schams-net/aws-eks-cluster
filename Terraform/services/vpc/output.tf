# Output variables

output "vpc" {
    value = aws_vpc.default
}

output "subnets" {
    value = [
        aws_subnet.public_a,
        aws_subnet.public_b,
        aws_subnet.private_a,
        aws_subnet.private_b
    ]
}

output "subnets_public" {
    value = [
        aws_subnet.public_a,
        aws_subnet.public_b
    ]
}
