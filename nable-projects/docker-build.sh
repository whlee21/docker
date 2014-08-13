#!/bin/bash

docker build --rm -t whlee21/nable-projects `dirname $0`
docker images
