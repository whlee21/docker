#!/bin/bash

HOSTNAME=${HOSTNAME}

if [ "${HOSTNAME}" = "nn1" ]; then
	SSHFENCE_TARGET=nn2
else
	SSHFENCE_TARGET=nn1
fi

ssh-keygen -t rsa
ssh sshfence@{SSHFENCE_TARGET} mkdir -p .ssh
ssh sshfence@{SSHFENCE_TARGET} chmod 700 .ssh
ssh sshfence@{SSHFENCE_TARGET} touch .ssh/authorized_keys2
ssh sshfence@{SSHFENCE_TARGET} chmod 640 .ssh/authorized_keys2
cat .ssh/id_rsa.pub | ssh sshfence@{SSHFENCE_TARGET} 'cat >> .ssh/authorized_keys2'
