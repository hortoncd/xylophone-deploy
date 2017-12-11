#!/bin/bash
#
# Wrapper for 'terraform plan'

[ ! -d terraform ] && echo "${0}: This script is built to run from the root directory of the repo" && exit 1

# Source defaults if env not set
. scripts/default-env.sh

# We have a few prerequisites
[[ ! -x "$(which terraform)" ]] && echo "${0}: Couldn't find terraform in your PATH. Please see https://www.terraform.io/downloads.html" && exit 1
[[ ! -x "$(which curl)" ]] && echo "${0}: Couldn't find curl in your PATH." && exit 1

# Grab our external IP for the security groups
MANAGEMENT_IP=$(curl -s http://ipinfo.io/ip)
[[ ! "$MANAGEMENT_IP" =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]] && echo "${0}: Couldn't determine your external IP: $MANAGEMENT_IP" && exit 1

# Run terraform to check the plan for the resources
cd terraform && terraform plan -out=tfplan -input=false \
  -var 'aws_access_key='"${AWS_ACCESS_KEY_ID}"'' \
  -var 'aws_secret_key='"${AWS_SECRET_ACCESS_KEY}"'' \
  -var 'aws_region='"${AWS_DEFAULT_REGION}"'' \
  -var 'ami='"${XYLOPHONE_AMI}"'' \
  -var 'management_ip='"$MANAGEMENT_IP"'' \
  -var 'ssh_private_key='"${DEPLOYER_PRIVATE_KEY}"'' \
  -var 'keypair_name='"${DEPLOYER_KEYPAIR_NAME}"'' \
  -var 'xylophone_version='"${XYLOPHONE_VERSION}"''
