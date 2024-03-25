#!/usr/bin/env bash

env=$1
command=${@:2}

if [ -z "$env" ]; then
  echo "missing env"
  exit 1
fi

if [ -z "$command" ]; then
  command=apply
elif [ "$command" == "replace" ]; then
  command="apply -replace=digitalocean_droplet.server[0]"
fi

varfile=vars/$env.tfvars
statefile=state/$env.tfstate

if [ ! -f terraform/$varfile ]; then
  echo "missing $varfile"
  exit 1
fi

(cd terraform && terraform $command -var-file=$varfile -state=$statefile)