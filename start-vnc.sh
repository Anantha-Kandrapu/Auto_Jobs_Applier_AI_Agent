#!/bin/bash
# Start X virtual framebuffer
Xvfb :99 -screen 0 1920x1080x16 &

# Start window manager
fluxbox &

# Start VNC server
x11vnc -forever -usepw -display :99 &

# Start noVNC web client
/usr/share/novnc/utils/launch.sh --vnc localhost:5900 &

# Start your Python script
python main.py
