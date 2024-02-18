# Terraform Random Generator
#
# Description:
# The random_password resource uses a cryptographic random number generator.
#
# Terrafom Documentation:
# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password

resource "random_password" "password" {
    length = 16
    special = true
    override_special = "!#$%&*?"
}

resource "random_uuid" "basic_authentication_username" {
}

resource "random_uuid" "basic_authentication_password" {
}
