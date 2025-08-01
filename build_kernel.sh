#!/bin/bash
set -x

dirname_in_trunk=${PWD}/camera

if [ "$1" == "lts" ]; then
        echo "Using LTS kernel build"
        cd ${dirname_in_trunk}/kernel-lts/
        KERNEL_BUILD_LABEL="-vtg-gmsl"
else
    echo "Using non-LTS kernel build"
    cd ${dirname_in_trunk}/kernel/
    KERNEL_BUILD_LABEL="-maxim-serdes"
fi

export ARCH=x86_64

echo "*********************************"
gcc --version
echo "*********************************"

# CC="ccache gcc"
# make mrproper
# make kernelversion
# make -j$(nproc) LOCALVERSION=${KERNEL_BUILD_LABEL} oldconfig
if [ "$2" == "deb" ]; then
    make -j$(nproc) LOCALVERSION=${KERNEL_BUILD_LABEL} bindeb-pkg
else
    make -j$(nproc) LOCALVERSION=${KERNEL_BUILD_LABEL}
fi
