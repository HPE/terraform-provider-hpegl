#!/usr/bin/env bash

set -e

os="linux"
arch="amd64"
repo="HPE/terraform-provider-hpegl"
linux_hpegl_dir="${HOME}/.local/share/terraform/plugins/registry.terraform.io/hpe/hpegl"

get_latest_release () {
  local release_url="https://api.github.com/repos/${repo}/releases/latest"
  curl -sL "$release_url" | grep -Po '"tag_name": "\K.*?(?=")'
}

download_and_extract () {
  local dest_dir="${linux_hpegl_dir}/${version_number}/${os}_${arch}/"
  local hpegl_zip="terraform-provider-hpegl_${version_number}_${os}_${arch}.zip"
  local hpegl_dl_url="https://github.com/${repo}/releases/download/${VERSION}/${hpegl_zip}"

  mkdir -p "$dest_dir" && cd "$dest_dir"
  curl -sL "$hpegl_dl_url" -o "$hpegl_zip" && \
    unzip -u "$hpegl_zip" && \
    rm -f "$hpegl_zip"
}

VERSION=${VERSION:=$(get_latest_release)}
version_number=${VERSION//v}
download_and_extract
