# xylophone-deploy

[![CircleCI](https://circleci.com/gh/hortoncd/xylophone-deploy.svg?style=svg)](https://circleci.com/gh/hortoncd/xylophone-deploy)

Deploy the xylophone website with Chef/Packer and Terraform

## Usage

The repo includes scripts under `./scripts` for most of the steps.  This includes wrapper scripts for the packer and terraform commands, as well as a full deploy script.

The packer and terraform scripts rely on the `default-env.sh` file to setup the appropriate environment variables for passing args to the commands.  This is the primary data that would need to be updated to run in a different environment, and can all be overridden by setting the environment variables used in `default-env.sh`.  They also rely on the AWS key env vars as packer and terraform do by default.

`deploy.sh` - calls the packer and terraform wrapper scripts required to build / update the entire infrastructure.  This script does not run 'terraform init', so the `scripts/tf-init.sh` will need to be run the first time the scripts are used from a fresh checkout of the repo.

`packer-build.sh` - runs `packer build` with the proper environment to create the ami.  Stores the AMI ID in the `AMI` for use by the terraform scripts.

`tf-init.sh` - wrapper to run `terraform init` from the correct location with the proper environment.  Needs to be run before any of the terraform scripts, or the full deploy script.

`tf-plan.sh` - wrapper to run `terraform plan` from the correct location with the proper environment.

`tf-apply.sh` - wrapper to run `terraform apply` from the correct location with the proper environment.

`tf-destroy.sh` - wrapper to run `terraform destroy` from the correct location with the proper environment.

## Testing

There are unit and integration tests for the included cookbook.

### Unit Tests

The unit tests are a basic `Serverspec` setup.

```
cd xylophone-cookbook && rspec
```

### Integrations Tests

These are a basic `Test Kitchen` setup.  The can be run manually, or by a CI system, as follows:

```
cd xylophone-cookbook && kitchen test
```

## License and Authors

Author:: Chris Horton (hortoncd@gmail.com)
License:: Apache 2.0
