#!/usr/bin/env bash

source $(dirname $0)/common.sh

server=$2
if [ -z "$server" ]; then
  server="0"
fi

{
  cd $terraformdir
  tf_output=$(terraform output -state=$statefile -json)
  ipv4_addr=$(echo $tf_output | jq -r ".tm_servers_public.value[$server]")
  ssh_privkey_path=$(echo $tf_output | jq -r ".do_ssh_privkey_path.value")
}