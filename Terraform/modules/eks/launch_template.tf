# EC2 Launch Template
#
# Description:
# EC2 launch templates can be used to create auto-scaling groups.
#
# AWS Documentation:
# https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-launch-templates.html
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
            encrypted = true
        }
    }

    tag_specifications {
        resource_type = "instance"
        tags = merge(var.tags, {
            Name = "[${var.tags.Name}] worker nodes"
        })
    }

    tag_specifications {
        resource_type = "volume"
        tags = merge(var.tags, {
            Name = "[${var.tags.Name}] worker nodes"
        })
    }

    tags = merge(var.tags, {
        Name = var.tags.Name
    })
}
