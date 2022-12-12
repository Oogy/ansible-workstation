#!/usr/bin/env bash
set -euo pipefail

if [ $# -eq 0 ]; then
  PLAYBOOK="cluster"
else
  BRANCH=$1
fi

ansible-playbook -i ansible/hosts --become --become-user=root ansible/kubespray/$PLAYBOOK.yml
