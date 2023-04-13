#!/bin/bash
# ==============================================================================

export AWS_REGION="ap-southeast-2"
export CLUSTER_NAME="KubernetesCluster"

BLACK="0";RED="1";GREEN="2";YELLOW="3";BLUE="4";MAGENTA="5";CYAN="6";WHITE="7"
LBLACK="8";LRED="9";LGREEN="10";LYELLOW="11";LBLUE="12";LMAGENTA="13";LCYAN="14";LWHITE="15"

function output() {
	OUTPUT_TIMESTAMP=$(date +"%d/%b/%Y %H:%M:%S %Z")
	echo "[${OUTPUT_TIMESTAMP}] $1"
	tput sgr0
}

OIDC_ID=$(aws eks describe-cluster --name ${CLUSTER_NAME} --query "cluster.identity.oidc.issuer" --output text | cut -d '/' -f 5)
tput setaf ${LWHITE} ; output "OIDC provider ID: ${OIDC_ID}"

# ...
TEMP=$(aws iam list-open-id-connect-providers | grep ${OIDC_ID} | cut -d "/" -f4)
if [ "${TEMP}" = "" ]; then
	tput setaf ${LWHITE} ; output "Creating IAM Open ID Connect provider"
	eksctl utils associate-iam-oidc-provider --cluster ${CLUSTER_NAME} --approve
	if [ $? -ne 0 ]; then tput setaf ${LRED} ; output "Error" ; read -p "Press <ENTER> to continue or <CTRL>+c to abort: " TEMP ; fi
else
	tput setaf ${LMAGENTA} ; output "IAM Open ID Connect provider already exists"
fi

tput setaf ${LWHITE} ; output "Downloading IAM policy for the AWS Load Balancer Controller"
curl -s https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.4.7/docs/install/iam_policy.json > /tmp/iam_policy.json

tput setaf ${LWHITE} ; output "Creating IAM policy"
aws iam create-policy --policy-name AWSLoadBalancerControllerIAMPolicy --policy-document file:///tmp/iam_policy.json > /dev/null
if [ $? -ne 0 ]; then tput setaf ${LRED} ; output "Error" ; read -p "Press <ENTER> to continue or <CTRL>+c to abort: " TEMP ; fi

# Note: you can delete an existing IAM policy by executing the following command if required:
# IAM_POLICY_ARN=$(aws iam list-policies --scope Local | jq -r '.Policies[] | select(.PolicyName=="AWSLoadBalancerControllerIAMPolicy") | .Arn')
# aws iam delete-policy --policy-arn ${IAM_POLICY_ARN}

AWS_ACCOUNT=$(aws sts get-caller-identity | jq -r '.Account')
tput setaf ${LWHITE} ; output "AWS account ID: ${AWS_ACCOUNT}"

tput setaf ${LWHITE} ; output "Creating Kubernetes service account"
eksctl create iamserviceaccount --cluster=${CLUSTER_NAME} --namespace=kube-system --name=aws-load-balancer-controller --role-name AmazonEKSLoadBalancerControllerRole --attach-policy-arn=arn:aws:iam::${AWS_ACCOUNT}:policy/AWSLoadBalancerControllerIAMPolicy --approve
if [ $? -ne 0 ]; then tput setaf ${LRED} ; output "Error" ; read -p "Press <ENTER> to continue or <CTRL>+c to abort: " TEMP ; fi

# Note: you can delete an existing IAM Service Account by executing the following command if required:
# eksctl delete iamserviceaccount --cluster=${CLUSTER_NAME} --namespace=kube-system --name=aws-load-balancer-controller

HELM_REPO_EKS_URL="https://aws.github.io/eks-charts"
HELM_REPO_EKS=$(helm repo list | egrep '^eks' | head -1 | cut -f 2)
if [ "${HELM_REPO_EKS}" = "" ]; then
	tput setaf ${LRED} ; output "AWS EKS Helm repository missing!"
	read -p "Press <ENTER> to add the repository or <CTRL>+c to abort: " TEMP
	helm repo add eks ${HELM_REPO_EKS_URL}
else
	tput setaf ${LWHITE} ; output "[Helm] AWS EKS repository found: ${HELM_REPO_EKS}"
fi

tput setaf ${LWHITE} ; output "[Helm] Update local repo to make sure that most recent charts are used"
helm repo update
if [ $? -ne 0 ]; then tput setaf ${LRED} ; output "Error" ; read -p "Press <ENTER> to continue or <CTRL>+c to abort: " TEMP ; fi

tput setaf ${LWHITE} ; output "[Helm] Installing AWS Load Balancer Controller"
helm install aws-load-balancer-controller eks/aws-load-balancer-controller -n kube-system --set clusterName=${CLUSTER_NAME} --set serviceAccount.create=false --set serviceAccount.name=aws-load-balancer-controller 
if [ $? -ne 0 ]; then tput setaf ${LRED} ; output "Error" ; read -p "Press <ENTER> to continue or <CTRL>+c to abort: " TEMP ; fi

echo
exit 0

# ==============================================================================
# Commands to undo the setup
#
# helm uninstall aws-load-balancer-controller
# eksctl delete iamserviceaccount --cluster=${CLUSTER_NAME} --namespace=kube-system --name=aws-load-balancer-controller
# IAM_POLICY_ARN=$(aws iam list-policies --scope Local | jq -r '.Policies[] | select(.PolicyName=="AWSLoadBalancerControllerIAMPolicy") | .Arn')
# aws iam delete-policy --policy-arn ${IAM_POLICY_ARN}

# ==============================================================================
