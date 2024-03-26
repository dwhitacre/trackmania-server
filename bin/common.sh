#!/usr/bin/env bash

env=$1

if [ -z "$env" ]; then
  echo "missing env"
  exit 1
fi

varfile=vars/$env.tfvars
statefile=state/$env.tfstate
terraformdir=$(realpath "$(dirname $0)/../terraform")
trackmaniadir=$(realpath "$(dirname $0)/../trackmania")

if [ ! -f $terraformdir/$varfile ]; then
  echo "missing $varfile"
  exit 1
fi
