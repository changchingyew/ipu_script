set -x
FRAME_NUM=5
RESOLUTION=1920x1536
FMT=UYVY
FMT1=UYVY8_1X16

if [ "$1" = "ipu6epmtl" ]; then
    PRT1=0
    PRT2=4
elif [ "$1" = "ipu6ep" ]; then
    PRT1=1
    PRT2=2
elif [ "$1" = "ipu7" ]; then
    PRT1=2
    DES1="max96724 2-0027"
    SER1="max96717 32-0040"
    SER2="max96717 33-0040"
    SER3="max96717 34-0040"
    SER4="max96717 35-0040"
    SEN1="isx031 48-001a"
    SEN2="isx031 49-001a"
    SEN3="isx031 50-001a"
    SEN4="isx031 51-001a"
    IPU="Intel IPU7"
else
    echo "invalid platform!"
    exit 1
fi

#echo "file v4l2-subdev.c +p" > /sys/kernel/debug/dynamic_debug/control
#echo "file mc-entity.c +p" > /sys/kernel/debug/dynamic_debug/control
#echo "file ipu6-isys-csi2.c +p" > /sys/kernel/debug/dynamic_debug/control

CSI1="${IPU} CSI2 ${PRT1}"
# CSI2="${IPU} CSI2 ${PRT2}"
CAP1="${IPU} ISYS Capture $((PRT1 * 8))"
CAP2="${IPU} ISYS Capture $((PRT1 * 8 + 1))"
CAP3="${IPU} ISYS Capture $((PRT1 * 8 + 2))"
CAP4="${IPU} ISYS Capture $((PRT1 * 8 + 3))"
CAPTURE_DEV1=$(media-ctl -e "${CAP1}")
CAPTURE_DEV2=$(media-ctl -e "${CAP2}")
CAPTURE_DEV3=$(media-ctl -e "${CAP3}")
CAPTURE_DEV4=$(media-ctl -e "${CAP4}")

echo "SEN1:" $SEN1
echo "SEN2:" $SEN2
echo "SER1:" $SER1
echo "SER2:" $SER2
echo "DES1:" $DES1
echo "CSI1:" $CSI1
echo "CAP1:" $CAP1
echo "CAP2:" $CAP2

# declare -p
# media-ctl -r
# media-ctl -l "\"${SEN1}\":0 -> \"${SER1}\":0[1]"
# media-ctl -l "\"${SEN2}\":0 -> \"${SER2}\":0[1]"
# media-ctl -l "\"${SEN3}\":0 -> \"${SER3}\":0[1]"
# media-ctl -l "\"${SEN4}\":0 -> \"${SER4}\":0[1]"

# media-ctl -l "\"${SER1}\":2 -> \"${DES1}\":4[1]"
# media-ctl -l "\"${SER2}\":2 -> \"${DES1}\":5[1]"
# media-ctl -l "\"${SER3}\":2 -> \"${DES2}\":4[1]"
# media-ctl -l "\"${SER4}\":2 -> \"${DES2}\":5[1]"
# media-ctl -l "\"${DES1}\":0 -> \"${CSI1}\":0[1]"
# media-ctl -l "\"${DES2}\":0 -> \"${CSI2}\":0[1]"
media-ctl -l "\"${CSI1}\":1 -> \"${CAP1}\":0[1]"
media-ctl -l "\"${CSI1}\":2 -> \"${CAP2}\":0[1]"
media-ctl -l "\"${CSI1}\":3 -> \"${CAP3}\":0[1]"
media-ctl -l "\"${CSI1}\":4 -> \"${CAP4}\":0[1]"
# media-ctl -l "\"${CSI2}\":1 -> \"${CAP3}\":0[1]"
# media-ctl -l "\"${CSI2}\":2 -> \"${CAP4}\":0[1]"
# media-ctl -R "\"${SER1}\" [0/0->2/0[1]]"
# media-ctl -R "\"${SER2}\" [0/0->2/1[1]]"
# media-ctl -R "\"${SER3}\" [0/0->2/0[1]]"
# media-ctl -R "\"${SER4}\" [0/0->2/1[1]]"

media-ctl -R "\"${DES1}\" [0/0->4/0[1],1/0->4/1[1],2/0->4/2[1],3/0->4/3[1]]"
# media-ctl -R "\"${DES2}\" [4/0->0/0[1],5/1->0/1[1]]"
media-ctl -R "\"${CSI1}\" [0/0->1/0[1],0/1->2/0[1],0/2->3/0[1],0/3->4/0[1]]"
# media-ctl -R "\"${CSI2}\" [0/0->1/0[1],0/1->2/1[1]]"
media-ctl -V "\"${SEN1}\":0 [fmt:${FMT1}/${RESOLUTION}]"
media-ctl -V "\"${SEN2}\":0 [fmt:${FMT1}/${RESOLUTION}]"
media-ctl -V "\"${SEN3}\":0 [fmt:${FMT1}/${RESOLUTION}]"
media-ctl -V "\"${SEN4}\":0 [fmt:${FMT1}/${RESOLUTION}]"

