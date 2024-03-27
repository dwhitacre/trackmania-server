#!/usr/bin/env bash

source $(dirname $0)/common_ssh.sh

scp -i $ssh_privkey_path -r $trackmaniadir/* root@$ipv4_addr:/opt/trackmania/
ssh -i $ssh_privkey_path root@$ipv4_addr 'chown -R 9999:9999 /opt/trackmania/Maps && chmod -R 777 /opt/trackmania/Maps'

# find $trackmaniadir -type f |
#   xargs -I {} basename {} |
#   xargs -I {} scp -i $ssh_privkey_path $trackmaniadir/{} root@$ipv4_addr:/opt/trackmania/{}
