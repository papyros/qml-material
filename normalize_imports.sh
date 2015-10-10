#!/bin/bash

ROOT=$1
VERSION=$2

for F in  $(grep -rl "${ROOT}" .)
do
    sed -i -r "s:import ${ROOT} [0-9]+.[0-9]+:import ${ROOT} ${VERSION}:g" $F
done
