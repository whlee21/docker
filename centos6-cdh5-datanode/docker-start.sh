#!/bin/bash


docker start dn1 dn2 dn3
sudo ./bin/pipework br1 dn1 10.0.10.12/24@10.0.10.254
sudo ./bin/pipework br1 dn2 10.0.10.13/24@10.0.10.254
sudo ./bin/pipework br1 dn3 10.0.10.14/24@10.0.10.254
