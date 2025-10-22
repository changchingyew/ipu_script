source ./env.sh

SEN=isx031-1
# ISX=isx031-5
gst-launch-1.0 icamerasrc num-buffers=6000 scene-mode=auto device-name=$SEN io-mode=mmap printfps=true ! 'video/x-raw,format=UYVY,width=1920,height=1536' ! glimagesink sync=false