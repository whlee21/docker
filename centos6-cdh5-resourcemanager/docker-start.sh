#!/bin/bash


docker start rm1 rm2
sudo ./bin/pipework br1 rm1 10.0.10.9/24@10.0.10.254
sudo ./bin/pipework br1 rm2 10.0.10.10/24@10.0.10.254