media-ctl -V "\"${SER1}\":0/0 [fmt:${FMT1}/${RESOLUTION}]"
media-ctl -V "\"${SER1}\":1/0 [fmt:${FMT1}/${RESOLUTION}]"
media-ctl -V "\"${SER2}\":0/0 [fmt:${FMT1}/${RESOLUTION}]"
media-ctl -V "\"${SER2}\":1/0[fmt:${FMT1}/${RESOLUTION}]"
media-ctl -V "\"${SER3}\":0/0 [fmt:${FMT1}/${RESOLUTION}]"
media-ctl -V "\"${SER3}\":1/0 [fmt:${FMT1}/${RESOLUTION}]"
media-ctl -V "\"${SER4}\":0/0 [fmt:${FMT1}/${RESOLUTION}]"
media-ctl -V "\"${SER4}\":1/0 [fmt:${FMT1}/${RESOLUTION}]"

media-ctl -V "\"${DES1}\":4/0 [fmt:${FMT1}/${RESOLUTION}]"
media-ctl -V "\"${DES1}\":4/1 [fmt:${FMT1}/${RESOLUTION}]"
media-ctl -V "\"${DES1}\":4/2 [fmt:${FMT1}/${RESOLUTION}]"
media-ctl -V "\"${DES1}\":4/3 [fmt:${FMT1}/${RESOLUTION}]"

media-ctl -V "\"${DES1}\":0/0 [fmt:${FMT1}/${RESOLUTION}]"
media-ctl -V "\"${DES1}\":1/0 [fmt:${FMT1}/${RESOLUTION}]"
media-ctl -V "\"${DES1}\":2/0 [fmt:${FMT1}/${RESOLUTION}]"
media-ctl -V "\"${DES1}\":3/0 [fmt:${FMT1}/${RESOLUTION}]"

# media-ctl -V "\"${DES2}\":4/0 [fmt:${FMT1}/${RESOLUTION}]"
# media-ctl -V "\"${DES2}\":0/0 [fmt:${FMT1}/${RESOLUTION}]"
# media-ctl -V "\"${DES2}\":5/1 [fmt:${FMT1}/${RESOLUTION}]"
# media-ctl -V "\"${DES2}\":0/1 [fmt:${FMT1}/${RESOLUTION}]"
media-ctl -V "\"${CSI1}\":0/0 [fmt:${FMT1}/${RESOLUTION}]"
media-ctl -V "\"${CSI1}\":0/1 [fmt:${FMT1}/${RESOLUTION}]"
media-ctl -V "\"${CSI1}\":0/2 [fmt:${FMT1}/${RESOLUTION}]"
media-ctl -V "\"${CSI1}\":0/3 [fmt:${FMT1}/${RESOLUTION}]"
media-ctl -V "\"${CSI1}\":1/0 [fmt:${FMT1}/${RESOLUTION}]"
media-ctl -V "\"${CSI1}\":2/0 [fmt:${FMT1}/${RESOLUTION}]"
media-ctl -V "\"${CSI1}\":3/0 [fmt:${FMT1}/${RESOLUTION}]"
media-ctl -V "\"${CSI1}\":4/0 [fmt:${FMT1}/${RESOLUTION}]"
# media-ctl -V "\"${CSI2}\":0/0 [fmt:${FMT1}/${RESOLUTION}]"
# media-ctl -V "\"${CSI2}\":1/0 [fmt:${FMT1}/${RESOLUTION}]"
# media-ctl -V "\"${CSI2}\":0/1 [fmt:${FMT1}/${RESOLUTION}]"
# media-ctl -V "\"${CSI2}\":2/1 [fmt:${FMT1}/${RESOLUTION}]"

# echo 0xff > /sys/class/video4linux/$(basename $CAPTURE_DEV1)/dev_debug
yavta -f$FMT -s${RESOLUTION} --no-query "${CAPTURE_DEV1}"
yavta -f$FMT -s${RESOLUTION} --no-query "${CAPTURE_DEV2}"
yavta -f$FMT -s${RESOLUTION} --no-query "${CAPTURE_DEV3}"
yavta -f$FMT -s${RESOLUTION} --no-query "${CAPTURE_DEV4}"

yavta --data-prefix -c${FRAME_NUM} -n5 -I -s${RESOLUTION} --file=./dump/frame-#-gsml-a.bin -f $FMT ${CAPTURE_DEV1} &
yavta --data-prefix -c${FRAME_NUM} -n5 -I -s${RESOLUTION} --file=./dump/frame-#-gsml-b.bin -f $FMT ${CAPTURE_DEV2} &
yavta --data-prefix -c${FRAME_NUM} -n5 -I -s${RESOLUTION} --file=./dump/frame-#-gsml-c.bin -f $FMT ${CAPTURE_DEV3} &
yavta --data-prefix -c${FRAME_NUM} -n5 -I -s${RESOLUTION} --file=./dump/frame-#-gsml-d.bin -f $FMT ${CAPTURE_DEV4} &
