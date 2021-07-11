#!/usr/bin/env bash
set -euxo pipefail

ANSIBLE_URL="https://github.com/Oogy/ansible-workstation.git"

os_family(){
  uname -s
}

safe_apt(){
	while fuser /var/{lib/{dpkg,apt/lists},cache/apt/archives}/lock >/dev/null 2>&1 ; do
		echo "Waiting for apt lock..."
		sleep 1
	done
	apt "$@"
}

linux_dependencies(){
    echo "doing linux things"
	safe_apt -y update
	safe_apt -y install python3-pip git
    pip3 install ansible
}

mac_dependencies(){
    echo "doing mac things"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    brew install python git
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
	ansible-pull -i localhost -U ${ANSIBLE_URL} main.yml
}

main(){
  dependencies
  install
}

main
