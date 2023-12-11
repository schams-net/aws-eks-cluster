# Kubernetes Jobs
#
# Description:
# A Job creates one or more Pods and ensures that a specified number of them successfully
# terminate. As pods successfully complete, the Job tracks the successful completions. When
# a specified number of successful completions is reached, the task (ie, Job) is complete.
# Deleting a Job will clean up the Pods it created.
#
# Kubernetes Documentation:
# https://kubernetes.io/docs/concepts/workloads/controllers/job/
#
# Terraform Documentation (Kubernetes provider):
# https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/job

resource "kubernetes_job" "demo" {
    metadata {
        name = "pi"
    }
    spec {
        template {
            metadata {}
            spec {
                container {
                    name = "pi"
                    image = "perl:5.34.0"
                    command = ["perl",  "-Mbignum=bpi", "-wle", "print bpi(2000)"]
                }
                restart_policy = "Never"
            }
        }
        backoff_limit = 4
   }
   wait_for_completion = false
}
