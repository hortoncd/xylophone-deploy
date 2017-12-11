#!/bin/bash
#
# Full deploy using packer to build artifacts and terraform to create infrastructure

[ ! -d packer ] && echo "${0}: This script is built to run from the root directory of the repo" && exit 1

# Run packer
./scripts/packer-build.sh
ret=$?
[ $ret != 0 ] && echo "${0}: Error running 'packer build': ${ret}" && exit 1

# Test 'terraform plan'
./scripts/tf-plan.sh
ret=$?
[ $ret != 0 ] && echo "${0}: Error running 'terraform plan': ${ret}" && exit 1

# Deploy infrastructure with 'terraform apply'
./scripts/tf-apply.sh
ret=$?
[ $ret != 0 ] && echo "${0}: Error running 'terraform apply': ${ret}" && exit 1
