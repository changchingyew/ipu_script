#!/bin/sh
# set -x
# Example sensor DEVPATH "/devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-1/i2c-INTC1139:00/i2c-28/i2c-INTC1138:00/i2c-44/i2c-INTC1031:00/video4linux/v4l-subdev12"


field_count=$(echo "$DEVPATH" | awk -F/ '{print NF}')

des_field_id=7
ser_field_id=$((des_field_id+2))
sen_field_id=$((ser_field_id+2))

des=$(echo "$DEVPATH" | awk -F/ "{print \$$des_field_id}")
if [ "$field_count" -eq $((sen_field_id+2)) ]; then
    sen=$(echo "$DEVPATH" | awk -F/ "{print \$$sen_field_id}")
    ser=$(echo "$DEVPATH" | awk -F/ "{print \$$ser_field_id}")
    echo "${des}/${ser}/${sen}"
elif [ "$field_count" -eq $((ser_field_id+2)) ]; then
    ser=$(echo "$DEVPATH" | awk -F/ "{print \$$ser_field_id}")
    echo "${des}/${ser}/device"
elif [ "$field_count" -eq $((des_field_id+2)) ]; then
    echo "${des}/device"
fi