#!/bin/bash

set -x
export KERNEL_DIR=~/v4l2/repo/camera/kernel
export SCP_TARGET=root@10.221.251.21
export SSH_PASSWORD="user1234"

if [ "$1" == "lts" ]; then
    echo "Using LTS kernel build"
    export SCP_TARGET_DIR=/usr/lib/modules/6.12.34-vtg-gmsl/kernel
    sshpass -p $SSH_PASSWORD scp $KERNEL_DIR/drivers/media/i2c/max9x/*.ko $SCP_TARGET:$SCP_TARGET_DIR/drivers/media/i2c/max9x/
else
    echo "Using non-LTS kernel build"
    export SCP_TARGET_DIR=/usr/lib/modules/6.12.13-maxim-serdes/kernel
    sshpass -p $SSH_PASSWORD scp $KERNEL_DIR/arch/x86/boot/bzImage $SCP_TARGET:/boot/vmlinuz-6.12.13-maxim-serdes
    sshpass -p $SSH_PASSWORD scp $KERNEL_DIR/drivers/media/i2c/maxim-serdes/*.ko $SCP_TARGET:$SCP_TARGET_DIR/drivers/media/i2c/maxim-serdes/
fi

sshpass -p $SSH_PASSWORD scp $KERNEL_DIR/drivers/media/i2c/isx031.ko $SCP_TARGET:$SCP_TARGET_DIR/drivers/media/i2c/
# sshpass -p $SSH_PASSWORD scp $KERNEL_DIR/drivers/i2c/i2c-atr.ko $SCP_TARGET:$SCP_TARGET_DIR/drivers/i2c/
sshpass -p $SSH_PASSWORD scp $KERNEL_DIR/drivers/i2c/i2c-mux.ko $SCP_TARGET:$SCP_TARGET_DIR/drivers/i2c/