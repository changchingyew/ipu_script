#!/bin/bash

ROOT_DIR="/home/data/cyew3/v4l2/repo"
KERNEL_SRC_DIR="$ROOT_DIR/camera/kernel"
OOPS_FILE="$ROOT_DIR/dmesg_load_ssdt.log"
VMLINUX="$KERNEL_SRC_DIR/vmlinux"
DECODE_SCRIPT="$KERNEL_SRC_DIR/scripts/decode_stacktrace.sh"

# Check if vmlinux and decode_stacktrace.sh exist
if [ ! -f "$VMLINUX" ]; then
    echo "Error: vmlinux not found in $KERNEL_SRC_DIR"
    exit 2
fi

if [ ! -f "$DECODE_SCRIPT" ]; then
    echo "Error: decode_stacktrace.sh not found in $KERNEL_SRC_DIR/scripts"
    exit 3
fi

if [ ! -f "$OOPS_FILE" ]; then
    echo "Error: $OOPS_FILE not found"
    exit 4
fi

# Run the decode script
bash "$DECODE_SCRIPT" "$VMLINUX" "$KERNEL_SRC_DIR" < "$OOPS_FILE"
