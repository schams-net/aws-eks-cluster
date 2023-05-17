# ...

resource "random_integer" "rand" {
    min = 10000
    max = 99999
}

#locals {
#    role_ec2 = "${var.project_identifier}-ec2-role-${random_integer.rand.result}"
#    role_ec2_solr = "${var.project_identifier}-ec2-solr-role-${random_integer.rand.result}"
#    role_backup = "${var.project_identifier}-backup-role-${random_integer.rand.result}"
#    role_lambda_function_autoscaling_events = "Lambda-${replace(var.tags.name, "/\\s+/", "")}-AutoscalingEvents-${random_integer.rand.result}"
#    role_lambda_function_deployment_notification = "Lambda-${replace(var.tags.name, "/\\s+/", "")}-DeploymentNotification-${random_integer.rand.result}"
#}

#locals {
#
##    role_ec2 = "${var.project_identifier}-ec2-role"
##    role_ec2_solr = "${var.project_identifier}-ec2-solr-role"
##    role_backup = "${var.project_identifier}-backup-role"
#
#    #role_lambda_function_update_domain_record = "Lambda-${replace(var.tags.name, "/\\s+/", "")}-UpdateDomainRecord"
#    #role_lambda_function_update_domain_record = "Lambda-${var.project_identifier}-update-domain_record"
#
#}

locals {
    account_id = data.aws_caller_identity.current.account_id
}