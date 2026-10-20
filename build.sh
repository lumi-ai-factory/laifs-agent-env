#!/bin/bash

DEF_FILE=apptainer/opencode.def
VERSION="$(grep --perl-regexp --only-matching '(?<=OPENCODE_VERSION=)((\d+\.?)+)' $DEF_FILE)"

apptainer build "sif/opencode_${VERSION}.sif" "$DEF_FILE"
