#!/usr/bin/env bash

env=$1

if [ -z "$env" ]; then
  echo "missing env"
  exit 1
fi

varfile=vars/$env.tfvars
statefile=state/$env.tfstate

if [ ! -f terraform/$varfile ]; then
  echo "missing $varfile"
  exit 1
fi

(cd terraform && terraform apply -var-file=$varfile -state=$statefile)