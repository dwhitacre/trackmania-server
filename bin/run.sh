#!/usr/bin/env bash

source $(dirname $0)/common.sh

command=${@:2}

if [ -z "$command" ]; then
  command=apply
elif [ "$command" == "replace" ]; then
  command="apply -replace=digitalocean_droplet.server[0]"
fi

{
  cd $terraformdir && terraform $command -var-file=$varfile -state=$statefile
}