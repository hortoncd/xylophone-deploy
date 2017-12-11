#!/bin/bash
#
# Wrapper for 'terraform init'

[ ! -d terraform ] && echo "${0}: This script is built to run from the root directory of the repo" && exit 1

# Run terraform to init the terraform environment
cd terraform && terraform init
