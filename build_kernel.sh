#!/bin/bash
set -x

dirname_in_trunk=${PWD}/camera

if [ -n "$1" ]; then
    echo "Build kernel-$1"
    cd ${dirname_in_trunk}/kernel-$1/
    KERNEL_BUILD_LABEL="-maxim-serdes-$1"
else
    echo "Standard kernel build"
    cd ${dirname_in_trunk}/kernel/
    KERNEL_BUILD_LABEL="-maxim-serdes"
fi

export ARCH=x86_64

echo "*********************************"
gcc --version
echo "*********************************"

CC="ccache gcc"
# make mrproper
# make kernelversion
# make -j$(nproc) LOCALVERSION=${KERNEL_BUILD_LABEL} oldconfig
if [ "$2" == "deb" ]; then
    make -j$(nproc) LOCALVERSION=${KERNEL_BUILD_LABEL} bindeb-pkg
else
    make -j$(nproc) LOCALVERSION=${KERNEL_BUILD_LABEL}
fi
