#!/usr/bin/env bash
set -euo pipefail

ANSIBLE_URL="https://github.com/Oogy/replicator.git"
REPLICATOR_CONFIG_DIR="/opt/replicator"

os_family(){
  uname -s
}

safe_apt(){
	while fuser /var/{lib/{dpkg,apt/lists},cache/apt/archives}/lock >/dev/null 2>&1 ; do
		echo "+ Waiting for apt lock..."
		sleep 1
	done
	apt "$@"
}

linux_dependencies(){
    echo "+ doing linux things"
	  safe_apt -y update
	  safe_apt -y install python3-pip git
    pip3 install ansible
    echo "+ creating aw config dir"
    sudo mkdir -p ${AW_CONFIG_DIR}
    echo "+ Setting Ansible Vault Password"
    read -s -p "Enter Ansible Vault Password: " VAULT_PASSWORD
    echo ${VAULT_PASSWORD} > ${AW_CONFIG_DIR}/vault-password
    chmod 0600 $AW_CONFIG_DIR/vault-password
}

mac_dependencies(){
    echo "+ doing mac things"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    brew install python git flock
    python -m pip install ansible
}

dependencies(){
    case $(os_family) in
        Linux)
            linux_dependencies
            ;;
        Darwin)
            mac_dependencies
            ;;
    esac
}

install(){
    case $(os_family) in
        Linux)
	        sudo flock -n /tmp/replicator.lock -c "PYTHONUNBUFFERED=1 ANSIBLE_LOG_PATH=/var/log/ansible-workstation.log ANSIBLE_VAULT_PASSWORD_FILE=/opt/replicator/vault-password /usr/local/bin/ansible-pull -i ansible/hosts.yaml -U https://github.com/oogy/replicator.git ansible/main.yaml"
            ;;
        Darwin)
            flock -n /tmp/replicator.lock -c "PYTHONUNBUFFERED=1 ANSIBLE_LOG_PATH=/var/log/ansible-workstation.log /usr/local/bin/ansible-pull -i ansible/hosts.yaml -U https://github.com/oogy/replicator.git ansible/main.yaml"
            ;;
    esac
}

main(){
  dependencies
  install
}

main
