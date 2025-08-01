#!/bin/bash

set -x
export KERNEL_DIR=~/v4l2/repo/camera/kernel
export SCP_TARGET=root@10.221.251.21
export SSH_PASSWORD="user1234"

declare -a modules=(\
    "isx031" \
    "i2c-atr" \
    "v4l2*"\
    )
declare -a dirs=(\
    "drivers/media/i2c" \
    "drivers/i2c" \
    "drivers/media/v4l2-core" \
    )

if [ "$1" == "lts" ]; then
    echo "Using LTS kernel build"
    export KERNEL_VER=6.12.34-vtg-gmsl
    modules+=("*")
    dirs+=("drivers/media/i2c/max9x")
else
    echo "Using non-LTS kernel build"
    export KERNEL_VER=6.12.13-maxim-serdes
    sshpass -p $SSH_PASSWORD scp $KERNEL_DIR/arch/x86/boot/bzImage $SCP_TARGET:/boot/vmlinuz-$KERNEL_VER
    modules+=("max*")
    dirs+=("drivers/media/i2c/maxim-serdes")
fi

export SCP_TARGET_DIR=/usr/lib/modules/$KERNEL_VER/kernel

for i in "${!modules[@]}"; do
    sshpass -p $SSH_PASSWORD scp $KERNEL_DIR/${dirs[$i]}/${modules[$i]}.ko $SCP_TARGET:$SCP_TARGET_DIR/${dirs[$i]}/
done
