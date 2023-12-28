#!/usr/bin/env bash
set -euo pipefail

REPLICATOR_INSTALL_DEPENDENCIES="git yq"
REPLICATOR_INSTALL_DIR="/opt/replicator"
REPLICATOR_SRC="https://github.com/Oogy/replicator.git"
REPLICATOR_INSTALL_FILES=("lib" "bin" "config")
REPLICATOR_TMP_DIR=$(mktemp -d)

cd $REPLICATOR_TMP_DIR && \
	git clone $REPLICATOR_SRC && \
	cd replicator && \
	source ./lib/*

if ! $(directory_exists $REPLICATOR_INSTALL_DIR); then
	mkdir -p $REPLICATOR_INSTALL_DIR
fi

for directory in ${REPLICATOR_INSTALL_FILES[@]}; do
	copy_directory $directory ${REPLICATOR_INSTALL_DIR}
done

replicate ${REPLICATOR_INSTALL_DIR}/config/default.yaml
