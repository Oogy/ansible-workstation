#!/usr/bin/env bash
set -euxo pipefail

ANSIBLE_URL="https://github.com/3letteragency/ansible-3la-microcloud.git"

safe_apt(){
	while fuser /var/{lib/{dpkg,apt/lists},cache/apt/archives}/lock >/dev/null 2>&1 ; do
		echo "Waiting for apt lock..."
		sleep 1
	done
	apt "$@"
}

dependencies(){
	safe_apt -y update
	safe_apt -y install python3-pip
        pip3 install ansible
}

install(){
	ansible-pull -i localhost -U ${ANSIBLE_URL} main.yml
}

main(){
  dependencies
  install
}

main
