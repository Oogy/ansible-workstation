#!/usr/bin/env bash
set -euxo pipefail

APT_SOURCES="/etc/apt/sources.list"
PVE_ENTERPRISE_SOURCES="/etc/apt/sources.list.d/pve-enterprise.list"
ANSIBLE_URL="https://github.com/Oogy/workstation.git"

configure_apt(){
  if ! grep -q "pve-no-subscription" $APT_SOURCES; then
    echo " " >> $APT_SOURCES
    echo "deb http://download.proxmox.com/debian/pve bullseye pve-no-subscription" >> $APT_SOURCES
  fi

  if test -f $PVE_ENTERPRISE_SOURCES; then
    rm -f $PVE_ENTERPRISE_SOURCES
  fi
  
  apt -y update
  apt -y upgrade
}

dependencies(){
  apt -y install python3-pip git sudo
  pip3 install ansible
}

install(){
  PYTHONUNBUFFERED=1 ANSIBLE_LOG_PATH=/var/log/ansible.log ansible-pull -i ansible/hosts -U ${ANSIBLE_URL} ansible/main.yaml
}

main(){
  configure_apt
  dependencies
  install
}

main
