#!/bin/bash

echo "Listing V4L2 sub-device names from sysfs:"
for dev in /dev/v4l-subdev*; do
    if [ -e "$dev" ]; then
        sysfs_path=$(udevadm info --query=path --name="$dev")
        name=$(cat "/sys$sysfs_path/name" 2>/dev/null)
        echo "$dev: ${name:-Unknown}"
    fi
done

