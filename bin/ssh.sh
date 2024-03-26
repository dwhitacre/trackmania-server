#!/usr/bin/env bash

source $(dirname $0)/common_ssh.sh
ssh -i $ssh_privkey_path root@$ipv4_addr