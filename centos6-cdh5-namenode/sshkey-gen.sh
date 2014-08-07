#!/bin/bash

ssh-keygen -t rsa
ssh sshfence@{NAMENODE} mkdir -p .ssh
ssh sshfence@{NAMENODE} chmod 700 .ssh
ssh sshfence@{NAMENODE} touch .ssh/authorized_keys2
ssh sshfence@{NAMENODE} 640 .ssh/authorized_keys2
cat .ssh/id_rsa.pub | ssh sshfence@{NAMENODE} 'cat >> .ssh/authorized_keys2'
