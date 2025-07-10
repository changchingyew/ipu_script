source ./env.sh
gst-launch-1.0 icamerasrc device-name=isx031-1 io-mode=1 printfps=true ! video/x-raw,format=UYVY,width=1920,height=1536 ! glimagesink
