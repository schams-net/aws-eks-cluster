# AWS EKS Cluster

## Download

```console
$ git clone https://github.com/schams-net/aws-eks-cluster
$ cd aws-eks-cluster/
$ git checkout anomaly/main
```

## Deployment of the Infrastructure

Edit the file `Terraform/variables.tf` and adjust the settings as required.

- Variable `profile`: The AWS CLI profile, see [AWS documentation](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html).
- Variable `region`: The desired AWS region of your infrastructure.
- Variable `tags.Name`: An arbitrary name to be used as a prefix for all resources.
- Variable `tags.billing-id`: An arbitrary identifier used for the billing ID tag across all resources.

```console
$ cd Terraform/
$ terraform init
$ terraform apply
```

The deployment takes approximately 15 to 20 minutes.

## Deployment of a Test Application

```console
$ export AWS_REGION="ap-southeast-2"
$ export CLUSTER_NAME="KubernetesCluster"
$ export NAMESPACE="kube-system"
```

Update the local Kubernetes config for `kubectl`:

```console
$ aws eks update-kubeconfig --name ${CLUSTER_NAME}
```

``` console
$ kubectl apply -f ../Kubernetes/eks-sample-application.yaml
```
