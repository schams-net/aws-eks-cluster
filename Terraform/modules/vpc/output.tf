# Output variables

output "vpc" {
    value = aws_vpc.default
}

output "subnets" {
    value = {
        public = aws_subnet.subnets_public
        private = aws_subnet.subnets_private
    }
}
