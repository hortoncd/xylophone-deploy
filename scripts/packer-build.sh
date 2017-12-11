#!/bin/bash
#
# Wrapper for 'packer build'

[ ! -d packer ] && echo "${0}: This script is built to run from the root directory of the repo" && exit 1

# Source defaults if env not set
. scripts/default-env.sh

# We have a few prerequisites
[[ ! -x "$(which berks)" ]] && echo "${0}: Couldn't find 'berks' in your PATH." && exit 1
[[ ! -x "$(which packer)" ]] && echo "${0}: Couldn't find 'packer' in your PATH." && exit 1

cd xylophone-cookbook
berks vendor ../vendor/cookbooks

cd ..
tmpfile=`mktemp /tmp/packer-build-XXXX`

# Run packer to create the ami
packer build -var 'aws_access_key='"${AWS_ACCESS_KEY_ID}"'' \
  -var 'aws_secret_key='"${AWS_SECRET_ACCESS_KEY}"'' \
  -var 'aws_region='"${AWS_DEFAULT_REGION}"'' \
  -var 'version='"${XYLOPHONE_VERSION}"'' \
  -var 'ssh_private_key='"${DEPLOYER_PRIVATE_KEY}"'' \
  -var 'keypair_name='"${DEPLOYER_KEYPAIR_NAME}"'' \
  -var 'base_ami='"${XYLOPHONE_BASE_AMI}"'' \
  packer/packer.json | tee $tmpfile

ret=$?
[ $ret != 0 ] && echo "${0}: Error running 'packer build': ${ret}" && exit 1

ami=`cat ${tmpfile} | tail -n 3 | grep -v conflicts | awk 'match($0, /ami-.*/) { print substr($0, RSTART, RLENGTH) }'`
[ -z $ami ] && echo "${0}: Error getting ami from 'packer build' output" && exit 1
echo $ami > ./AMI
