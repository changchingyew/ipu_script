set -x
FRAME_NUM=50
RESOLUTION=1920x1536
FMT=UYVY
FMT1=UYVY8_1X16

if [ "$1" = "ipu6epmtl" ]; then
    PRT1=0
    PRT2=4
elif [ "$1" = "ipu6ep" ]; then
    PRT1=1
    PRT2=2
else
    echo "invalid platform!"
    exit 1
fi

ascii_base_value=$(printf "%d" "'a")
SEN1="isx031 8-001a"
SER1="max96717 6-0040"
DES1="max9296a 1-0048"
# SEN1="isx031 $(printf "\\$(printf '%03o' "$((ascii_base_value))")")-${PRT1}"
# SEN2="isx031 $(printf "\\$(printf '%03o' "$((ascii_base_value + 1))")")-${PRT1}"
# SEN3="isx031 $(printf "\\$(printf '%03o' "$((ascii_base_value))")")-${PRT2}"
# SEN4="isx031 $(printf "\\$(printf '%03o' "$((ascii_base_value + 1))")")-${PRT2}"
# SER1="max92717 $(printf "\\$(printf '%03o' "$((ascii_base_value))")")-${PRT1}"
# SER2="max92717 $(printf "\\$(printf '%03o' "$((ascii_base_value + 1))")")-${PRT1}"
# SER3="max92717 $(printf "\\$(printf '%03o' "$((ascii_base_value))")")-${PRT2}"
# SER4="max92717 $(printf "\\$(printf '%03o' "$((ascii_base_value + 1))")")-${PRT2}"
# DES1="max9296a $(printf "\\$(printf '%03o' "$((ascii_base_value + PRT1))")")"
# DES2="max9296a $(printf "\\$(printf '%03o' "$((ascii_base_value + PRT2))")")"
CSI1="Intel IPU6 CSI2 ${PRT1}"
# CSI2="Intel IPU6 CSI2 ${PRT2}"
CAP1="Intel IPU6 ISYS Capture $((PRT1 * 8))"
# CAP2="Intel IPU6 ISYS Capture $((PRT1 * 8 + 1))"
# CAP3="Intel IPU6 ISYS Capture $((PRT2 * 8))"
# CAP4="Intel IPU6 ISYS Capture $((PRT2 * 8 + 1))"
CAPTURE_DEV1=$(media-ctl -e "${CAP1}")
# CAPTURE_DEV2=$(media-ctl -e "${CAP2}")
# CAPTURE_DEV3=$(media-ctl -e "${CAP3}")
# CAPTURE_DEV4=$(media-ctl -e "${CAP4}")

echo "SEN1:" $SEN1
echo "SER1:" $SER1
echo "DES1:" $DES1
echo "CSI1:" $CSI1
echo "CAP1:" $CAP1

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
# media-ctl -l "\"${CSI1}\":1 -> \"${CAP1}\":0[1]"
# media-ctl -l "\"${CSI1}\":2 -> \"${CAP2}\":0[1]"
# media-ctl -l "\"${CSI2}\":1 -> \"${CAP3}\":0[1]"
# media-ctl -l "\"${CSI2}\":2 -> \"${CAP4}\":0[1]"
# media-ctl -R "\"${SER1}\" [0/0->2/0[1]]"
# media-ctl -R "\"${SER2}\" [0/0->2/1[1]]"
# media-ctl -R "\"${SER3}\" [0/0->2/0[1]]"
# media-ctl -R "\"${SER4}\" [0/0->2/1[1]]"
# media-ctl -R "\"${DES1}\" [4/0->0/0[1],5/1->0/1[1]]"
# media-ctl -R "\"${DES2}\" [4/0->0/0[1],5/1->0/1[1]]"
# media-ctl -R "\"${CSI1}\" [0/0->1/0[1],0/1->2/1[1]]"
# media-ctl -R "\"${CSI2}\" [0/0->1/0[1],0/1->2/1[1]]"
media-ctl -V "\"${SEN1}\":0 [fmt:${FMT1}/${RESOLUTION}]"
# media-ctl -V "\"${SEN2}\":0 [fmt:${FMT1}/${RESOLUTION}]"
# media-ctl -V "\"${SEN3}\":0 [fmt:${FMT1}/${RESOLUTION}]"
# media-ctl -V "\"${SEN4}\":0 [fmt:${FMT1}/${RESOLUTION}]"
media-ctl -V "\"${SER1}\":0/0 [fmt:${FMT1}/${RESOLUTION}]"

