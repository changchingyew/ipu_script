source ./env.sh

SEN=isx031x4
NR=1

gst-launch-1.0 icamerasrc num-buffers=6000 num-vc=4 scene-mode=auto device-name=$SEN-$NR io-mode=mmap printfps=true ! 'video/x-raw,format=UYVY,width=1920,height=1536' ! glimagesink sync=false \
    icamerasrc num-buffers=6000 num-vc=4 scene-mode=auto device-name=$SEN-$((NR+1)) io-mode=mmap printfps=true ! 'video/x-raw,format=UYVY,width=1920,height=1536' ! glimagesink sync=false \
    icamerasrc num-buffers=6000 num-vc=4 scene-mode=auto device-name=$SEN-$((NR+2)) io-mode=mmap printfps=true ! 'video/x-raw,format=UYVY,width=1920,height=1536' ! glimagesink sync=false \
    icamerasrc num-buffers=6000 num-vc=4 scene-mode=auto device-name=$SEN-$((NR+3)) io-mode=mmap printfps=true ! 'video/x-raw,format=UYVY,width=1920,height=1536' ! glimagesink sync=false
