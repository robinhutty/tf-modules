
tflint {
  required_version = ">= 0.61.0"
}

config {
  format = "compact"
  plugin_dir = "~/.tflint.d/plugins"

  call_module_type = "local"  # [all|local|none]
  force = true  # if true, return zero exit status even if issues found
  minimum_failure_severity = "error" # [error|warning|notice], sets minimum severity level for exiting with a non-zero error code

  # disabled_by_default = false

	# Example of ignoring entire Terraform Modules
  # ignore_module = {
  #   "terraform-aws-modules/vpc/aws"            = true
  #   "terraform-aws-modules/security-group/aws" = true
  # }

  varfile = ["example1.tfvars", "example2.tfvars"]
  variables = ["foo=bar", "bar=[\"baz\"]"]
}

plugin "terraform" {
  enabled = true
  preset  = "recommended"  # [recommended|all]
}
plugin "aws" {
	# https://github.com/terraform-linters/tflint-ruleset-aws
  enabled = true
  version = "0.46.0"
  source  = "github.com/terraform-linters/tflint-ruleset-aws"

	# Deep checking uses your provider's credentials to apply additional checks that require read access to a target AWS account. TFLint will read AWS configuration from a provider "aws" {} block or the same environment variables used by the AWS provider. See https://github.com/terraform-linters/tflint-ruleset-aws/blob/master/docs/deep_checking.md before enabling.
	deep_check = false
}


# See https://github.com/terraform-linters/tflint-ruleset-aws/blob/master/docs/rules/README.md
# for details about the 700+ rules that the AWS ruleset for TFLint can use

# rule "aws_instance_invalid_type" {
#   enabled = false
# }

/*
This file configures for TFLint; see https://github.com/terraform-linters/tflint/blob/master/docs/user-guide/config.md and/or set TFLINT_LOG=debug for details

`tflint --init` installs plugins, many of which probably pull from github.com using their [REST API]() and is therefore subject to their [rate limits](https://docs.github.com/en/rest/using-the-rest-api/rate-limits-for-the-rest-api?apiVersion=2022-11-28). So if running frequent pipelines via CI/CD tooling, consider using a GITHUB_TOKEN.

Runtime usage:
	tflint --init
  tflint -v

*/
