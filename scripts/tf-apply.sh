#!/bin/bash
#
# Wrapper for 'terraform apply'

[ ! -d terraform ] && echo "${0}: This script is built to run from the root directory of the repo" && exit 1

# Source defaults if env not set
. scripts/default-env.sh

# We have a few prerequisites
[[ ! -x "$(which terraform)" ]] && echo "${0}: Couldn't find terraform in your PATH. Please see https://www.terraform.io/downloads.html" && exit 1
[[ ! -x "$(which curl)" ]] && echo "${0}: Couldn't find curl in your PATH." && exit 1

# Grab our external IP for the security groups
MANAGEMENT_IP=$(curl -s http://ipinfo.io/ip)
[[ ! "$MANAGEMENT_IP" =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]] && echo "${0}: Couldn't determine your external IP: $MANAGEMENT_IP" && exit 1

tmpfile=`mktemp /tmp/tf-apply-XXXX`

# Run terraform to create the resources
cd terraform && terraform apply tfplan
