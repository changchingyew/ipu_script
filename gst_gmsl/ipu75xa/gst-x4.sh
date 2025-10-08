source ./env.sh

gst-launch-1.0 icamerasrc num-buffers=6000 num-vc=4 scene-mode=auto device-name=isx031x4-5 io-mode=mmap printfps=true ! 'video/x-raw,format=UYVY,width=1920,height=1536' ! glimagesink sync=false \
    icamerasrc num-buffers=6000 num-vc=4 scene-mode=auto device-name=isx031x4-6 io-mode=mmap printfps=true ! 'video/x-raw,format=UYVY,width=1920,height=1536' ! glimagesink sync=false \
    icamerasrc num-buffers=6000 num-vc=4 scene-mode=auto device-name=isx031x4-7 io-mode=mmap printfps=true ! 'video/x-raw,format=UYVY,width=1920,height=1536' ! glimagesink sync=false \
    icamerasrc num-buffers=6000 num-vc=4 scene-mode=auto device-name=isx031x4-8 io-mode=mmap printfps=true ! 'video/x-raw,format=UYVY,width=1920,height=1536' ! glimagesink sync=false
