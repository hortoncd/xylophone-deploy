# Set default values for required env vars if they're not already set.

[ -z $DEPLOYER_PRIVATE_KEY ] && export DEPLOYER_PRIVATE_KEY="/home/ubuntu/deployer.pem"
[ -z $DEPLOYER_KEYPAIR_NAME ] && export DEPLOYER_KEYPAIR_NAME="deployer"
[ -z $AWS_DEFAULT_REGION ] && export AWS_DEFAULT_REGION="us-east-2"
[ -z $XYLOPHONE_BASE_AMI ] && export XYLOPHONE_BASE_AMI='ami-82f4dae7'

# Use the cookbook version for versioning for ami, since it will change for each deployment
[ -z $XYLOPHONE_VERSION ] && export XYLOPHONE_VERSION=`cd xylophone-cookbook && berks info xylophone | grep Version | awk '{print $2}'`

ami=`cat AMI`
if [ -z $ami ]; then
  # Initially might not have a stored ami ID until after packer build
  [ -z $XYLOPHONE_AMI ] && export XYLOPHONE_AMI="invalid-ami"
else
  [ -z $XYLOPHONE_AMI ] && export XYLOPHONE_AMI=`cat ./AMI`
fi
