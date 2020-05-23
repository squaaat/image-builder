#!/bin/bash
set -e

GITHUB_ACCOUNTS=$1

app () {
  local authorizedKeyFile='/home/ubuntu/.ssh/authorized_keys'
  IFS=$'\,'
  local accounts=($GITHUB_ACCOUNTS)
  IFS=$' '

  for account in "${accounts[@]}"; do
    echo $account
    curl -s https://github.com/$account.keys >> $authorizedKeyFile
  done

  chown -R ec2-user:ec2-user $authorizedKeyFile
  chmod 600 $authorizedKeyFile
}

app
