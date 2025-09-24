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
    IPU="Intel IPU7"
else
    echo "invalid platform!"
    exit 1
fi

CSI1="${IPU} CSI2 ${PRT1}"
# CSI2="${IPU} CSI2 ${PRT2}"

for i in {0..3}; do
    CAP[$i]="${IPU} ISYS Capture $((PRT1 * 8 + i))"
    CAPTURE_DEV[$i]=$(media-ctl -e "${CAP[$i]}")
    SER[$i]="max92717 $((32 + i))-0040"
    SEN[$i]="isx031 $((48 + i))-001a"
    echo "CAP[$i]:" ${CAP[$i]} "CAPTURE_DEV[$i]:" ${CAPTURE_DEV[$i]} "SER[$i]:" ${SER[$i]} "SEN[$i]:" ${SEN[$i]}
done

# declare -p
# media-ctl -r

for i in {0..3}; do
    media-ctl -l "\"${CSI1}\":$(($i+1)) -> \"${CAP[$i]}\":0[1]"
done


media-ctl -R "\"${DES1}\" [0/0->4/0[1],1/0->4/1[1],2/0->4/2[1],3/0->4/3[1]]"
# media-ctl -R "\"${DES2}\" [4/0->0/0[1],5/1->0/1[1]]"
media-ctl -R "\"${CSI1}\" [0/0->1/0[1],0/1->2/0[1],0/2->3/0[1],0/3->4/0[1]]"
# media-ctl -R "\"${CSI2}\" [0/0->1/0[1],0/1->2/1[1]]"

for i in {0..3}; do
    media-ctl -V "\"${SEN[$i]}\":0 [fmt:${FMT1}/${RESOLUTION}]"
    media-ctl -V "\"${SER[$i]}\":0/0 [fmt:${FMT1}/${RESOLUTION}]"
    media-ctl -V "\"${SER[$i]}\":1/0 [fmt:${FMT1}/${RESOLUTION}]"
    media-ctl -V "\"${DES1}\":$i/0 [fmt:${FMT1}/${RESOLUTION}]"
    media-ctl -V "\"${DES1}\":4/$i [fmt:${FMT1}/${RESOLUTION}]"
    media-ctl -V "\"${CSI1}\":0/$i [fmt:${FMT1}/${RESOLUTION}]"
    media-ctl -V "\"${CSI1}\":$(($i+1))/0 [fmt:${FMT1}/${RESOLUTION}]"
    yavta -f$FMT -s${RESOLUTION} --no-query "${CAPTURE_DEV[$i]}"
done

# echo 0xff > /sys/class/video4linux/$(basename $CAPTURE_DEV1)/dev_debug

for i in {0..3}; do
    yavta --data-prefix -c${FRAME_NUM} -n5 -I -s${RESOLUTION} --file=./dump/frame-#-gsml-$i.bin -f $FMT "${CAPTURE_DEV[$i]}" &
done