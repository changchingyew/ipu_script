source ./env.sh
gst-launch-1.0 icamerasrc device-name=isx031-1 io-mode=dma_mode printfps=true ! 'video/x-raw(memory:DMABuf)',width=1920,height=1536,drm-format=UYVY ! glimagesink
