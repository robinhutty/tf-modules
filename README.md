---
date: 2025-07-16T16:50:18-0400
draft: true
params:
  author: Robin Hutty
title: Modules for OpenTofu/Terraform
---

* These modules are only intended to be "child" modules; they are only intended to be called by other OpenTofu/Terraform modules.
* Modules that are intended to be root/parent modules, modules which can be called by Terragrunt or OpenTofu/Terraform directly live are [also available](../tf/).
* The directory hierarchy for these modules is organized according to GitLab’s [convention](https://docs.gitlab.com/user/packages/terraform_module_registry/#using-the-api) which uses `module-system/module-name`, e.g. `aws/aws-ec2`. Each module SHOULD be pinned using [SemVer2.0](https://semver.org/), although you MAY skip that for modules that are still in initial development and are not yet used anywhere.

## Use an existing module

### From OpenTofu/Terraform directly

```hcl
module "<your identifier for the module>" {

# source = "..."
# version = "~> 0.1.0"

# Then pass variables
# foo = "bar"
}
```


### From Terragrunt

```hcl
terraform {

# source = "..."
# version = "~> 0.1.0"

}

inputs = {

# Then pass variables
# foo = "bar"

}
```

## Developing

### How to develop an existing module

TODO: pre-commit, conventional commits, style guidelines, testing, etc.

### How to develop a new module

Use [boilerplate][2] to generate scaffolding for new modules so that creating/updating our body of terraform module code is familiar/conventional (for low cognitive load), easy to write, easy to test, and less error-prone. See the [author's announcement](https://blog.gruntwork.io/introducing-boilerplate-6d796444ecf6) for more details. In some ways, it is much like other TF scaffolding tools like [tfscaffold](https://github.com/tfutils/tfscaffold) or perhaps even more tool like the more general [cookiecutter](https://cookiecutter.readthedocs.io). See my article on [Tips for TF][4] for code for a new [TF module](./boilerplate/tf_module).

[1]: https://robin.hutty.us/articles/tips-tf/
[2]: https://github.com/gruntwork-io/boilerplate

In the "sibling" level repository, [templates](../templates), is a [`boilerplate` template](../templates/boilerplate/tf_module) which can scaffold a new tf module, providing various conveniences to help jumpstart a new highly conventional tf module.

The basic command, which should be run from the root of this repository once you have cloned the above repo, is:

```console
boilerplate --template-url ../templates/boilerplate/tf_module \
  --output-folder ./modules/<module-system>/<new-module-name> \
  --non-interactive --var ModuleName=<new-module-name>
```

### How to develop the boilerplate template for tf_modules

Want to contribute to improving the template for tf modules?

See the [templates/boilerplate README](../templates/boilerplate/README.md)
