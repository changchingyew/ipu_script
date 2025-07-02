source ./env.sh
gst-launch-1.0 icamerasrc num-vc=2 device-name=isx031x2-1 io-mode=1 printfps=true ! video/x-raw,format=UYVY,width=1920,height=1536 ! glimagesink icamerasrc num-vc=2 device-name=isx031x2-2 io-mode=1 printfps=true ! video/x-raw,format=UYVY,width=1920,height=1536 ! glimagesink
gst-launch-1.0 icamerasrc num-vc=2 device-name=isx031x2-3 io-mode=1 printfps=true ! video/x-raw,format=UYVY,width=1920,height=1536 ! glimagesink icamerasrc num-vc=2 device-name=isx031x2-4 io-mode=1 printfps=true ! video/x-raw,format=UYVY,width=1920,height=1536 ! glimagesink

