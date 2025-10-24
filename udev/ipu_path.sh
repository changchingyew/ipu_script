#!/bin/sh
# set -x
# Example DEVPATH "/devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-1/i2c-INTC1139:00/i2c-28/i2c-INTC1138:00/i2c-44/i2c-INTC1031:00/video4linux/v4l-subdev12"

field_count=$(echo "$DEVPATH" | awk -F/ '{print NF}')

level0_field_id=5
level1_field_id=$((level0_field_id+2))
level2_field_id=$((level1_field_id+2))
level3_field_id=$((level2_field_id+2))

level0=$(echo "$DEVPATH" | awk -F/ "{print \$$level0_field_id}")
level1=$(echo "$DEVPATH" | awk -F/ "{print \$$level1_field_id}")
level2=$(echo "$DEVPATH" | awk -F/ "{print \$$level2_field_id}")
level3=$(echo "$DEVPATH" | awk -F/ "{print \$$level3_field_id}")

if [ "$field_count" -eq $((level0_field_id+2)) ]; then
    echo "${level0}/device"
elif [ "$field_count" -eq $((level1_field_id+2)) ]; then
    echo "${level0}/${level1}/device"
elif [ "$field_count" -eq $((level2_field_id+2)) ]; then
    echo "${level0}/${level1}/${level2}/device"
elif [ "$field_count" -eq $((level3_field_id+2)) ]; then
    echo "${level0}/${level1}/${level2}/${level3}"
fi