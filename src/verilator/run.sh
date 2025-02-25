#!/bin/bash

set -ex
set -o pipefail

SCRIPTDIR=$(dirname $0)
BASENAME=$(basename $SCRIPTDIR)

cd ${SCRIPTDIR}

if [[ ! -d build ]]; then {
    mkdir build
} fi

cd build

cmake .. -DBUILD_NETLIST:bool=false
make -j $(nproc) comp
./comp +verilator+rand+reset+0
./comp +verilator+rand+reset+1
./comp +verilator+rand+reset+2 +verilator+seed+$(($RANDOM * 65536 + $RANDOM))
