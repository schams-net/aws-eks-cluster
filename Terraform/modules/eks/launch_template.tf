# EC2 Launch Template
#
# Description:
# ...
#
# AWS Documentation:
# ...
#
# Terraform Documentation:
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template

resource "aws_launch_template" "default" {
    name = "${lower(var.tags.Name)}-launch-template"
    #description = "..."

    update_default_version = true

    # Do not specify an instance profile in the launch template!
    # The noderole in your request will be used to construct an instance profile.
    #iam_instance_profile { ... }

    # ...
    block_device_mappings {
        device_name = "/dev/xvda"
        ebs {
            volume_type = "gp2"
            volume_size = 16
        }
    }

    tag_specifications {
        resource_type = "instance"
        tags = {
            Name = "[${var.tags.Name}] worker nodes"
            billing-id = var.tags.billing-id
        }
    }

    tag_specifications {
        resource_type = "volume"
        tags = {
            Name = "[${var.tags.Name}] worker nodes"
            billing-id = var.tags.billing-id
        }
    }

    tags = {
        Name = "[${var.tags.Name}]"
        billing-id = var.tags.billing-id
    }
}
