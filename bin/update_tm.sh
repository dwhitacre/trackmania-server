#!/usr/bin/env bash

source $(dirname $0)/common_ssh.sh
find $trackmaniadir -type f |
  xargs -I {} basename {} |
  xargs -I {} scp -i $ssh_privkey_path $trackmaniadir/{} root@$ipv4_addr:/opt/trackmania/{}
