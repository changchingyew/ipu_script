#!/bin/bash

set -x
export KERNEL_DIR=~/v4l2/repo/camera/kernel
export SCP_TARGET=root@10.221.251.21
export SCP_TARGET_DIR=/usr/lib/modules/6.12.13-maxim-serdes/kernel
export SSH_PASSWORD="user1234"

sshpass -p $SSH_PASSWORD scp $KERNEL_DIR/drivers/media/i2c/maxim-serdes/*.ko $SCP_TARGET:$SCP_TARGET_DIR/drivers/media/i2c/maxim-serdes/
sshpass -p $SSH_PASSWORD scp $KERNEL_DIR/drivers/media/i2c/isx031.ko $SCP_TARGET:$SCP_TARGET_DIR/drivers/media/i2c/
sshpass -p $SSH_PASSWORD scp $KERNEL_DIR/drivers/i2c/i2c-atr.ko $SCP_TARGET:$SCP_TARGET_DIR/drivers/i2c/