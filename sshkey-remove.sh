#!/bin/bash

CONTAINERS="rm1 rm2 hs nn1 nn2 dn1 dn2 dn3 jn1 jn2 jn3 zk1 zk2 zk3"

for container in ${CONTAINERS}; do
  ssh-keygen -f "/home/whlee21/.ssh/known_hosts" -R ${container}
done
