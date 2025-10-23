#!/bin/bash

set -x
export SCP_TARGET=root@10.221.251.21
export SSH_PASSWORD="user1234"

declare -a modules=(\
    # "drivers/media/i2c/isx031.ko" \
    # "drivers/i2c/i2c-atr.ko" \
    # "drivers/media/v4l2-core/v4l2*.ko"\
    # "drivers/media/v4l2-core/videodev.ko" \
    "drivers/media/i2c/maxim-serdes/max*.ko" \
    # "drivers/media/pci/intel/ipu-bridge.ko"
    )

# export KERNEL_DIR=~/v4l2/repo/camera/kernel
# export KERNEL_VER=6.12.34-vtg-gmsl

export KERNEL_DIR=~/v4l2/repo/camera/kernel-ml
export KERNEL_VER=6.17.0-maxim-serdes-ml
# sshpass -p $SSH_PASSWORD scp $KERNEL_DIR/arch/x86/boot/bzImage $SCP_TARGET:/boot/vmlinuz-$KERNEL_VER

export SCP_TARGET_DIR=/usr/lib/modules/$KERNEL_VER/kernel

for i in "${!modules[@]}"; do
    basepath=$(dirname "${modules[$i]}")
    sshpass -p $SSH_PASSWORD scp $KERNEL_DIR/${modules[$i]} $SCP_TARGET:$SCP_TARGET_DIR/$basepath
done
