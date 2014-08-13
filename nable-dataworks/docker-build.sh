#!/bin/bash

docker build --rm -t whlee21/nable-dataworks `dirname $0`
docker images