# media-ctl -V "\"${SER1}\":2/0 [fmt:${FMT1}/${RESOLUTION}]"
media-ctl -V "\"${SER1}\":1/0 [fmt:${FMT1}/${RESOLUTION}]"

# media-ctl -V "\"${SER2}\":0/0 [fmt:${FMT1}/${RESOLUTION}]"
# media-ctl -V "\"${SER2}\":2/1 [fmt:${FMT1}/${RESOLUTION}]"
# media-ctl -V "\"${SER3}\":0/0 [fmt:${FMT1}/${RESOLUTION}]"
# media-ctl -V "\"${SER3}\":2/0 [fmt:${FMT1}/${RESOLUTION}]"
# media-ctl -V "\"${SER4}\":0/0 [fmt:${FMT1}/${RESOLUTION}]"
# media-ctl -V "\"${SER4}\":2/1 [fmt:${FMT1}/${RESOLUTION}]"

# media-ctl -V "\"${DES1}\":4/0 [fmt:${FMT1}/${RESOLUTION}]"
media-ctl -V "\"${DES1}\":2/0 [fmt:${FMT1}/${RESOLUTION}]"

media-ctl -V "\"${DES1}\":0/0 [fmt:${FMT1}/${RESOLUTION}]"
# media-ctl -V "\"${DES1}\":5/1 [fmt:${FMT1}/${RESOLUTION}]"
# media-ctl -V "\"${DES1}\":0/1 [fmt:${FMT1}/${RESOLUTION}]"
# media-ctl -V "\"${DES2}\":4/0 [fmt:${FMT1}/${RESOLUTION}]"
# media-ctl -V "\"${DES2}\":0/0 [fmt:${FMT1}/${RESOLUTION}]"
# media-ctl -V "\"${DES2}\":5/1 [fmt:${FMT1}/${RESOLUTION}]"
# media-ctl -V "\"${DES2}\":0/1 [fmt:${FMT1}/${RESOLUTION}]"
media-ctl -V "\"${CSI1}\":0/0 [fmt:${FMT1}/${RESOLUTION}]"
media-ctl -V "\"${CSI1}\":1/0 [fmt:${FMT1}/${RESOLUTION}]"
media-ctl -V "\"${CSI1}\":0/1 [fmt:${FMT1}/${RESOLUTION}]"
# media-ctl -V "\"${CSI1}\":2/1 [fmt:${FMT1}/${RESOLUTION}]"
# media-ctl -V "\"${CSI2}\":0/0 [fmt:${FMT1}/${RESOLUTION}]"
# media-ctl -V "\"${CSI2}\":1/0 [fmt:${FMT1}/${RESOLUTION}]"
# media-ctl -V "\"${CSI2}\":0/1 [fmt:${FMT1}/${RESOLUTION}]"
# media-ctl -V "\"${CSI2}\":2/1 [fmt:${FMT1}/${RESOLUTION}]"

# Enable debug on capture device
echo 0xff > /sys/class/video4linux/$(basename $CAPTURE_DEV1)/dev_debug
yavta -f$FMT -s${RESOLUTION} --no-query "${CAPTURE_DEV1}"
# yavta -f$FMT -s${RESOLUTION} --no-query "${CAPTURE_DEV2}"
# yavta -f$FMT -s${RESOLUTION} --no-query "${CAPTURE_DEV3}"
# yavta -f$FMT -s${RESOLUTION} --no-query "${CAPTURE_DEV4}"
yavta --data-prefix -c${FRAME_NUM} -n5 -I -s${RESOLUTION} --file=./dump/frame-#-gsml-a.bin -f $FMT ${CAPTURE_DEV1}
# yavta --data-prefix -c${FRAME_NUM} -n5 -I -s${RESOLUTION} --file=./dump/frame-#-gsml-b.bin -f $FMT ${CAPTURE_DEV2} &
# yavta --data-prefix -c${FRAME_NUM} -n5 -I -s${RESOLUTION} --file=./dump/frame-#-gsml-c.bin -f $FMT ${CAPTURE_DEV3} &
# yavta --data-prefix -c${FRAME_NUM} -n5 -I -s${RESOLUTION} --file=./dump/frame-#-gsml-d.bin -f $FMT ${CAPTURE_DEV4} &
