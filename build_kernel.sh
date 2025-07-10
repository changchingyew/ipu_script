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

#rm -rf ${dirname_in_trunk}/kernel/*.tar.bz2 ${dirname_in_trunk}/*.deb ${dirname_in_trunk}/*.buildinfo ${dirname_in_trunk}/*.changes
#rm -rf ${dirname_in_trunk}/out
#make mrproper
#make kernelversion
# echo "" | make -j$(nproc) LOCALVERSION=${KERNEL_BUILD_LABEL} oldconfig
make -j$(nproc) LOCALVERSION=${KERNEL_BUILD_LABEL}
# make -j$(nproc) LOCALVERSION=${KERNEL_BUILD_LABEL} bindeb-pkg
