#terraform-provider-hpegl

## Introduction

This is the main repo for the GreenLake terraform provider which provides terraform support fot GreenLake services.

We're currently in the process of open sourcing all the code, meanwhile, this repository holds the following:

1. HPEGL release binaries,
1. HPEGL documentation,
1. A script to automate the provider installation for Linux.

## Installation

### Linux

Use the script `tools/install-hpegl-provider.sh` to automatically download and install hpegl provider:

```shell
bash <(curl -sL https://raw.githubusercontent.com/HewlettPackard/terraform-provider-hpegl/main/tools/install-hpegl-provider.sh)
```

The above will install the latest available release. To install a specific release:

```shell
VERSION=v0.0.5 bash <(curl -sL https://raw.githubusercontent.com/HewlettPackard/terraform-provider-hpegl/main/tools/install-hpegl-provider.sh)
```

### MacOS

Before using the install script, install GNU grep via homebrew with `brew install grep`

Use the script `tools/install-hpegl-provider-macos.sh` (or `tools/install-hpegl-provider-macos-m1.sh` on an Apple Silicon machine) to automatically download and install hpegl provider:

```shell
bash <(curl -sL https://raw.githubusercontent.com/HewlettPackard/terraform-provider-hpegl/main/tools/install-hpegl-provider-macos.sh)
```

The above will install the latest available release. To install a specific release:

```shell
VERSION=v0.0.5 bash <(curl -sL https://raw.githubusercontent.com/HewlettPackard/terraform-provider-hpegl/main/tools/install-hpegl-provider-macos.sh)
```
